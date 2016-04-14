"
I am providing method to help with entity creation.
"
Trait {
	#name : #TEntityCreator,
	#category : #'Famix-SQL-Creator'
}

{ #category : #creating }
TEntityCreator >> create: aFamixEntityClass withName: aString model: model [

	^ (self createUnnamed: aFamixEntityClass withModel: model)
			name: aString;
			yourself.
]

{ #category : #creating }
TEntityCreator >> createExpressionReferencingColumnNamed: aName withModel: model [
	| exp |
	exp := self createUnnamed: FAMIXSQLExpression withModel: model.
	exp referencedColumns add: (self create: FAMIXColumn withName: aName model: model).
	^exp.
]

{ #category : #creating }
TEntityCreator >> createExpressionReferencingTable: aFamixTable withModel: model [

	^ FAMIXSQLExpression new
			mooseModel: model;
			referencedTable: aFamixTable;
			yourself.
]

{ #category : #creating }
TEntityCreator >> createTableNamed: aString withColumnsNamed: aCollection model: model [
	|table|
	table := self create: FAMIXTable withName: aString model: model.
	aCollection do: [ :aName | (self create: FAMIXColumn withName: aName) ownerTable: table ].
	^ table
]

{ #category : #creating }
TEntityCreator >> createUnnamed: aFamixEntityClass withModel: model [
	^ aFamixEntityClass new
			mooseModel: model;
			yourself.
]
