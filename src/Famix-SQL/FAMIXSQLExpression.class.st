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
		'calledByExpressions',
		'appearingInWhereClause',
		'appearingInSelectClause'
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

{ #category : #accessing }
FAMIXSQLExpression >> appearingInSelectClause [
	<MSEProperty: #appearingInSelectClause type: #FAMIXSelectRequest opposite: #selectClause>
	<MSEComment: 'Request referencing the expression in a where clause.'>
	^ appearingInSelectClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInSelectClause: anObject [
	appearingInSelectClause := anObject
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInWhereClause [
	<MSEProperty: #appearingInWhereClause type: #FAMIXRequest opposite: #whereClause>
	<MSEComment: 'Request referencing the expression in a where clause.'>
	^ appearingInWhereClause
]

{ #category : #accessing }
FAMIXSQLExpression >> appearingInWhereClause: anObject [
	appearingInWhereClause := anObject
]

{ #category : #accessing }
FAMIXSQLExpression >> calledByExpressions [
	<MSEProperty: #calledByExpressions type: #FAMIXExpressionToExpressionAssociation opposite: #targetExpression> <multivalued> 
	<MSEComment: 'List of expressions used by the expression.'>
	^ calledByExpressions
]

{ #category : #accessing }
FAMIXSQLExpression >> calledByExpressions: anObject [
	calledByExpressions := anObject
]

{ #category : #'as yet unclassified' }
FAMIXSQLExpression >> initialize [
	super initialize.
	appearingInWhereClause := FMMultivalueLink on: self opposite: #targetExpression.
	referencedRequests := FMMultivalueLink on: self opposite: #sourceExpression:.
	referencedColumns := FMMultivalueLink on: self opposite: #sourceExpression:.
	referencedFunctions := FMMultivalueLink on: self opposite: #sourceExpression:.
	referencedExpressions := FMMultivalueLink on: self opposite: #sourceExpression:.
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
	<MSEProperty: #referencedExpressions type: #FAMIXExpressionToExpressionAssociation opposite: #sourceExpression> <multivalued> 
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
FAMIXSQLExpression >> usedColumns [
	
	^ self queryAllOutgoing: FAMIXExpressionToColumnAssociation atTypeScope: FAMIXColumn 
]
