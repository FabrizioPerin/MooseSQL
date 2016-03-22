Class {
	#name : #FAMIXViewToFunctionAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'view',
		'function'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXViewToFunctionAssociation class >> annotation [
	<MSEClass: #ViewToFunctionAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> from [
	<MSEProperty: #view type: #FAMIXView opposite: #usedFunctions>
	<MSEComment: 'View defined using a function'>
	^ view
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> function [
	^ function
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> function: anObject [
	function := anObject
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> initialize [
	super initialize.
	
	view := nil.
	function := nil.
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> to [
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #calledFromViews>
	<MSEComment: 'Function referenced by the view.'>
	^ function
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> view [
	^ view
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> view: anObject [
	view := anObject
]
