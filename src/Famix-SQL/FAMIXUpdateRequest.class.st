"
FAMIXUpdateRequest corresponds to an update request.
"
Class {
	#name : #FAMIXUpdateRequest,
	#superclass : #FAMIXRequest,
	#instVars : [
		'setClause'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #adding }
FAMIXUpdateRequest >> addSetClause:anExpression [
	setClause add: anExpression
]

{ #category : #initialization }
FAMIXUpdateRequest >> initialize [
	super initialize.
	setClause := FMMultivalueLink on: self opposite: #appearingInSetClause:.
]

{ #category : #'resolve symbol' }
FAMIXUpdateRequest >> resolveQueryWith: rqResolver [
	super resolveQueryWith: rqResolver.
	self setClause do: [ :cl | rqResolver resolveExpression: cl ].
]

{ #category : #accessing }
FAMIXUpdateRequest >> setClause [
	<MSEProperty: #setClause type: #FAMIXSQLExpression opposite: #appearingInSetClause> <multivalued>
	<MSEComment: 'Expression used in the update clause of the request'>
	^ setClause
]

{ #category : #accessing }
FAMIXUpdateRequest >> updateClause: anObject [
	setClause := anObject
]
