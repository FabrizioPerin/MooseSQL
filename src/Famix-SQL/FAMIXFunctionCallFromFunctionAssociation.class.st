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
	<MSEClass: #FunctionCallFromFunctionAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> from [
	<MSEProperty: #sourceFunction type: #FAMIXSQLFunction opposite: #referencedFunctions>
	<MSEComment: 'the function source of the call'>
	^ sourceFunction 
]

{ #category : #'as yet unclassified' }
FAMIXFunctionCallFromFunctionAssociation >> initialize [
	super initialize.
	
	sourceFunction := nil.
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
FAMIXFunctionCallFromFunctionAssociation >> targetFunction [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #calledFromFunctions>
	<MSEComment: 'Function referenced by the function.'>
	^ targetFunction
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> targetFunction: anEntity [

	targetFunction := FMMultivalueLink 
								on: self
								update: #calledFromFunctions
								from: self targetFunction
								to: anEntity
]

{ #category : #accessing }
FAMIXFunctionCallFromFunctionAssociation >> to [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #calledFromFunctions>
	<MSEComment: 'Function referenced by the function.'>
	^ targetFunction
]
