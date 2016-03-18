Class {
	#name : #FAMIXExpressionToColumnAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'targetColumn',
		'sourceExpression'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #meta }
FAMIXExpressionToColumnAssociation class >> annotation [
	<MSEClass: #ExpressionToColumnAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> from [
	<MSEProperty: #sourceExpression type: #FAMIXExpression opposite: #referencedColumns>
	<MSEComment: 'Expression references columns.'>
	^ sourceExpression
]

{ #category : #'initialize-release' }
FAMIXExpressionToColumnAssociation >> initialize [
	super initialize.
	
	targetColumn := nil.
	sourceExpression := nil.
]

{ #category : #printing }
FAMIXExpressionToColumnAssociation >> printOnType [
	^' (Expression to Column association)'
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> sourceExpression [
	<MSEProperty: #sourceExpression type: #FAMIXExpression opposite: #referencedColumns>
	<MSEComment: 'Expression references columns.'>
	^ sourceExpression
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> sourceExpression: aRelationalEntity [
	sourceExpression := FMMultivalueLink
		on: self
		update: #referencedColumns
		from: self sourceExpression
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> targetColumn [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #calledFromExpressions>
	<MSEComment: 'Columns referenced by an expression.'>
	^ targetColumn
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> targetColumn: anEntity [

	targetColumn := FMMultivalueLink 
								on: self
								update: #calledFromExpressions
								from: self targetColumn
								to: anEntity
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> to [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #calledFromExpressions>
	<MSEComment: 'Columns referenced by an expression.'>
	^ targetColumn
]
