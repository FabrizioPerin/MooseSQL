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

{ #category : #'as yet unclassified' }
FAMIXUpdateRequest >> addSetClause:anExpression [
	setClause add: anExpression
]

{ #category : #'as yet unclassified' }
FAMIXUpdateRequest >> initialize [
	super initialize.
	setClause := FMMultivalueLink on: self opposite: #appearingInSetClause:.
]

{ #category : #'as yet unclassified' }
FAMIXUpdateRequest >> setClause [
	<MSEProperty: #setClause type: #FAMIXSQLExpression opposite: #appearingInSetClause> <multivalued>
	<MSEComment: 'Expression used in the update clause of the request'>
	^ setClause
]

{ #category : #accessing }
FAMIXUpdateRequest >> updateClause: anObject [
	setClause := anObject
]
