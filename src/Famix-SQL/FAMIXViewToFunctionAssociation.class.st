Class {
	#name : #FAMIXViewToFunctionAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'view',
		'function'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #meta }
FAMIXViewToFunctionAssociation class >> annotation [
	<MSEClass: #ViewToFunctionAssociation super: #FAMIXAssociation>
	<package: #SQL>
	^self
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> from [
	^ view
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> from: aView [
	self view: aView
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> function [
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #calledFromViews>
	<MSEComment: 'Function referenced by the view.'>
	<target>
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
	^ function
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> to: aFunction [
	self function: aFunction
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> view [
	<MSEProperty: #view type: #FAMIXView opposite: #usedFunctions>
	<MSEComment: 'View referencing the functions.'>
	<source>
	^ view
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> view: anObject [
	view := anObject
]
