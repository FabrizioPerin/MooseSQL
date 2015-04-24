"
A FAMIXFunctionCallAssociation is an association between a column of a view and a function used to define the values of the column

Instance Variables
	sourceColumn:		column of a view
	sourceView:			view of the column
	targetFunction:		function used to define the column of the view

"
Class {
	#name : #FAMIXFunctionCallAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceView',
		'targetFunction',
		'sourceColumn'
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

{ #category : #'as yet unclassified' }
FAMIXFunctionCallAssociation >> initialize [
	super initialize.
	
	sourceColumn := nil.
	targetFunction := nil.
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> sourceColumn [
	<MSEProperty: #sourceColumn type: #FAMIXRelationalEntity opposite: #references>
	<MSEComment: 'Relational element references another relational element.'>
	^ sourceColumn
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> sourceColumn: aRelationalEntity [
	sourceColumn := FMMultivalueLink
		on: self
		update: #invokedFunctions
		from: self sourceColumn
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> sourceView [
	<MSEProperty: #sourceColumn type: #FAMIXRelationalEntity > <derived>
	<MSEComment: 'Relational table references another relational table.'>
	
	^sourceColumn ownerTable
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> targetFunction [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #referencedBy>
	<MSEComment: 'Relational element referenced by another relational element.'>
	^ targetFunction
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> targetFunction: anEntity [

	targetFunction := FMMultivalueLink 
								on: self
								update: #referencedBy
								from: self targetFunction
								to: anEntity
]

{ #category : #accessing }
FAMIXFunctionCallAssociation >> to [
	^ targetFunction
]
