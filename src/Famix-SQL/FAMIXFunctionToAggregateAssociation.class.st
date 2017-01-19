"
A FAMIXViewToAggregateAssociation is the association representing a function using an aggregate.
"
Class {
	#name : #FAMIXFunctionToAggregateAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'function',
		'aggregate'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #meta }
FAMIXFunctionToAggregateAssociation class >> annotation [
	<MSEClass: #FunctionToAggregateAssociation super: #FAMIXAssociation>
	<package: #SQL>
	^self
]

{ #category : #accessing }
FAMIXFunctionToAggregateAssociation >> aggregate [
	<MSEProperty: #aggregate type: #FAMIXAggregate opposite: #referencedByFunctions> 
	<MSEComment: 'Table on which the view is defined on'>
	^ aggregate
]

{ #category : #accessing }
FAMIXFunctionToAggregateAssociation >> aggregate: aFAMIXAggregate [
	aggregate := FMMultivalueLink 
						on: self
						update: #referencedByFunctions
						from: self aggregate
						to: aFAMIXAggregate
]

{ #category : #accessing }
FAMIXFunctionToAggregateAssociation >> from [
	^ function
]

{ #category : #accessing }
FAMIXFunctionToAggregateAssociation >> from: aFunction [
	self function: aFunction
]

{ #category : #accessing }
FAMIXFunctionToAggregateAssociation >> function [
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #usedAggregates>
	<MSEComment: 'Function defined using the aggregate.'>
	^ function
]

{ #category : #accessing }
FAMIXFunctionToAggregateAssociation >> function: aFAMIXSQLFunction [
	function := FMMultivalueLink 
					on: self
					update: #referencedFunctions
					from: self function  
					to: aFAMIXSQLFunction
]

{ #category : #printing }
FAMIXFunctionToAggregateAssociation >> printOnType [
	^' (Function to Aggregate association)'
]

{ #category : #accessing }
FAMIXFunctionToAggregateAssociation >> to [
	^ aggregate
]

{ #category : #accessing }
FAMIXFunctionToAggregateAssociation >> to: anAggregateAssociation [
	self aggregate: anAggregateAssociation
]
