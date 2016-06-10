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
		'usedFunctions',
		'query'
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
FAMIXView >> dependentColumns [
	<navigation: #dependentColumns>

	^self
		lookUpPropertyNamed: #dependentColumns
		computedAs:
			[ FAMIXColumnGroup new addAll: (self query allUsedColumns asSet)]
]

{ #category : #querying }
FAMIXView >> dependentEntities [
	^ (self dependentTables, self dependentFunctions , self dependentColumns ) asSet
]

{ #category : #'accessing-computed' }
FAMIXView >> dependentFunctions [
	<navigation: #dependentFunctions>

	^self
		lookUpPropertyNamed: #dependentFunctions
		computedAs:
			[FAMIXTableGroup new addAll: self query allUsedFunctions asSet]
]

{ #category : #'accessing-computed' }
FAMIXView >> dependentTables [
	<navigation: #dependentTables>

	^self
		lookUpPropertyNamed: #dependentTables
		computedAs:
			[ FAMIXTableGroup new addAll: (self query allUsedTables asSet)]
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
	<MSEProperty: #ofTables type: #FAMIXViewToTableAssociation opposite: #view> <multivalued> <derived>
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
FAMIXView >> query [
	<MSEProperty: #query type: #FAMIXSelectRequest opposite: #ownerView> 
	<MSEComment: 'Query specifying the view.'>
	
	^ query
]

{ #category : #accessing }
FAMIXView >> query: new [
    | old |
    old := query.
    (old = new) ifFalse: [

        old ifNotNil: [
            query := nil. "temporarily, to avoid infinite recursion"
            old ownerView nil ].
        query := new.
        new ifNotNil: [new ownerView: self]
    ]
]

{ #category : #accessing }
FAMIXView >> usedAggregates [
	<MSEProperty: #usedAggregates type: #FAMIXViewToAggregateAssociation opposite: #view> <multivalued> <derived>
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
	<MSEProperty: #usedColumns type: #FAMIXViewToColumnAssociation opposite: #view> <multivalued> <derived>
	<MSEComment: 'column used by this view '>
	^usedColumns
]

{ #category : #accessing }
FAMIXView >> usedColumns: anObject [
	usedColumns := anObject
]

{ #category : #accessing }
FAMIXView >> usedFunctions [
	<MSEProperty: #usedFunctions type: #FAMIXViewToFunctionAssociation opposite: #view> <multivalued> <derived>
	<MSEComment: 'functions used by this view '>
	^ usedFunctions
]

{ #category : #accessing }
FAMIXView >> usedFunctions: anObject [
	usedFunctions := anObject
]
