"
A FAMIXView is a kind of table  built from a request.

    Instance Variables
	ofTables:		tables from which the view is built.


"
Class {
	#name : #FAMIXView,
	#superclass : #FAMIXTable,
	#instVars : [
		'ofTables',
		'usedColumns',
		'usedAggregates',
		'usedFunctions'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXView class >> annotation [
	<MSEClass: #View super: #FAMIXTable>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXView >> addDependencyIfNotExistTo: aFAMIXTableOrFunctionOrColumn [ 
	aFAMIXTableOrFunctionOrColumn addDependencyIfNotExistFromView: self.
]

{ #category : #adding }
FAMIXView >> addDependencyIfNotExistToAggregate: aFAMIXAggregate [
self usedAggregates detect: [ :any | any aggregate = aFAMIXAggregate]
		ifNone: [ FAMIXViewToAggregateAssociation new
		aggregate: aFAMIXAggregate;
		view: self;
		mooseModel: self mooseModel]
]

{ #category : #adding }
FAMIXView >> addDependencyIfNotExistToColumn: aFAMIXColumn [
^(self mooseModel entities anySatisfy: [ :any | (any class = FAMIXViewToColumnAssociation)
																	and: [ any column = aFAMIXColumn and: [ any view = self ] ] ])
		ifFalse: [ FAMIXViewToColumnAssociation new column: aFAMIXColumn ; view: self ; mooseModel: self mooseModel ]
	
]

{ #category : #adding }
FAMIXView >> addDependencyIfNotExistToFunction: aFAMIXFunction [
self usedFunctions detect: [ :any | any function = aFAMIXFunction]
		ifNone: [ FAMIXViewToFunctionAssociation new function: aFAMIXFunction ; view: self; mooseModel: self mooseModel ].

	
]

{ #category : #adding }
FAMIXView >> addDependencyIfNotExistToTable: aFAMIXTable [ 
(self mooseModel entities anySatisfy: [ :any | (any class = FAMIXViewToTableAssociation)
																	and: [ any table = aFAMIXTable  and: [ any view = self ] ] ])
	ifFalse: [FAMIXViewToTableAssociation new table: aFAMIXTable ; view: self; mooseModel: self mooseModel]
]

{ #category : #adding }
FAMIXView >> addReferencedColumn: aFAMIXColumn [
	self usedColumns add: aFAMIXColumn
]

{ #category : #adding }
FAMIXView >> addReferencedColumns: aListOfColumns [
	aListOfColumns do: [ :each |
		self addReferencedColumn: each ]
	
]

{ #category : #accessing }
FAMIXView >> belongsTo [
	<MSEProperty: #belongsTo type: #FAMIXDataBase> 
	<MSEComment: 'Database containing the view'>
	

	^self ownerDataBase
]

{ #category : #'accessing-computed' }
FAMIXView >> dependentAggregates [
	<navigation: #dependentAggregates>

	^self
		lookUpPropertyNamed: #dependentAggregates
		computedAs:
			[| result |
			result := Set new.
			result addAll: ((self queryOutgoing: FAMIXViewToAggregateAssociation) atScope: FAMIXSQLFunction).
			FAMIXTableGroup new addAll: result]
]

{ #category : #querying }
FAMIXView >> dependentEntities [
	^ (self dependentTables, self dependentFunctions, self dependentAggregates) asSet
]

{ #category : #'accessing-computed' }
FAMIXView >> dependentFunctions [
	<navigation: #dependentFunctions>

	^self
		lookUpPropertyNamed: #dependentFunctions
		computedAs:
			[| result |
			result := Set new.
			self columns do: [ :aColumn | 
				result addAll: ((aColumn queryOutgoing: FAMIXColumnToFunctionAssociation) atScope: FAMIXSQLFunction) ].
			result addAll: ((self queryOutgoing: FAMIXViewToFunctionAssociation) atScope: FAMIXSQLFunction).
			FAMIXTableGroup new addAll: result]
]

{ #category : #'accessing-computed' }
FAMIXView >> dependentTables [
	<navigation: #dependentTables>

	^self
		lookUpPropertyNamed: #dependentTables
		computedAs:
			[| result |
			result := Set new.
			self columns do: [ :aColumn | 
				result addAll: ((aColumn queryOutgoing: FAMIXColumnToColumnAssociation) atScope: FAMIXTable) ].
			result addAll: ((self queryOutgoing: FAMIXViewToTableAssociation) atScope: FAMIXTable).
			FAMIXTableGroup new addAll: result]
]

{ #category : #accessing }
FAMIXView >> fromTables [
	<MSEProperty: #fromTables type: #FAMIXTable > <multivalued> <derived>
	<MSEComment: 'tables used by this view (return tables or views)'>
	^ self ofTables collect: [ :tableAsso | tableAsso table ]
]

{ #category : #accessing }
FAMIXView >> fromViews [
	<MSEProperty: #fromViews type: #FAMIXView> <multivalued> <derived>
	<MSEComment: 'views used by this view'>
	^self fromTables select: [ :t | t isView ]
]

{ #category : #initialization }
FAMIXView >> initialize [
	super initialize.
	
	ofTables := FMMultivalueLink 
					on: self 
					opposite: #view:.
	usedColumns := FMMultivalueLink 
					on: self 
					opposite: #view:.
	usedFunctions := FMMultivalueLink 
					on: self 
					opposite: #view:.
	usedAggregates := FMMultivalueLink
					on: self
					opposite: #view:
]

{ #category : #testing }
FAMIXView >> isView [
	^ true
]

{ #category : #accessing }
FAMIXView >> ofTables [
	<MSEProperty: #ofTables type: #FAMIXViewToTableAssociation opposite: #view> <multivalued>
	<MSEComment: 'tables used by this view (return FAMIXViewAssociation)'>
	^ofTables
]

{ #category : #accessing }
FAMIXView >> printOn: aStream [
	
	self completeName isNil
		ifFalse: [ aStream nextPutAll: self completeName ]
		ifTrue: [ self name isNil ifFalse: [ aStream nextPutAll: self name ] ].
	
	aStream nextPutAll: ' (View)'
]

{ #category : #accessing }
FAMIXView >> usedAggregates [
	<MSEProperty: #usedAggregates type: #FAMIXViewToAggregateAssociation opposite: #view> <multivalued>
	<MSEComment: 'aggregates used by this view '>
	^usedAggregates
]

{ #category : #accessing }
FAMIXView >> usedAggregates: aFAMIXAggregate [
	usedAggregates := FMMultivalueLink
								on: self
								update: #view
								from: self usedColumns
								to: aFAMIXAggregate
]

{ #category : #accessing }
FAMIXView >> usedColumns [
	<MSEProperty: #usedColumns type: #FAMIXViewToColumnAssociation opposite: #view> <multivalued>
	<MSEComment: 'column used by this view '>
	^usedColumns
]

{ #category : #accessing }
FAMIXView >> usedColumns: anObject [
	usedColumns := anObject
]

{ #category : #accessing }
FAMIXView >> usedFunctions [
	<MSEProperty: #usedFunctions type: #FAMIXViewToFunctionAssociation opposite: #view> <multivalued>
	<MSEComment: 'functions used by this view '>
	^ usedFunctions
]

{ #category : #accessing }
FAMIXView >> usedFunctions: anObject [
	usedFunctions := anObject
]
