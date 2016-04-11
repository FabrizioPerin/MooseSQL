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

{ #category : #adding }
FAMIXSelectRequest >> addGroupClause: anExpression [
	groupByClause add: anExpression 
]

{ #category : #'as yet unclassified' }
FAMIXSelectRequest >> addHavingClause: anExpression [
	havingClause add: anExpression 
]

{ #category : #adding }
FAMIXSelectRequest >> addSelectClause: anExpression [
	selectClause add: anExpression 
]

{ #category : #adding }
FAMIXSelectRequest >> addSortClause: anExpression [
	orderByClause add: anExpression 
]

{ #category : #accessing }
FAMIXSelectRequest >> groupByClause [
	<MSEProperty: #groupByClause type: #FAMIXSQLExpression opposite: #appearingInOrderByClause> <multivalued>
	<MSEComment: 'Expression used in the order by clause of the request'>
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

{ #category : #initialization }
FAMIXSelectRequest >> initialize [
	super initialize.
	selectClause := FMMultivalueLink on: self opposite: #appearingInSelectClause:.
	orderByClause := FMMultivalueLink on: self opposite: #appearingInOrderByClause:.
	groupByClause := FMMultivalueLink on: self opposite: #appearingInGroupByClause:.
	havingClause := FMMultivalueLink on: self opposite: #appearingInHavingClause:.
]

{ #category : #accessing }
FAMIXSelectRequest >> orderByClause [
	<MSEProperty: #orderByClause type: #FAMIXSQLExpression opposite: #appearingInOrderByClause> <multivalued>
	<MSEComment: 'Expression used in the order by clause of the request'>
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
