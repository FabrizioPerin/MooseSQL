"
FAMIXSQLExpression corresponds to an expression. An expression refers columns, functions, requests or other expressions. The owner can be either a function, a request or an expression.


    Instance Variables
	columns:		<Object>
	expressions:		<Object>
	functions:		<Object>
	requests:		<Object>


    Implementation Points
"
Class {
	#name : #FAMIXSQLExpression,
	#superclass : #FAMIXEntity,
	#instVars : [
		'referencedColumns',
		'referencedFunctions',
		'referencedRequests',
		'referencedExpressions',
		'owner',
		'appearingInWhereClause',
		'appearingInSelectClause',
		'referencedUnresolvedEntities',
		'appearingInFromClause',
		'referencedTable',
		'calledByExpression',
		'appearingInOrderByClause',
		'appearingInGroupByClause',
		'appearingInHavingClause',
		'calledByFunction',
		'alias',
		'calledByConstraint'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #meta }
FAMIXSQLExpression class >> annotation [
	<MSEClass: #SQLExpression super: #FAMIXEntity>
	<package: #FAMIX>
	<MSEParentSelector: #owner >
	^self
]

{ #category : #adding }
FAMIXSQLExpression >> addDependencyIfNotExistToColumn: aFAMIXColumn [
	^ self mooseModel entities detect: [ :e | e isAssociation and: [ e from = self and: [ e to = aFAMIXColumn ] ] ] ifNone: [FAMIXExpressionToColumnAssociation new targetColumn: aFAMIXColumn ; sourceExpression: self; mooseModel: self mooseModel]
]

{ #category : #adding }
FAMIXSQLExpression >> addDependencyIfNotExistToFunction: aFAMIXFunction [
	^ self mooseModel entities detect: [ :e | e isAssociation and: [ e from = self and: [ e to = aFAMIXFunction ] ] ] ifNone: [FAMIXExpressionToFunctionAssociation new targetFunction: aFAMIXFunction ; sourceExpression: self; mooseModel: self mooseModel]
]

{ #category : #adding }
FAMIXSQLExpression >> addReferencedExpression: anExpression [

	referencedExpressions add: anExpression 
]

{ #category : #accessing }
FAMIXSQLExpression >> alias [
	^ alias
]

{ #category : #accessing }
FAMIXSQLExpression >> alias: anObject [
	alias := anObject
]

{ #category : #accessing }
FAMIXSQLExpression >> allUsedColumns [
	| allCols |
	allCols := OrderedCollection new.
	self referencedExpressions ifNotNil: [ self referencedExpressions do: [:exp | allCols addAll: exp allUsedColumns ] ].
	self referencedRequests ifNotNil: [ self referencedRequests do: [:req | allCols addAll: req allUsedColumns ] ].
	allCols addAll: (self referencedColumns collect: #targetColumn).
	^allCols
]

{ #category : #accessing }
FAMIXSQLExpression >> allUsedFunctions [
	| allFuncts |
	allFuncts := OrderedCollection new.
	self referencedExpressions ifNotNil: [ self referencedExpressions do: [:exp | allFuncts addAll: exp allUsedFunctions ] ].
	self referencedRequests ifNotNil: [ self referencedRequests do: [:req | allFuncts addAll: req allUsedFunctions ] ].
	allFuncts addAll: (self referencedFunctions collect: #targetFunction).
	^allFuncts
]

{ #category : #accessing }
FAMIXSQLExpression >> allUsedTables [
	| allTables |
	allTables := OrderedCollection new.
	self referencedExpressions
		ifNotNil:
			[ self referencedExpressions
				do: [ :exp | 
					| t |
					t := exp allUsedTables.
					t ifNotNil: [ allTables addAll: t ] ] ].
	self referencedRequests
		ifNotNil:
			[ self referencedRequests
				do: [ :req | 
					| t |
					t := req allUsedTables.
					t ifNotNil: [ allTables addAll: t ] ] ].
	self referencedTable ifNotNil: [allTables add: self referencedTable].
	^ allTables
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInFromClause [
	<MSEProperty: #appearingInFromClause type: #FAMIXRequest opposite: #fromClause>
	<MSEComment: 'Request referencing the expression in a from clause.'>
	^ appearingInFromClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInFromClause: aRequest [
	appearingInFromClause := 	FMMultivalueLink 
		on: self
		update: #fromClause
		from: self appearingInFromClause
		to: aRequest
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInGroupByClause [
	<MSEProperty: #appearingInGroupByClause type: #FAMIXSelectRequest opposite: #groupByClause>
	<MSEComment: 'Request referencing the expression in a group By clause.'>
	^ appearingInGroupByClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInGroupByClause: aRequest [
	appearingInGroupByClause := 	FMMultivalueLink 
		on: self
		update: #groupByClause
		from: self appearingInGroupByClause
		to: aRequest
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInHavingClause [
	<MSEProperty: #appearingHavingClause type: #FAMIXSelectRequest opposite: #havingClause>
	<MSEComment: 'Request referencing the expression in a having clause.'>
	^ appearingInHavingClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInHavingClause: aRequest [
	appearingInHavingClause := 	FMMultivalueLink 
		on: self
		update: #havingClause
		from: self appearingInHavingClause
		to: aRequest
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInOrderByClause [
	<MSEProperty: #appearingInOrderByClause type: #FAMIXSelectRequest opposite: #orderByClause>
	<MSEComment: 'Request referencing the expression in an order By clause.'>
	^ appearingInOrderByClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInOrderByClause: aRequest [
	appearingInOrderByClause := 	FMMultivalueLink 
		on: self
		update: #orderByClause
		from: self appearingInOrderByClause
		to: aRequest
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInSelectClause [
	<MSEProperty: #appearingInSelectClause type: #FAMIXSelectRequest opposite: #selectClause>
	<MSEComment: 'Request referencing the expression in a where clause.'>
	^ appearingInSelectClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInSelectClause: aRequest [
	appearingInSelectClause := 	FMMultivalueLink 
		on: self
		update: #selectClause
		from: self appearingInSelectClause
		to: aRequest
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInWhereClause [
	<MSEProperty: #appearingInWhereClause type: #FAMIXRequest opposite: #whereClause>
	<MSEComment: 'Request referencing the expression in a where clause.'>
	^ appearingInWhereClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInWhereClause: aRequest [
	appearingInWhereClause := 	FMMultivalueLink 
		on: self
		update: #whereClause
		from: self appearingInWhereClause
		to: aRequest
]

{ #category : #accessing }
FAMIXSQLExpression >> calledByConstraint [
	<MSEProperty: #calledByConstraint type: #FAMIXSQLConstraint opposite: #expression> 
	<MSEComment: 'Expression used by the constraint.'>
	^ calledByConstraint
]

{ #category : #accessing }
FAMIXSQLExpression >> calledByConstraint: anObject [
	| old |
    old := calledByConstraint.
    (old = anObject) ifFalse: [

        old ifNotNil: [
            calledByConstraint := nil. "temporarily, to avoid infinite recursion"
            old expression: nil ].
        calledByConstraint := anObject.
        anObject ifNotNil: [anObject expression: self]
    ]
]

{ #category : #accessing }
FAMIXSQLExpression >> calledByExpression [
	<MSEProperty: #calledByExpression type: #FAMIXSQLExpression opposite: #referencedExpressions> 
	<MSEComment: 'List of expressions used by the expression.'>
	^ calledByExpression
]

{ #category : #accessing }
FAMIXSQLExpression >> calledByExpression: anObject [
	calledByExpression := FMMultivalueLink 
		on: self
		update: #referencedExpressions
		from: self calledByExpression
		to: anObject
]

{ #category : #accessing }
FAMIXSQLExpression >> calledByFunction [
	<MSEProperty: #calledByFunction type: #FAMIXSQLFunction opposite: #referencedExpressions>
	<MSEComment: 'List of expressions used by the function.'>
	^ calledByFunction
]

{ #category : #accessing }
FAMIXSQLExpression >> calledByFunction: anObject [
	calledByFunction := FMMultivalueLink 
		on: self
		update: #referencedExpressions
		from: self calledByFunction
		to: anObject
]

{ #category : #initialization }
FAMIXSQLExpression >> initialize [
	super initialize.

	referencedRequests := FMMultivalueLink on: self opposite: #usedInExpression:.
	referencedColumns := FMMultivalueLink on: self opposite: #sourceExpression:.
	referencedFunctions := FMMultivalueLink on: self opposite: #sourceExpression:.
	referencedExpressions := FMMultivalueLink on: self opposite: #calledByExpression:.
	referencedUnresolvedEntities := OrderedCollection new.
]

{ #category : #accessing }
FAMIXSQLExpression >> isSQLExpression [
	^true
]

{ #category : #accessing }
FAMIXSQLExpression >> owner [
	^ owner
]

{ #category : #accessing }
FAMIXSQLExpression >> owner: anObject [
	owner := anObject
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedColumns [
	<MSEProperty: #referencedColumns type: #FAMIXExpressionToColumnAssociation opposite: #sourceExpression> <multivalued> 
	<MSEComment: 'List of columns referenced by the expression.'>
	^ referencedColumns
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedColumns: anObject [
	referencedColumns := anObject
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedExpressions [
	<MSEProperty: #referencedExpressions type: #FAMIXSQLExpression opposite: #calledByExpression> <multivalued> <derived>
	<MSEComment: 'List of expressions referenced by the expression.'>
	^ referencedExpressions
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedExpressions: anObject [
	referencedExpressions := anObject
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedFunctions [
	<MSEProperty: #referencedFunctions type: #FAMIXExpressionToFunctionAssociation opposite: #sourceExpression> <multivalued> 
	<MSEComment: 'List of functions referenced by the expression.'>
	^ referencedFunctions
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedFunctions: anObject [
	referencedFunctions := anObject
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedRequests [
	<MSEProperty: #referencedRequests type: #FAMIXRequest opposite: #usedInExpression> <multivalued> 
	<MSEComment: 'List of requests referenced by the expression.'>
	^ referencedRequests
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedRequests: aCollection [
	referencedRequests := aCollection
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedTable [
	<MSEProperty: #referencedTable type: #FAMIXTable opposite: #consumerExpressions> 
	<MSEComment: 'List of columns referenced by the expression.'>
	^ referencedTable
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedTable: anObject [
	referencedTable := FMMultivalueLink 
		on: self
		update: #consumerExpressions
		from: self referencedTable
		to: anObject
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedUnresolvedEntities [

	^ referencedUnresolvedEntities
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedUnresolvedEntities: aCollection [

	referencedUnresolvedEntities := aCollection
]

{ #category : #accessing }
FAMIXSQLExpression >> usedColumns [
	
	^ self queryAllOutgoing: FAMIXExpressionToColumnAssociation atTypeScope: FAMIXColumn 
]
