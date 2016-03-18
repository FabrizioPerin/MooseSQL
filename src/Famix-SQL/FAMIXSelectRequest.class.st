"
FAMIXSelectRequest corresponds to a select request.

    Instance Variables
	groupByClause:		<Object>
	havingClause:		<Object>
	orderByClause:		<Object>
	selectClause:		<Object>


    Implementation Points
"
Class {
	#name : #FAMIXSelectRequest,
	#superclass : #FAMIXRequest,
	#instVars : [
		'selectClause',
		'groupByClause',
		'havingClause',
		'orderByClause'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXSelectRequest >> addSelectExpression: anExpression [
	selectClause add: anExpression 
]

{ #category : #accessing }
FAMIXSelectRequest >> groupByClause [
	^ groupByClause
]

{ #category : #accessing }
FAMIXSelectRequest >> groupByClause: anObject [
	groupByClause := anObject
]

{ #category : #accessing }
FAMIXSelectRequest >> havingClause [
	^ havingClause
]

{ #category : #accessing }
FAMIXSelectRequest >> havingClause: anObject [
	havingClause := anObject
]

{ #category : #'as yet unclassified' }
FAMIXSelectRequest >> initialize [
	super initialize.
	selectClause := FMMultivalueLink on: self opposite: #appearingInSelectClause:.
]

{ #category : #accessing }
FAMIXSelectRequest >> orderByClause [
	^ orderByClause
]

{ #category : #accessing }
FAMIXSelectRequest >> orderByClause: anObject [
	orderByClause := anObject
]

{ #category : #accessing }
FAMIXSelectRequest >> selectClause [
	<MSEProperty: #selectClause type: #FAMIXSQLExpression opposite: #appearingInSelectClause> <multivalued>
	<MSEComment: 'Expression used in the select clause of the request'>
	^ selectClause
]

{ #category : #accessing }
FAMIXSelectRequest >> selectClause: anObject [
	selectClause := anObject
]
