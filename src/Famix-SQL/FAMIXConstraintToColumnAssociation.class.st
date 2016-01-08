"
A FAMIXConstraintToColumnAssociation is an association between a constraint and the column used by this constraint.
"
Class {
	#name : #FAMIXConstraintToColumnAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'constraint',
		'column'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXConstraintToColumnAssociation class >> annotation [
	<MSEClass: #ConstraintToColumnAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXConstraintToColumnAssociation >> column [
	<MSEProperty: #column type: #FAMIXColumn opposite: #referencedByConstraints>
	<MSEComment: 'Columns on which the constraint is applied on.'>
	^ column
]

{ #category : #accessing }
FAMIXConstraintToColumnAssociation >> column: aFAMIXColumn [
	column := FMMultivalueLink 
					on: self
					update: #referencedByConstraints
					from: self column
					to: aFAMIXColumn
]

{ #category : #accessing }
FAMIXConstraintToColumnAssociation >> constraint [
	<MSEProperty: #constraint type: #FAMIXSQLConstraint opposite: #usedColumns>
	<MSEComment: 'Constraint applied on columns.'>
	^ constraint
]

{ #category : #accessing }
FAMIXConstraintToColumnAssociation >> constraint: aFAMIXConstraint [
	constraint := FMMultivalueLink 
					on: self
					update: #usedColumns
					from: self constraint  
					to: aFAMIXConstraint
]

{ #category : #accessing }
FAMIXConstraintToColumnAssociation >> from [
	<MSEProperty: #constraint type: #FAMIXSQLConstraint opposite: #usedColumns>
	<MSEComment: 'Constraint applied on columns.'>
	^ constraint
]

{ #category : #accessing }
FAMIXConstraintToColumnAssociation >> printOn: aStream [
	aStream 
		<< 'Constraint on ';
		<< self column name
		
]

{ #category : #accessing }
FAMIXConstraintToColumnAssociation >> to [
	<MSEProperty: #column type: #FAMIXColumn opposite: #referencedByConstraints>
	<MSEComment: 'Columns on which the constraint is applied on.'>
	^ column
]