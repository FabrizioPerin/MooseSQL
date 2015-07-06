"
A FAMIXFunctionToFunctionAssociation is an association between a function (origin of the call) and a function 

Instance Variables
	sourceFunction:		<Object>
	targetFunction:		<Object>


    Implementation Points
"
Class {
	#name : #FAMIXFunctionToFunctionAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetFunction',
		'sourceFunction'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXFunctionToFunctionAssociation class >> annotation [
	<MSEClass: #FunctionCallFromFunctionAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> from [
	<MSEProperty: #sourceFunction type: #FAMIXSQLFunction opposite: #referencedFunctions>
	<MSEComment: 'the function source of the call'>
	^ sourceFunction 
]

{ #category : #'as yet unclassified' }
FAMIXFunctionToFunctionAssociation >> initialize [
	super initialize.
	
	sourceFunction := nil.
	targetFunction := nil.
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> sourceFunction [
	<MSEProperty: #sourceFunction type: #FAMIXSQLFunction opposite: #referencedFunctions>
	<MSEComment: 'the function source of the call'>
	^ sourceFunction
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> sourceFunction: aSourceFunction [
	sourceFunction := FMMultivalueLink
		on: self
		update: #referencedFunctions
		from: self sourceFunction
		to: aSourceFunction
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> targetFunction [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #calledFromFunctions>
	<MSEComment: 'Function referenced by the function.'>
	^ targetFunction
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> targetFunction: anEntity [

	targetFunction := FMMultivalueLink 
								on: self
								update: #calledFromFunctions
								from: self targetFunction
								to: anEntity
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> to [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #calledFromFunctions>
	<MSEComment: 'Function referenced by the function.'>
	^ targetFunction
]
