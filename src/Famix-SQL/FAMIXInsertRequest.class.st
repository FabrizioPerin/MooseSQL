"
FAMIXInsertRequest corresponds to an insert request.
"
Class {
	#name : #FAMIXInsertRequest,
	#superclass : #FAMIXRequest,
	#instVars : [
		'colClause'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #accessing }
FAMIXInsertRequest >> addColClause:anExpression [
	colClause add: anExpression
]

{ #category : #'as yet unclassified' }
FAMIXInsertRequest >> colClause [
	<MSEProperty: #colClause type: #FAMIXSQLExpression opposite: #appearingInColClause> <multivalued>
	<MSEComment: 'Expression specifying the columns for which values are inserted'>
	^ colClause
]

{ #category : #initialization }
FAMIXInsertRequest >> initialize [
	super initialize.
	colClause := FMMultivalueLink on: self opposite: #appearingInColClause:.
]

{ #category : #'as yet unclassified' }
FAMIXInsertRequest >> resolveQueryWith: rqResolver [
	super resolveQueryWith: rqResolver.
	self colClause do: [ :cl | rqResolver resolveExpression: cl ].
]
