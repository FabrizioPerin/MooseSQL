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
		'calledByConstraint',
		'appearingInSetClause',
		'appearingInColClause',
		'appearingInValuesClause'
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
FAMIXSQLExpression >> allReferencedExpressions [
	^ self referencedExpressions
		ifNotEmpty: [ self referencedExpressions flatCollect: #allReferencedExpressions ]
		ifEmpty: [ {self} ]
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
FAMIXSQLExpression >> appearingInColClause [
	<MSEProperty: #appearingInColClause type: #FAMIXInsertRequest opposite: #colClause>
	<MSEComment: 'Request referencing the expression in a col clause.'>
	<container>
	^ appearingInColClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInColClause: aRequest [
	appearingInColClause := 	FMMultivalueLink 
		on: self
		update: #colClause
		from: self appearingInColClause
		to: aRequest
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInFromClause [
	<MSEProperty: #appearingInFromClause type: #FAMIXRequest opposite: #fromClause>
	<MSEComment: 'Request referencing the expression in a from clause.'>
	<container>
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
	<container>
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
	<container>
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
	<container>
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
	<container>
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
FAMIXSQLExpression >> appearingInSetClause [
	<MSEProperty: #appearingInSetClause type: #FAMIXUpdateRequest opposite: #setClause>
	<MSEComment: 'Request referencing the expression in a update clause.'>
	<container>
	^ appearingInSetClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInSetClause: aRequest [
	appearingInSetClause := 	FMMultivalueLink 
		on: self
		update: #setClause
		from: self appearingInSetClause
		to: aRequest
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInValuesClause [
	<MSEProperty: #appearingInValuesClause type: #FAMIXInsertRequest opposite: #valuesClause>
	<MSEComment: 'Request referencing the expression in a values clause.'>
	<container>
	^ appearingInValuesClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInValuesClause: aRequest [
	appearingInValuesClause := 	FMMultivalueLink 
		on: self
		update: #valuesClause
		from: self appearingInValuesClause
		to: aRequest
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInWhereClause [
	<MSEProperty: #appearingInWhereClause type: #FAMIXRequest opposite: #whereClause>
	<MSEComment: 'Request referencing the expression in a where clause.'>
	<container>
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
	<container>
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
	<container>
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
	<container>
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

{ #category : #'resolve symbol' }
FAMIXSQLExpression >> cloneAssociationForExpression: anExpression [
	"clones receiver's associations to associations with anExpression"
	self referencedColumns do: [ :rc | rc targetColumn createAssociationFromExpression: anExpression  ].
	self referencedFunctions do: [ :rf | rf targetFunction createAssociationFromExpression: anExpression ].
	"these two seem unused
	self referencedRequests do: [ :rr | rr ].
	self referencedExpressions  do: [ :re | re ]"
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

{ #category : #'resolve symbol' }
FAMIXSQLExpression >> matches: unresolvedEntity [
	"trying to match an expression with an entity (should be an unresolved entity,
	 but might work if not)"

	^ (unresolvedEntity isColumn) ifTrue: [   "we are trying to match a colum to the expression"
			self referencedTable ifNotNil: [  ^ false ].  "Expression references a table, no match"
			(self alias = unresolvedEntity name) ifTrue: [ ^ true ].
			self referencedColumns ifNotEmpty: [ ^ self referencedColumns first name = unresolvedEntity name].
			self referencedExpressions ifNotEmpty: [ ^ self referencedExpressions matches: unresolvedEntity ].
			^ false
		]
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
FAMIXSQLExpression >> parentSQLEntity [
	"returns the function, view, table or SQL entity for which this expression is used in the definition (recursive owner) "

	^ ({ self usedInRequest .
		 self calledByExpression . 
		 self calledByConstraint .
		self calledByFunction } detect: #isNotNil) parentSQLEntity.
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

{ #category : #'as yet unclassified' }
FAMIXSQLExpression >> sourceText [
	^''.
]

{ #category : #accessing }
FAMIXSQLExpression >> usedColumns [
	
	^ self queryAllOutgoing: FAMIXExpressionToColumnAssociation atTypeScope: FAMIXColumn 
]

{ #category : #accessing }
FAMIXSQLExpression >> usedInRequest [
	"returns the expression (if it exists) where self appears"

	^ { self appearingInFromClause .
		self appearingInGroupByClause .
		self appearingInHavingClause .
		self appearingInOrderByClause .
		self appearingInSelectClause .
		self appearingInSetClause .
		self appearingInWhereClause .
		self appearingInColClause .
		self appearingInValuesClause		} detect: #isNotNil ifNone: [ nil ]
]
