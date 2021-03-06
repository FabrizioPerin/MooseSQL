"
A FAMIXFunctionCallFromFunctionAssociation is an association between a function (origin of the call) and a function 

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

{ #category : #meta }
FAMIXFunctionToFunctionAssociation class >> annotation [
	<MSEClass: #FunctionToFunctionAssociation super: #FAMIXAssociation>
	<package: #SQL>
	^self
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> from [
	^ sourceFunction 
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> from: aFunction [
	self sourceFunction: aFunction 
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> initialize [
	super initialize.
	
	sourceFunction := nil.
	targetFunction := nil.
]

{ #category : #printing }
FAMIXFunctionToFunctionAssociation >> printOnType [
	^' (Function to Function association)'
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> sourceFunction [
	<MSEProperty: #sourceFunction type: #FAMIXSQLFunction opposite: #referencedFunctions>
	<MSEComment: 'the function source of the call'>
	<source>
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
	<target>
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
	^ targetFunction
]

{ #category : #accessing }
FAMIXFunctionToFunctionAssociation >> to: aFunctionAssociation [
	self targetFunction: aFunctionAssociation
]
