"
A FAMIXColumnReference is an association between a function and a column. The function using the column in its definition

Instance Variables
	sourceFunction:		function
	targetColumn:		column of a table used to define the sourceFunction
"
Class {
	#name : #FAMIXFunctionToColumnAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceFunction',
		'targetColumn'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXFunctionToColumnAssociation class >> annotation [
	<MSEClass: #FunctionToColumnAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXFunctionToColumnAssociation >> from [
	<MSEProperty: #sourceFunction type: #FAMIXSQLFunction opposite: #referencedColumns>
	<MSEComment: 'Function references a column.'>
	^sourceFunction.
]

{ #category : #accessing }
FAMIXFunctionToColumnAssociation >> printOn: aStream [
	aStream 
		<< self sourceFunction name;
		<< '->';
		<< self targetColumn name
		
]

{ #category : #accessing }
FAMIXFunctionToColumnAssociation >> sourceFunction [

	<MSEProperty: #sourceFunction type: #FAMIXSQLFunction opposite: #referencedColumns>
	<MSEComment: 'Function references a column.'>
	^ sourceFunction
]

{ #category : #accessing }
FAMIXFunctionToColumnAssociation >> sourceFunction: anObject [
	sourceFunction := FMMultivalueLink
		on: self
		update: #referencedColumns
		from: self sourceFunction 
		to: anObject
]

{ #category : #accessing }
FAMIXFunctionToColumnAssociation >> targetColumn [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedByFunctions>
	<MSEComment: 'Column referenced by a function.'>
	^ targetColumn
]

{ #category : #accessing }
FAMIXFunctionToColumnAssociation >> targetColumn: anObject [
	targetColumn := FMMultivalueLink
		on: self
		update: #referencedByFunctions
		from: self targetColumn
		to: anObject
]

{ #category : #accessing }
FAMIXFunctionToColumnAssociation >> to [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedByFunctions>
	<MSEComment: 'Column referenced by a function.'>
	^targetColumn.
]