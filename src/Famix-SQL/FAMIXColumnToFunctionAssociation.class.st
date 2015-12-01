"
A FAMIXFunctionCallAssociation is an association between a column of a view and a function used to define the values of the column

Instance Variables
	sourceColumn:		column of a view
	targetFunction:		function used to define the column of the view

"
Class {
	#name : #FAMIXColumnToFunctionAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetFunction',
		'sourceColumn'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXColumnToFunctionAssociation class >> annotation [
	<MSEClass: #ColumnToFunctionAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXColumnToFunctionAssociation >> from [
	<MSEProperty: #sourceColumn type: #FAMIXColumn opposite: #invokedFunctions>
	<MSEComment: 'Column references functions.'>
	^ sourceColumn
]

{ #category : #'initialize-release' }
FAMIXColumnToFunctionAssociation >> initialize [
	super initialize.
	
	sourceColumn := nil.
	targetFunction := nil.
]

{ #category : #printing }
FAMIXColumnToFunctionAssociation >> printOnType [
	^' (Column to Function association)'
]

{ #category : #accessing }
FAMIXColumnToFunctionAssociation >> sourceColumn [
	<MSEProperty: #sourceColumn type: #FAMIXColumn opposite: #invokedFunctions>
	<MSEComment: 'Column references functions.'>
	^ sourceColumn
]

{ #category : #accessing }
FAMIXColumnToFunctionAssociation >> sourceColumn: aRelationalEntity [
	sourceColumn := FMMultivalueLink
		on: self
		update: #invokedFunctions
		from: self sourceColumn
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXColumnToFunctionAssociation >> targetFunction [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #calledFromColumns>
	<MSEComment: 'Functions referenced by a column.'>
	^ targetFunction
]

{ #category : #accessing }
FAMIXColumnToFunctionAssociation >> targetFunction: anEntity [

	targetFunction := FMMultivalueLink 
								on: self
								update: #calledFromColumns
								from: self targetFunction
								to: anEntity
]

{ #category : #accessing }
FAMIXColumnToFunctionAssociation >> to [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #calledFromColumns>
	<MSEComment: 'Functions referenced by a column.'>
	^ targetFunction
]
