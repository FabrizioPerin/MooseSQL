Class {
	#name : #FAMIXExpressionToFunctionAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetFunction',
		'sourceExpression'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #meta }
FAMIXExpressionToFunctionAssociation class >> annotation [
	<MSEClass: #ExpressionToFunctionAssociation super: #FAMIXAssociation>
	<package: #SQL>
	^self
]

{ #category : #accessing }
FAMIXExpressionToFunctionAssociation >> from [
	^ sourceExpression
]

{ #category : #accessing }
FAMIXExpressionToFunctionAssociation >> from: anExpression [
	self sourceExpression: anExpression
]

{ #category : #'initialize-release' }
FAMIXExpressionToFunctionAssociation >> initialize [
	super initialize.
	
	sourceExpression := nil.
	targetFunction := nil.
]

{ #category : #printing }
FAMIXExpressionToFunctionAssociation >> printOnType [
	^' (Expression to Function association)'
]

{ #category : #accessing }
FAMIXExpressionToFunctionAssociation >> sourceExpression [
	<MSEProperty: #sourceExpression type: #FAMIXSQLExpression opposite: #referencedFunctions>
	<MSEComment: 'Expression references functions.'>
	<source>
	^ sourceExpression
]

{ #category : #accessing }
FAMIXExpressionToFunctionAssociation >> sourceExpression: aRelationalEntity [
	sourceExpression := FMMultivalueLink
		on: self
		update: #referencedFunctions
		from: self sourceExpression
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXExpressionToFunctionAssociation >> targetFunction [
	<MSEProperty: #targetFunction type: #FAMIXSQLFunction opposite: #calledFromExpressions>
	<MSEComment: 'Functions referenced by an expression.'>
	<target>
	^ targetFunction
]

{ #category : #accessing }
FAMIXExpressionToFunctionAssociation >> targetFunction: anEntity [

	targetFunction := FMMultivalueLink 
								on: self
								update: #calledFromExpressions
								from: self targetFunction
								to: anEntity
]

{ #category : #accessing }
FAMIXExpressionToFunctionAssociation >> to [
	^ targetFunction
]

{ #category : #accessing }
FAMIXExpressionToFunctionAssociation >> to: aFunctionAssociation [
	self targetFunction: aFunctionAssociation
]
