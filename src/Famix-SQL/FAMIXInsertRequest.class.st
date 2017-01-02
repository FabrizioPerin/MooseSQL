"
FAMIXInsertRequest corresponds to an insert request.
"
Class {
	#name : #FAMIXInsertRequest,
	#superclass : #FAMIXRequest,
	#instVars : [
		'colClause',
		'valuesClause'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #accessing }
FAMIXInsertRequest >> addColClause:anExpression [
	colClause add: anExpression
]

{ #category : #accessing }
FAMIXInsertRequest >> addValuesClause:anExpression [
	valuesClause add: anExpression
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
	valuesClause := FMMultivalueLink on: self opposite: #appearingInValuesClause:.
]

{ #category : #'as yet unclassified' }
FAMIXInsertRequest >> resolveQueryWith: rqResolver [
	super resolveQueryWith: rqResolver.
	self colClause do: [ :cl | rqResolver resolveExpression: cl ].
	self valuesClause do: [ :cl | rqResolver resolveExpression: cl ].
]

{ #category : #'as yet unclassified' }
FAMIXInsertRequest >> valuesClause [
	<MSEProperty: #valuesClause type: #FAMIXSQLExpression opposite: #appearingInValuesClause> <multivalued>
	<MSEComment: 'Expression specifying the inserted values'>
	^ valuesClause
]
