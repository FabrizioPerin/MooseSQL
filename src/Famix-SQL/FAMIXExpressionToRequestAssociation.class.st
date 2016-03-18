Class {
	#name : #FAMIXExpressionToRequestAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetRequest',
		'sourceExpression'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #meta }
FAMIXExpressionToRequestAssociation class >> annotation [
	<MSEClass: #ExpressionToRequestAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXExpressionToRequestAssociation >> from [
	<MSEProperty: #sourceExpression type: #FAMIXExpression opposite: #referencedColumns>
	<MSEComment: 'Expression references columns.'>
	^ sourceExpression
]

{ #category : #'initialize-release' }
FAMIXExpressionToRequestAssociation >> initialize [
	super initialize.
	
	targetRequest := nil.
	sourceExpression := nil.
]

{ #category : #printing }
FAMIXExpressionToRequestAssociation >> printOnType [
	^' (Expression to Request association)'
]

{ #category : #accessing }
FAMIXExpressionToRequestAssociation >> sourceExpression [
	<MSEProperty: #sourceExpression type: #FAMIXExpression opposite: #referencedColumns>
	<MSEComment: 'Expression references columns.'>
	^ sourceExpression
]

{ #category : #accessing }
FAMIXExpressionToRequestAssociation >> sourceExpression: aRelationalEntity [
	sourceExpression := FMMultivalueLink
		on: self
		update: #referencedColumns
		from: self sourceExpression
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXExpressionToRequestAssociation >> targetRequest [
	<MSEProperty: #targetRequest type: #FAMIXRequest opposite: #usedInExpressions>
	<MSEComment: 'Request used in an expression.'>
	^ targetRequest
]

{ #category : #accessing }
FAMIXExpressionToRequestAssociation >> targetRequest: anEntity [

	targetRequest := FMMultivalueLink 
								on: self
								update: #usedInExpressions
								from: self targetRequest
								to: anEntity
]

{ #category : #accessing }
FAMIXExpressionToRequestAssociation >> to [
	<MSEProperty: #targetRequest type: #FAMIXRequest opposite: #usedInExpressions>
	<MSEComment: 'Request used in an expression.'>
	^ targetRequest
]
