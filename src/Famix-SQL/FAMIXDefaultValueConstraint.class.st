Class {
	#name : #FAMIXDefaultValueConstraint,
	#superclass : #FAMIXSQLConstraint,
	#instVars : [
		'value',
		'function',
		'column',
		'outgoingInvocations'
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
	<MSEProperty: #function type: #FAMIXFunction opposite: #default> <derived> 
	<MSEComment: 'SQL or pgpsql function called in the default constraint'>
	^ self outgoingInvocations candidates first
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> function: anObject [
	self outgoingInvocations removeAll. FAMIXInvocation new sender: self ; addCandidate: anObject ; mooseModel: self mooseModel.
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> initialize [
	super initialize.
	outgoingInvocations := FMNullMultivalueLink on: self opposite: #sender: selector: #outgoingInvocations.
]

{ #category : #testing }
FAMIXDefaultValueConstraint >> isDefaultConstraint [
	^true.
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> outgoingInvocations [
	<MSEProperty: #outgoingInvocations type: #FAMIXInvocation opposite: #sender> 
	<MSEComment: 'SQL or pgpsql function called in the default constraint'>
	^ outgoingInvocations
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> outgoingInvocations: outgoing [
	outgoingInvocations value: outgoing
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> value [
	^ value 
]

{ #category : #accessing }
FAMIXDefaultValueConstraint >> value: anObject [
	value := anObject
]
