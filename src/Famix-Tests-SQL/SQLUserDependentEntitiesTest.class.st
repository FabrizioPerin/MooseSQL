Class {
	#name : #SQLUserDependentEntitiesTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Famix-Tests-SQL'
}

{ #category : #helpers }
SQLUserDependentEntitiesTest >> addFromTables: aColOfTables into: aRequest [
	aColOfTables do: [ :t | 
		aRequest addFromClause: (self createExpressionReferencingTable: t) ].
	^aRequest.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> addSelectColumns: aColOfColumns into: aRequest [
	aColOfColumns do: [ :col | 
		aRequest addSelectClause: (self createExpressionReferencingColumn: col) ].
	^aRequest.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> addWhereColumns: aColOfColumns into: aRequest [
	| whereExp |
	whereExp := self createUnnamed: FAMIXSQLExpression.
	aRequest addWhereClause: whereExp.
	aColOfColumns do: [ :col | 
		 whereExp referencedExpressions add: (self createExpressionReferencingColumn: col) ].
	^aRequest 
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> create: aFamixEntityClass withName: aString [

	^aFamixEntityClass new mooseModel: model; name: aString ; yourself.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> createExpressionReferencingColumn: aCol [
	| exp |
	exp := self createUnnamed: FAMIXSQLExpression.
	exp referencedColumns add: (FAMIXExpressionToColumnAssociation new sourceExpression: exp ; targetColumn: aCol ; mooseModel: model ; yourself).
	^exp.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> createExpressionReferencingColumnNamed: aName [
	| exp |
	exp := self createUnnamed: FAMIXSQLExpression.
	exp referencedColumns add: (self create: FAMIXColumn withName: aName).
	^exp.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> createExpressionReferencingFunctionNamed: aName [
	| exp |
	exp := self createUnnamed: FAMIXSQLExpression.
	exp referencedFunctions add: (self create: FAMIXFunction withName: aName).
	^exp.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> createExpressionReferencingTable: aFamixTable [

	^FAMIXSQLExpression new mooseModel: model; referencedTable: aFamixTable ; yourself.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> createTableNamed: aString withColumnsNamed: aCollection [
	|table|
	table := self create: FAMIXTable withName: aString.
	aCollection do: [ :aName | (self create: FAMIXColumn withName: aName) ownerTable: table ].
	^table
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> createUnnamed: aFamixEntityClass [

	^aFamixEntityClass new mooseModel: model; yourself.
]

{ #category : #running }
SQLUserDependentEntitiesTest >> setUp [
	model := MooseModel new.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> testDependentEntitiesForTable [
	| table |
	table := self createTableNamed: 'foo' withColumnsNamed: { 'a' . 'b' . 'c' } .
	self assert: table dependentEntities isEmpty.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> testDependentEntitiesForView [
	| table col1 col2 col3 view rq|
	
	table := self create: FAMIXTable withName: 'table'.
	col1 := self create: FAMIXColumn withName: 'col1'.
	col2 := self create: FAMIXColumn withName: 'col2'.
	col3 := self create: FAMIXColumn withName: 'col3'.
	table addColumn: col1.
	table addColumn: col2.
	table addColumn: col3.
	
	view := self create: FAMIXView withName: 'view'.
	rq := self createUnnamed: FAMIXSelectRequest. 
	self addSelectColumns: { col1  } into: rq.
	self addFromTables: { table } into: rq.
	self addWhereColumns: { col2 } into: rq.
	view query: rq.  
	self assert: table dependentEntities isEmpty.
	self assert: view dependentEntities size equals: 3.
	self assert: table userEntities size equals: 1.
	self assert: view userEntities isEmpty.
]

{ #category : #helpers }
SQLUserDependentEntitiesTest >> testParentSQLEntity [
	| table col1 col2 col3 view rq |
	
	table := self create: FAMIXTable withName: 'table'.
	col1 := self create: FAMIXColumn withName: 'col1'.
	col2 := self create: FAMIXColumn withName: 'col2'.
	col3 := self create: FAMIXColumn withName: 'col3'.
	table addColumn: col1.
	table addColumn: col2.
	table addColumn: col3.
	
	view := self create: FAMIXView withName: 'view'.
	rq := self createUnnamed: FAMIXSelectRequest. 
	self addSelectColumns: { col1  } into: rq.
	self addFromTables: { table } into: rq.
	self addWhereColumns: { col2 } into: rq.
	view query: rq.  
	self assert: table dependentEntities isEmpty.
	self assert: view dependentEntities size equals: 3.
	self assert: table userEntities size equals: 1.
	self assert: view userEntities isEmpty.
]
