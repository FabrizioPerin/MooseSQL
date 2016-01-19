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
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #calledFromViews>
	<MSEComment: 'Function from which the view is defined'>
	^ function
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> function: aFAMIXFunction [
	function := FMMultivalueLink 
					on: self
					update: #calledFromViews
					from: self function
					to: aFAMIXFunction
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> initialize [
	super initialize.
	
	view := nil.
	function := nil.
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> printOnType [
	^' (View to Function association)'
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> to [
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #calledFromViews>
	<MSEComment: 'Function referenced by the view.'>
	^ function
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> view [
	<MSEProperty: #view type: #FAMIXView opposite: #usedFunctions>
	<MSEComment: 'View defined using a function'>
	^ view
]

{ #category : #accessing }
FAMIXViewToFunctionAssociation >> view: aFAMIXView [
	view := FMMultivalueLink 
					on: self
					update: #usedFunctions
					from: self view  
					to: aFAMIXView
]
