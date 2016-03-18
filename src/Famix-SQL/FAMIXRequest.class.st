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
		'usedInExpressions'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #accessing }
FAMIXRequest >> fromClause [
	<MSEProperty: #fromClause type: #FAMIXSQLExpression opposite: #appearingInFromClause> <multivalued>
	<MSEComment: 'Expression used in the From clause of the request'>
	^ fromClause
]

{ #category : #accessing }
FAMIXRequest >> fromClause: anObject [
	fromClause := anObject
]

{ #category : #accessing }
FAMIXRequest >> initialize [
	super initialize.
	whereClause := FMMultivalueLink on: self opposite: #appearingInWhereClause.
	fromClause := FMMultivalueLink on: self opposite: #appearingInFromClause.
	usedInExpressions := FMMultivalueLink on: self opposite: #targetRequest.
]

{ #category : #accessing }
FAMIXRequest >> usedInExpressions [
	<MSEProperty: #usedInExpressions type: #FAMIXRequest opposite: #targetRequest>
	<MSEComment: 'Expression in which the request is used.'>
	^ usedInExpressions
]

{ #category : #accessing }
FAMIXRequest >> usedInExpressions: anObject [
	usedInExpressions := anObject
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
