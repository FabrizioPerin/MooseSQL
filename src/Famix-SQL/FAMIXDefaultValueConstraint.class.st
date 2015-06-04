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
	<MSEProperty: #function type: #FAMIXFunction opposite: #default> <derived> 
	<MSEComment: 'SQL or pgpsql function called in the default constraint'>
	^ self outgoingInvocations anyOne candidates anyOne
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> function: anObject [
	self outgoingInvocations removeAll. FAMIXInvocation new sender: self ; addCandidate: anObject ; mooseModel: self mooseModel.
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
