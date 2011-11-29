Class {
	#name : #MJSQLImporterFromVisitor,
	#superclass : #Object,
	#instVars : [
		'sqlASTParser',
		'targetModel',
		'tables',
		'columns',
		'sqlASTVisitor',
		'databases',
		'alterTableStatements'
	],
	#category : #'Moose-SQL-Importer'
}

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor class >> on: aModel [
	^self new targetModel: aModel.
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> computeForeignKeys [

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
MJSQLImporterFromVisitor >> computePrimaryKeys [

	tables valuesDo: [:table | table constraints do: [:constr | 
			constr isPKConstraint ifTrue: [
				constr pkColumnNames do: [:attNames |
				(table columns select: [:col | col name = attNames]) first isPK: true]]]].

	
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> ensureAColumn: anASTColumnNode [
	| att constraint |
	
	att := FAMIXColumn new.
	att name: anASTColumnNode name.
	att type: anASTColumnNode type.
	
	constraint := anASTColumnNode constraints.
	
	constraint isNil not ifTrue: [
							att defaultValue: constraint defaultValue.
							att isUnique: constraint isUnique.
							att canBeNull: constraint canBeNull.
							att isPK: constraint isPK].

	^att
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> ensureATable: aTableNode [
	
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
MJSQLImporterFromVisitor >> ensureAnAlterTableStmt: anAlterTableStmtNode [
	alterTableStatements addLast: anAlterTableStmtNode.
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> ensureSelectStmtNode: aSelectStmtNode [
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> ensureTableConstraintNode: aTableConstraintNode [
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
MJSQLImporterFromVisitor >> importSQLCreateScriptFrom: aStream [
	| sqlScriptNodes scriptNode |
		
	sqlScriptNodes := (sqlASTParser parse: aStream) deepFlatten.
	
	self populateTargetModelFrom: (sqlScriptNodes collect: [:node | (node isKindOf: SQLASTNode) ifTrue: [ node accept: sqlASTVisitor]]).
	
	^self targetModel.
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> initialize [
	super initialize.
	
	sqlASTVisitor := SQLASTConcreteVisitor new importer: self.
	sqlASTParser := PetitSQLiteASTNodesParser new.
	
	tables := Dictionary new.
	columns := OrderedCollection new.
	alterTableStatements := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> populateTargetModelFrom: aCollectionOfEnsuredNodes [

	| dataBases counter aBlackBoard |
	
	dataBases := aCollectionOfEnsuredNodes select: [:aNode | aNode isMemberOf: FAMIXDataBase].
	alterTableStatements do: [:alterTable | self reifyAnAlterTableStatementFrom: alterTable.].  
	tables keysAndValuesDo: [:key :value | columns addAll: value columns].
	
	counter := 1.
	
	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1 
		to: (tables size + columns size)
		during: [ :bar | 
		
			counter := counter + 1.
			bar value: counter.
			bar value: 'Adding data base'.
			
			self targetModel addAll: dataBases.

			bar value: ('Adding ', tables size asString ,' tables').
			tables valuesDo: [:table | 
				self targetModel silentlyAdd: table.
				counter := counter + 1.
				bar value: counter].
			
			bar value: ('Adding' , columns size asString , 'attributes').	
			columns do: [:col |
				self targetModel silentlyAdd: col.
				counter := counter + 1.
				bar value: counter].	
				
			"connect columns and tables"
			self targetModel allTables do: [:table | table columns do: [:col | col ownerTable: table]].
			
			bar value: 'Computing foreign keys constraints'.
			self computePrimaryKeys.
			
			bar value: 'Computing foreign keys constraints'.			
			self targetModel silentlyAddAll: self computeForeignKeys.].
	
	^self targetModel
	
	

	
	
]

{ #category : #'as yet unclassified' }
MJSQLImporterFromVisitor >> reifyAnAlterTableStatementFrom: anAlterTableStmtNode [

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
MJSQLImporterFromVisitor >> reifyTableConstraintNodeFor: aTable From: aCollectionOfTableConstraints [
	^aCollectionOfTableConstraints do: [:constraint | 
		aTable addConstraint: (self ensureTableConstraintNode: constraint)].
]

{ #category : #accessing }
MJSQLImporterFromVisitor >> sqlASTParser [
	^ sqlASTParser
]

{ #category : #accessing }
MJSQLImporterFromVisitor >> sqlASTVisitor [
	^ sqlASTVisitor
]

{ #category : #accessing }
MJSQLImporterFromVisitor >> targetModel [
	^ targetModel
]

{ #category : #accessing }
MJSQLImporterFromVisitor >> targetModel: anObject [
	targetModel := anObject
]
