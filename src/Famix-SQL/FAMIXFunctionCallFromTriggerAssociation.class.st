"
A FAMIXFunctionCallFromTriggerAssociation is an association between a trigger (origin of the call) and a function 
"
Class {
	#name : #FAMIXFunctionCallFromTriggerAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetFunction',
		'sourceTrigger'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXFunctionCallFromTriggerAssociation class >> annotation [
	<MSEClass: #FunctionCallAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXFunctionCallFromTriggerAssociation >> from [
	^ self sourceTrigger
]

{ #category : #accessing }
FAMIXFunctionCallFromTriggerAssociation >> sourceTrigger [
	<MSEProperty: #sourceTrigger type: #FAMIXRelationalEntity opposite: #invokedFunction>
	<MSEComment: 'Relational element references another relational element.'>
	^ sourceTrigger
]

{ #category : #accessing }
FAMIXFunctionCallFromTriggerAssociation >> sourceTrigger: anObject [
	sourceTrigger := anObject
]

{ #category : #accessing }
FAMIXFunctionCallFromTriggerAssociation >> targetFunction [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #referencedBy>
	<MSEComment: 'Relational element referenced by another relational element.'>
	^ targetFunction
]

{ #category : #accessing }
FAMIXFunctionCallFromTriggerAssociation >> targetFunction: anObject [
	targetFunction := anObject
]

{ #category : #accessing }
FAMIXFunctionCallFromTriggerAssociation >> to [
	^ self targetFunction
]
