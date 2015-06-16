"
A FAMIXFunctionCallAssociation is an association between a column of a view and a function used to define the values of the column

Instance Variables
	sourceColumn:		column of a view
	targetFunction:		function used to define the column of the view

"
Class {
	#name : #FAMIXFunctionCallFromColumnAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetFunction',
		'sourceColumn'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXFunctionCallFromColumnAssociation class >> annotation [
	<MSEClass: #FunctionCallAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXFunctionCallFromColumnAssociation >> from [
	^ sourceColumn
]

{ #category : #'as yet unclassified' }
FAMIXFunctionCallFromColumnAssociation >> initialize [
	super initialize.
	
	sourceColumn := nil.
	targetFunction := nil.
]

{ #category : #accessing }
FAMIXFunctionCallFromColumnAssociation >> sourceColumn [
	<MSEProperty: #sourceColumn type: #FAMIXColumn opposite: #usedFunctions>
	<MSEComment: 'Column references functions.'>
	^ sourceColumn
]

{ #category : #accessing }
FAMIXFunctionCallFromColumnAssociation >> sourceColumn: aRelationalEntity [
	sourceColumn := FMMultivalueLink
		on: self
		update: #invokedFunctions
		from: self sourceColumn
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXFunctionCallFromColumnAssociation >> targetFunction [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #calledFromColumns>
	<MSEComment: 'Functions referenced by a column.'>
	^ targetFunction
]

{ #category : #accessing }
FAMIXFunctionCallFromColumnAssociation >> targetFunction: anEntity [

	targetFunction := FMMultivalueLink 
								on: self
								update: #calledFromColumns
								from: self targetFunction
								to: anEntity
]

{ #category : #accessing }
FAMIXFunctionCallFromColumnAssociation >> to [
	^ targetFunction
]
