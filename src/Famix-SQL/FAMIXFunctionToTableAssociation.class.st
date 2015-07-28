"
A FAMIXTableAssociation is an association between a function and a table. The function referres the table for its definition

Instance Variables
	function:		function
	table:			table referred in the function definition

"
Class {
	#name : #FAMIXFunctionToTableAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'function',
		'table'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXFunctionToTableAssociation class >> annotation [
	<MSEClass: #TableAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXFunctionToTableAssociation >> from [
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #referencedTables>
	<MSEComment: 'Defined Function '>
	^ function
]

{ #category : #accessing }
FAMIXFunctionToTableAssociation >> function [
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #referencedTables>
	<MSEComment: 'Defined Function '>
	^ function
]

{ #category : #accessing }
FAMIXFunctionToTableAssociation >> function: anObject [
	function := FMMultivalueLink
		on: self
		update: #referencedTables
		from: self function
		to: anObject
]

{ #category : #accessing }
FAMIXFunctionToTableAssociation >> table [
	<MSEProperty: #table type: #FAMIXTable opposite: #consumerFunctions>
	<MSEComment: 'Table on which the function is defined on'>
	^ table
]

{ #category : #accessing }
FAMIXFunctionToTableAssociation >> table: anObject [
	table := FMMultivalueLink
		on: self
		update: #consumerFunctions
		from: self table
		to: anObject
]

{ #category : #accessing }
FAMIXFunctionToTableAssociation >> to [
	<MSEProperty: #table type: #FAMIXTable opposite: #consumerFunctions>
	<MSEComment: 'Table on which the function is defined on'>
	^ table
]