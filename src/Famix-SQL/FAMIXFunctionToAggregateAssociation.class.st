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
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #usedFunctions>
	<MSEComment: 'Function defined using the aggregate.'>
	^ function
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

{ #category : #accessing }
FAMIXFunctionToAggregateAssociation >> to [
	<MSEProperty: #aggregate type: #FAMIXAggregate opposite: #referencedByFunctions> 
	<MSEComment: 'Table on which the view is defined on'>
	^ aggregate
]
