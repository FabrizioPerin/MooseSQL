"
FAMIXRequest is an abstract class representing a request.

    Instance Variables
	fromClause:		<Object>
	groupByClause:		<Object>
	havingClause:		<Object>
	orderByClause:		<Object>
	selectClause:		<Object>
	whereClause:		<Object>


    Implementation Points
"
Class {
	#name : #FAMIXRequest,
	#superclass : #FAMIXEntity,
	#traits : 'TDependencyQueries + TEntityMetaLevelDependency',
	#classTraits : 'TDependencyQueries classTrait + TEntityMetaLevelDependency classTrait',
	#instVars : [
		'whereClause',
		'fromClause',
		'usedInExpression',
		'owner',
		'useStar',
		'ownerView',
		'ownerFunction'
	],
	#classInstVars : [
		'incomingMSEProperties',
		'outgoingMSEProperties'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXRequest class >> incomingMSEPropertiesCache [
	^incomingMSEProperties
]

{ #category : #'as yet unclassified' }
FAMIXRequest class >> incomingMSEPropertiesCache: aValue [
	incomingMSEProperties := aValue
]

{ #category : #'as yet unclassified' }
FAMIXRequest class >> outgoingMSEPropertiesCache [
	^outgoingMSEProperties
]

{ #category : #'as yet unclassified' }
FAMIXRequest class >> outgoingMSEPropertiesCache: aValue [
	outgoingMSEProperties := aValue.
]

{ #category : #adding }
FAMIXRequest >> addFromClause:  anExpression [
	fromClause add: anExpression 
]

{ #category : #adding }
FAMIXRequest >> addWhereClause:  anExpression [
	whereClause add: anExpression 
]

{ #category : #accessing }
FAMIXRequest >> allClauses [
	| collExps |
	collExps := OrderedCollection new.
	collExps addAll: self selectClause.
	collExps addAll: self fromClause.
	collExps addAll: self whereClause.
	collExps addAll: self groupByClause.
	collExps addAll: self havingClause.
	collExps addAll: self orderByClause.

	^collExps 
]

{ #category : #accessing }
FAMIXRequest >> allColumns [
| allCols |
	allCols := OrderedCollection new.
	
	self selectClause do: [:exp | allCols addAll: exp allUsedColumns].
	^allCols
]

{ #category : #accessing }
FAMIXRequest >> allReferencedExpressions [
	^nil
]

{ #category : #accessing }
FAMIXRequest >> allUsedColumns [
	| allCols collExps |
	allCols := OrderedCollection new.
	collExps := self allClauses.
	collExps ifNotNil: [ collExps do: [:exp | allCols addAll: exp allUsedColumns ] ].
	^allCols
]

{ #category : #accessing }
FAMIXRequest >> allUsedFunctions [
	| allFunct collExps |
	allFunct := OrderedCollection new.
	collExps := self allClauses.
	collExps ifNotNil: [ collExps do: [:exp | allFunct addAll: exp allUsedFunctions ] ].
	^allFunct
]

{ #category : #accessing }
FAMIXRequest >> allUsedTables [
	| allCols collExps |
	allCols := OrderedCollection new.
	collExps := self allClauses.
	collExps ifNotNil: [ collExps do: [:exp | allCols addAll: exp allUsedTables ] ].
	^allCols
]

{ #category : #accessing }
FAMIXRequest >> fromClause [
	<MSEProperty: #fromClause type: #FAMIXSQLExpression opposite: #appearingInFromClause> <multivalued> <derived>
	<MSEComment: 'Expression used in the From clause of the request'>
	^ fromClause
]

{ #category : #accessing }
FAMIXRequest >> fromClause: anObject [
	fromClause := anObject
]

{ #category : #accessing }
FAMIXRequest >> fromClauseExpressions [
	^(self fromClause flatCollect: #allReferencedExpressions)
]

{ #category : #accessing }
FAMIXRequest >> fromTables [
	^fromClause collect: [ :exp | exp allUsedTables ].
]

{ #category : #accessing }
FAMIXRequest >> groupByClause [
	^ #()
]

{ #category : #accessing }
FAMIXRequest >> havingClause [
	^ #()
]

{ #category : #initialization }
FAMIXRequest >> initialize [
	super initialize.
	useStar := false.
	whereClause := FMMultivalueLink on: self opposite: #appearingInWhereClause:.
	fromClause := FMMultivalueLink on: self opposite: #appearingInFromClause:.
]

{ #category : #initialization }
FAMIXRequest >> isQuery [
	^true.
]

{ #category : #accessing }
FAMIXRequest >> orderByClause [
	^ #()
]

{ #category : #accessing }
FAMIXRequest >> owner [
	^ self ownerView ifNotNil: [ self ownerView ] ifNil: [ self ownerFunction ]
]

{ #category : #accessing }
FAMIXRequest >> owner: new [
    | old |
    old := owner.
    (old = new) ifFalse: [

        old ifNotNil: [
            owner := nil. "temporarily, to avoid infinite recursion"
            old query nil ].
        owner := new.
        new ifNotNil: [new query: self]
    ]
]

{ #category : #accessing }
FAMIXRequest >> ownerFunction [
	<MSEProperty: #ownerFunction type: #FAMIXSQLFunction opposite: #referencedRequest> 
	<MSEComment: 'Function owning the query'>
	<container>
	^ ownerFunction
]

{ #category : #accessing }
FAMIXRequest >> ownerFunction: anObject [
	ownerFunction := anObject
]

{ #category : #accessing }
FAMIXRequest >> ownerView [
	<MSEProperty: #ownerView type: #FAMIXEntity opposite: #query> 
	<MSEComment: 'View owning the query'>
	<container>
	^ ownerView
]

{ #category : #accessing }
FAMIXRequest >> ownerView: anObject [
	ownerView := anObject
]

{ #category : #accessing }
FAMIXRequest >> parentSQLEntity [
	^ self owner ifNotNil: [ self owner ] ifNil: [ self usedInExpression parentSQLEntity ]
]

{ #category : #'as yet unclassified' }
FAMIXRequest >> resolveQueryWith: rqResolver [
	self fromClause do: [ :cl | rqResolver resolveExpression: cl ].
	self whereClause do: [ :cl | rqResolver resolveExpression: cl ].
]

{ #category : #accessing }
FAMIXRequest >> selectClause [
	^ #()
]

{ #category : #accessing }
FAMIXRequest >> useStar [
	^ useStar
]

{ #category : #accessing }
FAMIXRequest >> useStar: anObject [
	useStar := anObject
]

{ #category : #accessing }
FAMIXRequest >> usedInExpression [
	<MSEProperty: #usedInExpression type: #FAMIXSQLExpression opposite: #targetRequest>
	<MSEComment: 'Expression in which the request is used.'>
	^ usedInExpression
]

{ #category : #accessing }
FAMIXRequest >> usedInExpression: anObject [
	usedInExpression := FMMultivalueLink 
		on: self
		update: #referencedRequests
		from: self usedInExpression
		to: anObject
]

{ #category : #accessing }
FAMIXRequest >> whereClause [
	<MSEProperty: #whereClause type: #FAMIXSQLExpression opposite: #appearingInWhereClause> <multivalued>
	<MSEComment: 'Expression used in the where clause of the request'>
	^ whereClause
]

{ #category : #accessing }
FAMIXRequest >> whereClause: anObject [
	whereClause := anObject
]
