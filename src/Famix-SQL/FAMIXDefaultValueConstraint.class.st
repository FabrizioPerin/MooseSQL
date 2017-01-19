"
A FAMIXDefaultValueConstraint  is a special kind
 
Internal Representation and Key Implementation Points.

    Instance Variables
	column:		<Object>
	function:		<Object>
	value:		<Object>


    Implementation Points
"
Class {
	#name : #FAMIXDefaultValueConstraint,
	#superclass : #FAMIXSQLConstraint,
	#instVars : [
		'value',
		'function',
		'column'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #meta }
FAMIXDefaultValueConstraint class >> annotation [
	<MSEClass: #DefaultValueConstraint super: #FAMIXSQLConstraint>
	<package: #SQL>
	^self
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> column [
	<MSEProperty: #column type: #FAMIXColumn opposite: #defaultValue > 
	<MSEComment: 'Column on which the default value constraint is defined.'>
	^ column
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> column: anObject [
	column := anObject
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> function [
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #default> 
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

{ #category : #'as yet unclassified' }
FAMIXDefaultValueConstraint >> name [
	^'default'
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> value [
	^ value 
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> value: anObject [
	value := anObject
]
