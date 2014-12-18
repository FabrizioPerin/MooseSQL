Class {
	#name : #FAMIXFunctionCallAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceTable',
		'targetFunction'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXFunctionCallAssociation class >> annotation [
	<MSEClass: #FunctionCallAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> from [
	^ sourceTable
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> sourceTable [
	^ sourceTable
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> sourceTable: anObject [
	sourceTable := anObject
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> targetFunction [
	^ targetFunction
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> targetFunction: anObject [
	targetFunction := anObject
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> to [
	^ targetFunction
]
