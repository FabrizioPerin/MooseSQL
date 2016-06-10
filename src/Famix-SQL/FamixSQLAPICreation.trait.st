Trait {
	#name : #FamixSQLAPICreation,
	#category : #'Famix-SQL-Tests'
}

{ #category : #'as yet unclassified' }
FamixSQLAPICreation >> addFromTables: aColOfTables into: aRequest [
	aColOfTables do: [ :t | 
		aRequest addFromClause: (self createExpressionReferencingTable: t) ].
	^aRequest.
]

{ #category : #'as yet unclassified' }
FamixSQLAPICreation >> addSelectColumns: aColOfColumns into: aRequest [
	aColOfColumns do: [ :col | 
		aRequest addSelectClause: (self createExpressionReferencingColumn: col) ].
	^aRequest.
]

{ #category : #'as yet unclassified' }
FamixSQLAPICreation >> addWhereColumns: aColOfColumns into: aRequest [
	| whereExp |
	whereExp := self createUnnamed: FAMIXSQLExpression.
	aRequest addWhereClause: whereExp.
	aColOfColumns do: [ :col | 
		 whereExp referencedExpressions add: (self createExpressionReferencingColumn: col) ].
	^aRequest 
]

{ #category : #'creation api' }
FamixSQLAPICreation >> create: aFamixEntityClass withName: aString [

	^aFamixEntityClass new mooseModel: self model; name: aString ; yourself.
]

{ #category : #'creation api' }
FamixSQLAPICreation >> createExpressionReferencingColumn: aCol [
	| exp |
	exp := self createUnnamed: FAMIXSQLExpression.
	FAMIXExpressionToColumnAssociation new sourceExpression: exp ; targetColumn: aCol.
	^exp.
]

{ #category : #'creation api' }
FamixSQLAPICreation >> createExpressionReferencingColumnNamed: aName [
	| exp |
	exp := self createUnnamed: FAMIXSQLExpression.
	exp referencedColumns add: (FAMIXExpressionToColumnAssociation new sourceExpression: exp ; targetColumn: (self create: FAMIXColumn withName: aName) ; mooseModel: self model ; yourself).
	^exp.
]

{ #category : #'creation api' }
FamixSQLAPICreation >> createExpressionReferencingTable: aFamixTable [

	^FAMIXSQLExpression new mooseModel: self model; referencedTable: aFamixTable ; yourself.
]

{ #category : #'creation api' }
FamixSQLAPICreation >> createTableNamed: aString withColumnsNamed: aCollection [
	|table|
	table := self create: FAMIXTable withName: aString.
	aCollection do: [ :aName | (self create: FAMIXColumn withName: aName) ownerTable: table ].
	^table
]

{ #category : #'as yet unclassified' }
FamixSQLAPICreation >> createUnnamed: aFamixEntityClass [

	^aFamixEntityClass new mooseModel: self model; yourself.
]
