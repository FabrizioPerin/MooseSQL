Class {
	#name : #FAMIXDefaultValueConstraint,
	#superclass : #FAMIXSQLConstraint,
	#instVars : [
		'value',
		'function',
		'column'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXDefaultValueConstraint class >> annotation [
	<MSEClass: #DefaultValueConstraint super: #FAMIXSQLConstraint>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> column [
	^ column
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> column: anObject [
	column := anObject
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> function [
	<MSEProperty: #function type: #FAMIXFunction opposite: #default> 
	<MSEComment: 'SQL or pgpsql function called in the default constraint'>
	^ function
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> function: anObject [
	function := anObject
]

{ #category : #testing }
FAMIXDefaultValueConstraint >> isDefaultConstraint [
	^true.
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> value [
	^ value 
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> value: anObject [
	value := anObject
]
