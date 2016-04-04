"
A FAMIXConstraintToFunctionAssociation is an association between a constraint and the function used by this constraint.
"
Class {
	#name : #FAMIXConstraintToFunctionAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'constraint',
		'function'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXConstraintToFunctionAssociation class >> annotation [
	<MSEClass: #ConstraintToFunctionAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXConstraintToFunctionAssociation >> constraint [
	<MSEProperty: #constraint type: #FAMIXSQLConstraint opposite: #usedFunctions>
	<MSEComment: 'Constraint which use the function.'>
	^ constraint
]

{ #category : #accessing }
FAMIXConstraintToFunctionAssociation >> constraint: aFAMIXConstraint [
	constraint := FMMultivalueLink 
					on: self
					update: #usedFunctions
					from: self constraint  
					to: aFAMIXConstraint
]

{ #category : #accessing }
FAMIXConstraintToFunctionAssociation >> from [
	<MSEProperty: #constraint type: #FAMIXSQLConstraint opposite: #usedFunctions>
	<MSEComment: 'Constraint which use the function.'>
	^ constraint
]

{ #category : #accessing }
FAMIXConstraintToFunctionAssociation >> from: aConstraint [
	self constraint: aConstraint
]

{ #category : #accessing }
FAMIXConstraintToFunctionAssociation >> function [
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #calledFromConstraints>
	<MSEComment: 'Function referenced by the constraint.'>
	^ function
]

{ #category : #accessing }
FAMIXConstraintToFunctionAssociation >> function: aFAMIXSQLFunction [
	function := FMMultivalueLink 
					on: self
					update: #calledFromConstraints
					from: self function
					to: aFAMIXSQLFunction
]

{ #category : #accessing }
FAMIXConstraintToFunctionAssociation >> printOn: aStream [
	aStream 
		<< 'Constraint on ';
		<< self function name
		
]

{ #category : #accessing }
FAMIXConstraintToFunctionAssociation >> to [
	<MSEProperty: #function type: #FAMIXSQLFunction opposite: #calledFromConstraints>
	<MSEComment: 'Function referenced by the constraint.'>
	^ function
]

{ #category : #accessing }
FAMIXConstraintToFunctionAssociation >> to: aFunction [
	self function: aFunction
]
