"
A FAMIXFunctionCallFromFunctionAssociation is an association between a function (origin of the call) and a function 

Instance Variables
	sourceFunction:		<Object>
	targetFunction:		<Object>


    Implementation Points
"
Class {
	#name : #FAMIXFunctionCallFromFunctionAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetFunction',
		'sourceFunction'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXFunctionCallFromFunctionAssociation class >> annotation [
	<MSEClass: #FunctionCallAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> from [
	^ sourceTable
]

{ #category : #'as yet unclassified' }
FAMIXFunctionCallFromFunctionAssociation >> initialize [
	super initialize.
	
	sourceColumn := nil.
	targetFunction := nil.
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> sourceFunction [
	<MSEProperty: #sourceFunction type: #FAMIXSQLFunction opposite: #referencedFunctions>
	<MSEComment: 'the function source of the call'>
	^ sourceFunction
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> sourceFunction: aSourceFunction [
	sourceFunction := FMMultivalueLink
		on: self
		update: #referencedFunctions
		from: self sourceFunction
		to: aSourceFunction
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> sourceView [
	<MSEProperty: #sourceColumn type: #FAMIXRelationalEntity > <derived>
	<MSEComment: 'Relational table references another relational table.'>
	
	^sourceColumn ownerTable
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> targetFunction [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #referencedBy>
	<MSEComment: 'Relational element referenced by another relational element.'>
	^ targetFunction
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> targetFunction: anEntity [

	targetFunction := FMMultivalueLink 
								on: self
								update: #referencedBy
								from: self targetFunction
								to: anEntity
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> to [
	^ targetFunction
]
