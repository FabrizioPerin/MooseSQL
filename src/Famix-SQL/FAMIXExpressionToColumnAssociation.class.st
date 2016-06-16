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
	<MSEProperty: #sourceExpression type: #FAMIXSQLExpression opposite: #referencedColumns>
	<MSEComment: 'Expression references columns.'>
	^ sourceExpression
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> from: anExpression [
	self sourceExpression: anExpression
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
	<MSEProperty: #sourceExpression type: #FAMIXSQLExpression opposite: #referencedColumns>
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
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedByExpressions>
	<MSEComment: 'Columns referenced by an expression.'>
	^ targetColumn
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> targetColumn: anEntity [

	targetColumn := FMMultivalueLink 
								on: self
								update: #referencedByExpressions
								from: self targetColumn
								to: anEntity
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> to [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedByExpressions>
	<MSEComment: 'Columns referenced by an expression.'>
	^ targetColumn
]

{ #category : #accessing }
FAMIXExpressionToColumnAssociation >> to: aColumnAssociation [
	self targetColumn: aColumnAssociation
]
