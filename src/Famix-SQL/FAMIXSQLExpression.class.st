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
		'calledByExpression'
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

{ #category : #'as yet unclassified' }
FAMIXSQLExpression >> addDependencyIfNotExistToColumn: aFAMIXColumn [
	^ self mooseModel entities detect: [ :e | e isAssociation and: [ e from = self and: [ e to = aFAMIXColumn ] ] ] ifNone: [FAMIXExpressionToColumnAssociation new targetColumn: aFAMIXColumn ; sourceExpression: self; mooseModel: self mooseModel]
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
FAMIXSQLExpression >> calledByExpression [
	<MSEProperty: #calledByExpression type: #FAMIXSQLExpression opposite: #referencedExpressions> <multivalued> 
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

{ #category : #initialization }
FAMIXSQLExpression >> initialize [
	super initialize.

	referencedRequests := FMMultivalueLink on: self opposite: #sourceExpression:.
	referencedColumns := FMMultivalueLink on: self opposite: #sourceExpression:.
	referencedFunctions := FMMultivalueLink on: self opposite: #sourceExpression:.
	referencedExpressions := FMMultivalueLink on: self opposite: #calledByExpression:.
	referencedUnresolvedEntities := OrderedCollection new.
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
	<MSEProperty: #referencedExpressions type: #FAMIXSQLExpression opposite: #calledByExpression> <multivalued> 
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
	<MSEProperty: #referencedRequests type: #FAMIXExpressionToRequestAssociation opposite: #sourceExpression> <multivalued> 
	<MSEComment: 'List of requests referenced by the expression.'>
	^ referencedRequests
]

{ #category : #accessing }
FAMIXSQLExpression >> referencedRequests: anObject [
	referencedRequests := anObject
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
