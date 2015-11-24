"
A FAMIXSQLFunction corresponds to an integrated function. 

    Instance Variables
	referencedBy:		Entities referencing the given function
	referencedColumns:		columns referenced by the function
	referencedFunctions:		functions referenced by the function
	referencedTables:		Tables referenced by the function
	calledFromColumns: columns calling the function in their definition 
	calledFromFunctions: functions calling the function (self) in their definition
	calledFromTriggers: triggers calling the function
	sqlParameters:		formal parameters declared by this behaviour

"
Class {
	#name : #FAMIXSQLFunction,
	#superclass : #FAMIXBehaviouralEntity,
	#instVars : [
		'sqlParameters',
		'referencedBy',
		'referencedColumns',
		'referencedTables',
		'referencedFunctions',
		'calledFromColumns',
		'calledFromFunctions',
		'calledFromTriggers',
		'default',
		'language',
		'aggregateAsFfunction',
		'aggregateAsSfunction',
		'usedAggregates'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'initialize-release' }
FAMIXSQLFunction class >> annotation [
	<MSEClass: #SQLFunction super: #FAMIXBehaviouralEntity>
	<package: #FAMIX>
	^self
]

{ #category : #adding }
FAMIXSQLFunction >> addDependencyIfNotExistFrom: aColumnOrAFunction [
	aColumnOrAFunction addDependencyIfNotExistFromFunction: self.
]

{ #category : #adding }
FAMIXSQLFunction >> addDependencyIfNotExistFromColumn: aFAMIXColumn [ 
	aFAMIXColumn addDependencyIfNotExistToFunction: self
]

{ #category : #adding }
FAMIXSQLFunction >> addDependencyIfNotExistFromFunction: aFAMIXSQLFunction [ 
	aFAMIXSQLFunction addDependencyIfNotExistToFunction: self
]

{ #category : #adding }
FAMIXSQLFunction >> addDependencyIfNotExistTo: aFAMIXSQLFunctionOrTableOrColumn [
	aFAMIXSQLFunctionOrTableOrColumn addDependencyIfNotExistFromFunction: self
]

{ #category : #adding }
FAMIXSQLFunction >> addDependencyIfNotExistToAggregate: aFAMIXAggregate [
	^ FAMIXFunctionToAggregateAssociation new
		aggregate: aFAMIXAggregate;
		function: self;
		mooseModel: self mooseModel
]

{ #category : #adding }
FAMIXSQLFunction >> addDependencyIfNotExistToColumn: aFAMIXColumn [ 
	^ self mooseModel entities detect: [ :e | e isAssociation and: [ e from = self and: [ e to = aFAMIXColumn ] ] ] ifNone: [FAMIXFunctionToColumnAssociation new targetColumn: aFAMIXColumn ; sourceFunction: self; mooseModel: self mooseModel]
]

{ #category : #adding }
FAMIXSQLFunction >> addDependencyIfNotExistToFunction: aFAMIXSQLFunction [ 
	^ self mooseModel entities detect: [ :e | e isAssociation and: [ e from = self and: [ e to = aFAMIXSQLFunction ] ] ] ifNone: [FAMIXFunctionToFunctionAssociation new sourceFunction: self; targetFunction: aFAMIXSQLFunction; mooseModel: self mooseModel]
]

{ #category : #adding }
FAMIXSQLFunction >> addDependencyIfNotExistToTable: aFAMIXTable [ 
	^ self mooseModel entities detect: [ :e | e isAssociation and: [ e from = self and: [ e to = aFAMIXTable ] ] ] ifNone: [FAMIXFunctionToTableAssociation new table: aFAMIXTable ; function: self; mooseModel: self mooseModel]
]

{ #category : #adding }
FAMIXSQLFunction >> addReferencedColumn: aFAMIXColumn [
	self referencedColumns add: aFAMIXColumn
]

{ #category : #adding }
FAMIXSQLFunction >> addReferencedColumns: aListOfColumns [
	aListOfColumns do: [ :each |
		self addReferencedColumn: each ]
]

{ #category : #accessing }
FAMIXSQLFunction >> aggregateAsFfunction [
	<MSEProperty: #aggregateAsFfunction type: #FAMIXAggregate opposite: #ffunction>
	<MSEComment: 'The aggregate calling by the function as final function.'>
	
	^ aggregateAsFfunction
]

{ #category : #accessing }
FAMIXSQLFunction >> aggregateAsFfunction: anObject [
	aggregateAsFfunction := anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> aggregateAsSfunction [
	<MSEProperty: #aggregateAsSfunction type: #FAMIXAggregate opposite: #sfunction>
	<MSEComment: 'The aggregate calling by the function as state function.'>
	
	^ aggregateAsSfunction
]

{ #category : #accessing }
FAMIXSQLFunction >> aggregateAsSfunction: anObject [
	aggregateAsSfunction := anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> belongsTo [
	<MSEProperty: #ownerDataBase type: #FAMIXDataBase> <derived>
	<MSEComment: 'Database containing the table'>
	

	^self ownerDataBase
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromColumns [
	<MSEProperty: #calledFromColumns type: #FAMIXColumnToFunctionAssociation  opposite: #targetFunction>
	<MSEComment: 'Column referencing the function.'>
	^ calledFromColumns
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromColumns: anObject [
	calledFromColumns := anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromFunctions [
	<MSEProperty: #calledFromFunctions type: #FAMIXFunctionToFunctionAssociation  opposite: #targetFunction>
	<MSEComment: 'Functions referencing the function.'>
	^ calledFromFunctions
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromFunctions: anObject [
	calledFromFunctions := anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromTriggers [
	<MSEProperty: #calledFromTriggers type: #FAMIXTrigger opposite: #invokedFunction> <multivalued> 
	<MSEComment: 'Trigger calling the function.'>
	^ calledFromTriggers
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromTriggers: anObject [
	calledFromTriggers := anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> default [
	<MSEProperty: #default type: #FAMIXDefaultValueConstraint opposite: #function> 
	<MSEComment: 'Default constraint calling the SQL or pgpsql function'>
	^ default
]

{ #category : #accessing }
FAMIXSQLFunction >> default: anObject [
	default := anObject
]

{ #category : #querying }
FAMIXSQLFunction >> dependentEntities [
	^ (self dependentTables, self dependentFunctions) asSet
]

{ #category : #'accessing-computed' }
FAMIXSQLFunction >> dependentFunctions [
	<navigation: #dependentFunctions>
	^self
		lookUpPropertyNamed: #dependentFunctions
		computedAs:[(self queryOutgoing: FAMIXFunctionToFunctionAssociation ) atScope: FAMIXSQLFunction]
]

{ #category : #'accessing-computed' }
FAMIXSQLFunction >> dependentTables [
	<navigation: #dependentTables>
	^self
		lookUpPropertyNamed: #dependentTables
		computedAs:[
			| result |
			result := Set new.
			
				result addAll: ((self queryOutgoing: FAMIXFunctionToColumnAssociation) atScope: FAMIXTable).
				result addAll: ((self queryOutgoing: FAMIXFunctionToTableAssociation ) atScope: FAMIXTable)]
]

{ #category : #'initialize-release' }
FAMIXSQLFunction >> initialize [
	super initialize.
	sqlParameters := FMMultivalueLink on: self opposite: #parentBehaviouralEntity:.
	referencedBy := FMMultivalueLink on: self opposite: #targetFunction:.
	referencedColumns := FMMultivalueLink on: self opposite: #sourceFunction:.
	referencedFunctions := FMMultivalueLink on: self opposite: #sourceFunction:.
	referencedTables := FMMultivalueLink on: self opposite: #function:.
	calledFromColumns := FMMultivalueLink on: self opposite: #targetFunction:.
	calledFromFunctions := FMMultivalueLink on: self opposite: #targetFunction:.
	calledFromTriggers := FMMultivalueLink on: self opposite: #invokedFunction:.
	usedAggregates := FMMultivalueLink
								on: self
								opposite: #function:
]

{ #category : #accessing }
FAMIXSQLFunction >> isSQLFunction [
	^true
]

{ #category : #accessing }
FAMIXSQLFunction >> language [
	^ language
]

{ #category : #accessing }
FAMIXSQLFunction >> language: anObject [
	language := anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> numberOfSQLParameters [
	<MSEProperty: #numberOfSQLParameters type: #Number>
	<MSEComment: 'The number of parameters in a function'>
	
	^self
		lookUpPropertyNamed: #numberOfSQLParameters
		computedAs: [self sqlParameters size]
]

{ #category : #accessing }
FAMIXSQLFunction >> ownerDataBase [
	<MSEProperty: #ownerDataBase type: #FAMIXDataBase> <derived>
	<MSEComment: 'Database containing the table'>
	

	^ownerDataBase
]

{ #category : #accessing }
FAMIXSQLFunction >> ownerDataBase: aDataBase [
	ownerDataBase:= aDataBase 
]

{ #category : #printing }
FAMIXSQLFunction >> printOn: aStream [
	
	self name isNil ifFalse: [ aStream nextPutAll: self name ].
	
	aStream nextPutAll: ' (Function)'
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedColumns [
	<MSEProperty: #referencedColumns type: #FAMIXFunctionToColumnAssociation opposite: #sourceFunction> <multivalued> 
	<MSEComment: 'List of columns referenced by the function.'>
	^ referencedColumns
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedColumns: anObject [
	referencedColumns value: anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedFunctions [
	<MSEProperty: #referencedFunctions type: #FAMIXFunctionToFunctionAssociation opposite: #sourceFunction> <multivalued> 
	<MSEComment: 'List of functions referenced by the function.'>
	^ referencedFunctions
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedFunctions: anObject [
	referencedFunctions value: anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedTables [
	<MSEProperty: #referencedTables type: #FAMIXFunctionToTableAssociation opposite: #function > <multivalued> 
	<MSEComment: 'List of Tables referenced by the function.'>
	^ referencedTables
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedTables: anObject [
	referencedTables value: anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> sqlParameters [
	<MSEProperty: #sqlParameters type: #FAMIXEntity opposite: #parentBehaviouralEntity> <multivalued> 
	<MSEComment: 'List of formal parameters declared by this behaviour.'>
	
	^sqlParameters
]

{ #category : #accessing }
FAMIXSQLFunction >> sqlParameters: aCollOfSQLParameters [
	sqlParameters value: aCollOfSQLParameters 
]

{ #category : #accessing }
FAMIXSQLFunction >> usedAggregates [
	<MSEProperty: #usedAggregates type: #FAMIXViewToAggregateAssociation opposite: #view> <multivalued>
	<MSEComment: 'aggregates used by this view '>
	^usedAggregates
]

{ #category : #accessing }
FAMIXSQLFunction >> usedAggregates: aFAMIXAggregate [
	usedAggregates := FMMultivalueLink
								on: self
								update: #function
								from: self usedColumns
								to: aFAMIXAggregate
]

{ #category : #querying }
FAMIXSQLFunction >> userEntities [
	^ (self userTables, self userFunctions, self userTriggers) asSet
]

{ #category : #'accessing-computed' }
FAMIXSQLFunction >> userFunctions [
	<navigation: #userFunctions>

	^self
		lookUpPropertyNamed: #userFunctions
		computedAs:
			[((self queryIncoming: FAMIXFunctionToColumnAssociation) atScope: FAMIXSQLFunction) asSet ]
]

{ #category : #'accessing-computed' }
FAMIXSQLFunction >> userTables [
	<navigation: #userTables>
	^ self
		lookUpPropertyNamed: #userTables
		computedAs: [ ((self queryIncoming: FAMIXColumnToFunctionAssociation) atScope: FAMIXTable) asSet ]
]

{ #category : #'accessing-computed' }
FAMIXSQLFunction >> userTriggers [
<navigation: #userTriggers>

	^self
		lookUpPropertyNamed: #userTriggers
		computedAs: [self calledFromTriggers]
]
