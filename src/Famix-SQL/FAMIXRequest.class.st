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
		'usedInExpression'
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
FAMIXRequest >> fromTables [
	^fromClause collect: [ :exp | exp referencedTable ].
]

{ #category : #'as yet unclassified' }
FAMIXRequest >> groupByClause [
	^ #()
]

{ #category : #'as yet unclassified' }
FAMIXRequest >> havingClause [
	^ #()
]

{ #category : #initialization }
FAMIXRequest >> initialize [
	super initialize.
	whereClause := FMMultivalueLink on: self opposite: #appearingInWhereClause:.
	fromClause := FMMultivalueLink on: self opposite: #appearingInFromClause:.
	usedInExpressions := FMMultivalueLink on: self opposite: #targetRequest:.
]

{ #category : #'as yet unclassified' }
FAMIXRequest >> orderByClause [
	^ #()
]

{ #category : #'as yet unclassified' }
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
