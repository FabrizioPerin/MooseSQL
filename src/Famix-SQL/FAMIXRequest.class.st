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
	#instVars : [
		'whereClause',
		'fromClause',
		'usedInExpression',
		'owner'
	],
	#category : #'Famix-SQL-Core'
}

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
	<MSEProperty: #owner type: #FAMIXEntity opposite: #query> 
	<MSEComment: 'Owner of the query'>
	^ owner
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
FAMIXRequest >> selectClause [
	^ #()
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
