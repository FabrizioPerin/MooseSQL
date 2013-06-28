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
		'views',
		'indexes',
		'duplicatedTables',
		'duplicatedViews'
	],
	#category : #'Moose-SQL-Importer'
}

{ #category : #'as yet unclassified' }
MooseSQLiteImporter class >> on: aModel [
	^self new targetModel: aModel.
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> computeForeignKeys [

	| fkAssociations |

	fkAssociations := OrderedCollection new.

	tables valuesDo: [:table | table constraints do: [:constr | 
			constr isFKConstraint ifTrue: [
				| referencedTable |
				referencedTable := tables at: constr referencedTableName ifAbsent: [constr inspect. DialogWindow new alert: 'FK constraint refer to a not existing table'].
				
				"set as foreign key the columns of the table having the constraint"
				(1 to: (constr pkColumnNames size)) do: [:index |
					| fkTableColumn referencedTableColumn fkAssoc |
					fkTableColumn := table columns select: [:col | col name = (constr fkColumnNames at: index)].
					fkTableColumn isEmpty 
						ifFalse: [ 
							referencedTableColumn := referencedTable columns select: [:col | col name = (constr pkColumnNames at: index)].
							referencedTableColumn isEmpty
								ifFalse: [ 
									fkTableColumn first isFK: true.
						
									"creation of the association"	
									fkAssoc := FAMIXFKAssociation new targetColumn: referencedTableColumn first; sourceColumn: fkTableColumn first.
									referencedTableColumn first addReferencedBy: fkAssoc.
									fkTableColumn first addReferences: fkAssoc.
					
									fkAssociations add: fkAssoc ] ] ] ] ] ].
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
		| columnCollection indexing |
		columnCollection := index indexedTable columns select: [:each | each name = columnName first ].
		columnCollection isEmpty
			ifFalse: [ 
				indexing := FAMIXSQLIndexing new.
				indexing index: index.
				indexing column: columnCollection first ] ].
	
	indexes 
			at: index name
			ifPresent: [:each | ] 
			ifAbsent: [indexes at: index name put: index].
	
	^index
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> ensureATable: aTableNode [
	
	| tab |

	tab := FAMIXTable new name: aTableNode name.
	tab completeName: aTableNode completeName.
	
	tab columns: (aTableNode columns collect: [:aColumnNode | aColumnNode accept: sqlASTVisitor]) asMooseGroup. 

	"setting up the primary keys"
	aTableNode constraints do: [:aConstraintNode |
		| constNode |
		aConstraintNode isArray
			ifTrue: [constNode := aConstraintNode second]
			ifFalse: [constNode := aConstraintNode].

		tab addConstraint: (constNode accept: sqlASTVisitor).
		"constraint isPKConstraint ifTrue: [constraint pkColumnsName do: [:attNames |
				(tab columns select: [:col | col name = attNames]) first isPK: true]]"].

	tables 
		at: tab completeName 
		ifPresent: [:table | 
			duplicatedTables 
					at: tab completeName 
					ifPresent: [:counter | duplicatedTables at: tab completeName  put: (counter + 1) ] 
					ifAbsent: [duplicatedTables at: tab completeName  put: 1]. ] 
		ifAbsent: [tables at: tab completeName  put: tab].
		
	^tab
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> ensureAView: aCreateViewNode [

	| view |

	view := FAMIXView new name: aCreateViewNode name.
	view completeName: aCreateViewNode completeName.
	
	(aCreateViewNode ofTables select: [ :each | each isKindOf: String ])
		do: [ :each |
			tables 
				at: each
				ifPresent: [ :table | self ensureViewAssociationFrom: view to: table ]
				ifAbsent: [ views 
								at: each
								ifPresent: [ :anotherView | self ensureViewAssociationFrom: view to: anotherView ]
								ifAbsent: [ view addMissingTableName: each ] ] ].
	
	views 
		at: view completeName
		ifPresent: [:table | 
			duplicatedViews
					at: view completeName 
					ifPresent: [:counter | duplicatedViews at: view completeName  put: (counter + 1) ] 
					ifAbsent: [duplicatedViews at: view completeName  put: 1] ]
		ifAbsent: [tables at: view completeName put: view].
		
	^view
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
MooseSQLiteImporter >> ensureViewAssociationFrom: view to: table [
	| assoc |
	
	assoc := FAMIXViewAssociation new
				table: table;
				view: view;
				yourself.
	
	self targetModel silentlyAdd: assoc
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
	views := Dictionary new.
	indexes := Dictionary new.
	duplicatedViews := Dictionary new.
	duplicatedTables := Dictionary new.
	
]

{ #category : #'as yet unclassified' }
MooseSQLiteImporter >> populateTargetModelFrom: aCollectionOfEnsuredNodes [

	| dataBases |
	
	dataBases := aCollectionOfEnsuredNodes select: [:aNode | aNode isMemberOf: FAMIXDataBase].
	alterTableStatements do: [:alterTable | self reifyAnAlterTableStatementFrom: alterTable.].  
	tables keysAndValuesDo: [:key :value | columns addAll: value columns].

	MooseCustomTask
		runWithProgress: [: bar |
			self targetModel addAll: dataBases.
			bar increment.
			
			tables valuesDo: [:table | 
				self targetModel silentlyAdd: table.
				bar increment].

			views valuesDo: [:table | 
				self targetModel silentlyAdd: table.
				bar increment].

			columns do: [:col |
				self targetModel silentlyAdd: col.
				bar increment].	

			indexes valuesDo: [:index | 
				self targetModel silentlyAdd: index.
				bar increment].
			
			"connect columns and tables"
			self targetModel allTables do: [:table | table columns do: [:col | col ownerTable: table]].
			
			"adding table's constraint to the model"
			self targetModel allTables do: [:table | self targetModel silentlyAddAll: table constraints ].
			
			self computePrimaryKeys.
	
			self targetModel silentlyAddAll: self computeForeignKeys.
			
			self reifyMissingTableNames]
		description: 'Importing DB From an SQL file'
		length: ( tables size + columns size + views size + indexes size ) + 1.
			
	
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
MooseSQLiteImporter >> reifyMissingTableNames [

	views valuesDo: [ :view |
		view missingTableNames do:[ :name | 
			tables 
				at: CategoryRenamed 
				ifPresent: [ :table | self ensureViewAssociationFrom: view to: table ]
				ifAbsent: [ views 
								at: AGroupHasBeenRenamed 
								ifPresent: [ :anotherView | self ensureViewAssociationFrom: view to: anotherView ]
								ifAbsent: [ self halt ] ] ].
		view missingTableNames: nil ]
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
