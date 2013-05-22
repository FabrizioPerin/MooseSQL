Class {
	#name : #MooseSQLiteImporter,
	#superclass : #Object,
	#instVars : [
		'sqlASTParser',
		'targetModel',
		'tables',
		'columns',
		'sqlASTVisitor',
		'databases',
		'alterTableStatements',
		'indexes'
	],
	#category : #'Moose-SQL-Importer'
}

{ #category : #'as yet unclassified' }
MooseSQLiteImporter class >> on: aModel [
	^self new targetModel: aModel.
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> computeForeignKeys [

	| fkAssociations dbTables aDraftObjectTableGroup |

	fkAssociations := OrderedCollection new.

	tables valuesDo: [:table | table constraints do: [:constr | 
			constr isFKConstraint ifTrue: [
				| referencedTable |
				referencedTable := tables at: constr referencedTableName ifAbsent: [constr inspect. DialogWindow new alert: 'FK constraint refer to a not existing table'].
				
				"set as foreign key the columns of the table having the constraint"
				(1 to: (constr pkColumnNames size)) do: [:index |
					| fkTableColumn referencedTableColumn fkAssoc |
					fkTableColumn := 	(table columns select: [:col | col name = (constr fkColumnNames at: index)]) first.
					referencedTableColumn := (referencedTable columns select: [:col | col name = (constr pkColumnNames at: index)] )first.
					fkTableColumn isFK: true.
						
					"creation of the association"	
					fkAssoc := FAMIXFKAssociation new targetColumn: referencedTableColumn; sourceColumn: fkTableColumn.
					referencedTableColumn addReferencedBy: fkAssoc.
					fkTableColumn addReferences: fkAssoc.
					
					fkAssociations add: fkAssoc.	
					]]]].
	^fkAssociations.
	
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> computePrimaryKeys [

	tables valuesDo: [:table | table constraints do: [:constr | 
			constr isPKConstraint ifTrue: [
				constr pkColumnNames do: [:attNames |
				(table columns select: [:col | col name = attNames]) first isPK: true]]]].

	
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> ensureAColumn: anASTColumnNode [
	| att constraints |
	
	att := FAMIXColumn new.
	att name: anASTColumnNode name.
	att type: anASTColumnNode type.
	
	constraints := anASTColumnNode constraints.
	
	constraints do: [:constraint |
							att defaultValue: constraint defaultValue.
							att isUnique: constraint isUnique.
							att canBeNull: constraint canBeNull.
							att isPK: constraint isPK].

	^att
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> ensureASQLIndex: aCreateIndexNode [
	| index |

	index := FAMIXSQLIndex new.
	
	index name: aCreateIndexNode indexName.
	
	index indexedTable: (tables 
							at: aCreateIndexNode referenceTable
							ifAbsent: [aCreateIndexNode referenceTable]).
	
	index isUnique: aCreateIndexNode isUnique.
	
	aCreateIndexNode indexedColumnNames do: [:columnName |
		| column indexing |
		column := (index indexedTable columns select: [:each | each name = columnName ]) first.
		indexing := FAMIXSQLIndexing new.
		indexing index: index.
		indexing column: column ].
	
	indexes 
			at: index name
			ifPresent: [:each | DialogWindow new alert: 'Index already exists.'] 
			ifAbsent: [indexes at: index name put: index].
	
	^index
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> ensureATable: aTableNode [
	
	| tab |

	tab := FAMIXTable new name: aTableNode name.
	tab columns: (aTableNode columns collect: [:aColumnNode | aColumnNode accept: sqlASTVisitor]) asMooseGroup. 

	"setting up the primary keys"
	aTableNode constraints do: [:aConstraintNode |
		| constraint constNode |
		aConstraintNode isArray
			ifTrue: [constNode := aConstraintNode second]
			ifFalse: [constNode := aConstraintNode].

		tab addConstraint: (constNode accept: sqlASTVisitor).
		"constraint isPKConstraint ifTrue: [constraint pkColumnsName do: [:attNames |
				(tab columns select: [:col | col name = attNames]) first isPK: true]]"].
	
	tables 
		at: tab name 
		ifPresent: [:table | DialogWindow new alert: 'Table missed because there is another table with the same name.'] 
		ifAbsent: [tables at: tab name put: tab].
		
	^tab
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> ensureAView: anIndexNode [
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> ensureAnAlterTableStmt: anAlterTableStmtNode [
	alterTableStatements addLast: anAlterTableStmtNode.
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> ensureSelectStmtNode: aSelectStmtNode [
	
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> ensureTableConstraintNode: aTableConstraintNode [
	| newConstr |

	newConstr := FAMIXSQLConstraint new.

	newConstr isPKConstraint: aTableConstraintNode isPKConstraint.
	newConstr isFKConstraint: aTableConstraintNode isFKConstraint.
	newConstr isUnique: aTableConstraintNode isUnique.
	newConstr isCheck: aTableConstraintNode isCheck.
		
	newConstr isPKConstraint ifTrue: [aTableConstraintNode pkColumnNames do: [:each | newConstr addPKColumnName: each ]].
	newConstr isUnique ifTrue: [aTableConstraintNode uniqueColumnNames do: [:each | newConstr addUniqueColumnName: each ]].
	newConstr isFKConstraint ifTrue: [
		newConstr referencedTableName: aTableConstraintNode referencedTableName.
		aTableConstraintNode fkColumnNames do: [:each | newConstr addFKColumnName: each ].
		aTableConstraintNode pkColumnNames do: [:each | newConstr addPKColumnName: each ]].
	newConstr isCheck ifTrue: [newConstr expressionString: aTableConstraintNode expressionString].
	
	^newConstr
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> importSQLCreateScriptFrom: aStream [
	| sqlScriptNodes scriptNode |
		
	sqlScriptNodes := (sqlASTParser parse: aStream asPetitStream) deepFlatten.
	
	self populateTargetModelFrom: (sqlScriptNodes collect: [:node | (node isKindOf: SQLASTNode) ifTrue: [ node accept: sqlASTVisitor]]).
	
	^self targetModel.
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> initialize [
	super initialize.
	
	sqlASTVisitor := SQLASTConcreteVisitor new importer: self.
	sqlASTParser := PetitSQLiteASTNodesParser new.
	
	tables := Dictionary new.
	columns := OrderedCollection new.
	alterTableStatements := OrderedCollection new.
	indexes := Dictionary new.
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> populateTargetModelFrom: aCollectionOfEnsuredNodes [

	| dataBases |
	
	dataBases := aCollectionOfEnsuredNodes select: [:aNode | aNode isMemberOf: FAMIXDataBase].
	alterTableStatements do: [:alterTable | self reifyAnAlterTableStatementFrom: alterTable.].  
	tables keysAndValuesDo: [:key :value | columns addAll: value columns].

	MooseCustomTask
		runWithProgress: [: bar |

			bar increment.
						
			self targetModel addAll: dataBases.

			"bar description: ('Adding ', tables size asString ,' tables')."
			tables valuesDo: [:table | 
				self targetModel silentlyAdd: table.
				bar increment].
			
			"bar description: ('Adding' , columns size asString , 'attributes')."
			columns do: [:col |
				self targetModel silentlyAdd: col.
				bar increment].	
				
			"connect columns and tables"
			self targetModel allTables do: [:table | table columns do: [:col | col ownerTable: table]].
			
			"adding table's constraint to the model"
			self targetModel allTables do: [:table | self targetModel silentlyAddAll: table constraints ].
			
			"bar value: 'Computing primary keys constraints'."
			self computePrimaryKeys.
			
			"bar value: 'Computing foreign keys constraints'."			
			self targetModel silentlyAddAll: self computeForeignKeys.]
		description: 'Importing DB From an SQL file'
		length: (tables size + columns size) + 1.
			
	
	^self targetModel
	
	

	
	
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> reifyAnAlterTableStatementFrom: anAlterTableStmtNode [

	anAlterTableStmtNode isRename ifTrue: [
		tables 
			at: anAlterTableStmtNode nameOfTableToAlter 
			ifPresent: [:value |
				tables at: anAlterTableStmtNode newTableName ifAbsentPut: [value name: anAlterTableStmtNode newTableName].
				tables removeKey: anAlterTableStmtNode nameOfTableToAlter ]
			ifAbsent: [DialogWindow new alert: 'Alter Table statement defined on a table not present.']].
		
	anAlterTableStmtNode isAddConstraint ifTrue: [
		tables 
			at: anAlterTableStmtNode nameOfTableToAlter 
			ifPresent: [:value |
					self reifyTableConstraintNodeFor: value From: anAlterTableStmtNode constraints]
			ifAbsent: [DialogWindow new alert: 'Alter Table statement defined on a table not present.']].
	  
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> reifyTableConstraintNodeFor: aTable From: aCollectionOfTableConstraints [
	^aCollectionOfTableConstraints do: [:constraint | 
		aTable addConstraint: (self ensureTableConstraintNode: constraint)].
]

{ #category : #accessing }
MooseSQLiteImporter >> sqlASTParser [
	^ sqlASTParser
]

{ #category : #accessing }
MooseSQLiteImporter >> sqlASTVisitor [
	^ sqlASTVisitor
]

{ #category : #accessing }
MooseSQLiteImporter >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MooseSQLiteImporter >> targetModel: anObject [
	targetModel := anObject
]
