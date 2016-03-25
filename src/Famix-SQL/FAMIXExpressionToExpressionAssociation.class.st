Class {
	#name : #FAMIXExpressionToExpressionAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetExpression',
		'sourceExpression'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #meta }
FAMIXExpressionToExpressionAssociation class >> annotation [
	<MSEClass: #ExpressionToExpressionAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXExpressionToExpressionAssociation >> from [
<MSEProperty: #sourceExpression type: #FAMIXSQLExpression opposite: #referencedFunctions>
	<MSEComment: 'Expression references functions.'>
	^ sourceExpression
]

{ #category : #'initialize-release' }
FAMIXExpressionToExpressionAssociation >> initialize [
	super initialize.
	
	targetExpression := nil.
	sourceExpression := nil.
]

{ #category : #printing }
FAMIXExpressionToExpressionAssociation >> printOnType [
	^' (Expression to Expression association)'
]

{ #category : #accessing }
FAMIXExpressionToExpressionAssociation >> sourceExpression [
	<MSEProperty: #sourceExpression type: #FAMIXSQLExpression opposite: #referencedExpressions>
	<MSEComment: 'Expression references functions.'>
	^ sourceExpression
]

{ #category : #accessing }
FAMIXExpressionToExpressionAssociation >> sourceExpression: aRelationalEntity [
	sourceExpression := FMMultivalueLink
		on: self
		update: #referencedExpressions
		from: self sourceExpression
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXExpressionToExpressionAssociation >> targetExpression [
	<MSEProperty: #targetExpression type: #FAMIXSQLExpression opposite: #calledByExpression>
	<MSEComment: 'Expressions referenced by an expression.'>
	^ targetExpression
]

{ #category : #accessing }
FAMIXExpressionToExpressionAssociation >> targetExpression: anEntity [

	targetExpression := FMMultivalueLink 
								on: self
								update: #calledByExpression
								from: self targetExpression
								to: anEntity
]

{ #category : #accessing }
FAMIXExpressionToExpressionAssociation >> to [
	<MSEProperty: #targetExpression type: #FAMIXSQLExpression opposite: #usedByExpressions>
	<MSEComment: 'Expressions referenced by an expression.'>
	^ targetExpression
]
