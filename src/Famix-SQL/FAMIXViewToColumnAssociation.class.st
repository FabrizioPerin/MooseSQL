"
A FAMIXViewToColumnAssociation is an association from a view to a column used to build the view.
	column:		column used in the where clause to build the view
	view:		view
"
Class {
	#name : #FAMIXViewToColumnAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'view',
		'column'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #meta }
FAMIXViewToColumnAssociation class >> annotation [
	<MSEClass: #ViewToColumAssociation super: #FAMIXAssociation>
	<package: #SQL>
	^self
]

{ #category : #accessing }
FAMIXViewToColumnAssociation >> column [
	<MSEProperty: #column type: #FAMIXColumn opposite: #referencedByViews>
	<MSEComment: 'Columns on which the view is defined on'>
	^ column
]

{ #category : #accessing }
FAMIXViewToColumnAssociation >> column: aFAMIXColumn [
	column := FMMultivalueLink 
					on: self
					update: #referencedByViews
					from: self column
					to: aFAMIXColumn
]

{ #category : #accessing }
FAMIXViewToColumnAssociation >> from [
	^ view
]

{ #category : #accessing }
FAMIXViewToColumnAssociation >> from: aView [
	self view: aView
]

{ #category : #'initialize-release' }
FAMIXViewToColumnAssociation >> initialize [
	super initialize.
	
	view := nil.
	column := nil.
]

{ #category : #printing }
FAMIXViewToColumnAssociation >> printOnType [
	^' (View to Column association)'
]

{ #category : #accessing }
FAMIXViewToColumnAssociation >> to [
	^ column
]

{ #category : #accessing }
FAMIXViewToColumnAssociation >> to: aColumn [
	self column: aColumn
]

{ #category : #accessing }
FAMIXViewToColumnAssociation >> view [
	<MSEProperty: #view type: #FAMIXView opposite: #usedColumns>
	<MSEComment: 'View defined using a column'>
	^ view
]

{ #category : #accessing }
FAMIXViewToColumnAssociation >> view: aFAMIXView [
	view := FMMultivalueLink 
					on: self
					update: #usedColumns
					from: self view  
					to: aFAMIXView
]
