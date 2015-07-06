"
A FAMIXViewToTableAssociation is an association from a view and the table used to build the view.
	table:		table used to build the view
	view:		view


"
Class {
	#name : #FAMIXViewToTableAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'view',
		'table'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #accessing }
FAMIXViewToTableAssociation >> from [
	<MSEProperty: #view type: #FAMIXView opposite: #ofTables>
	<MSEComment: 'View defined on a table'>
	^self view
]

{ #category : #accessing }
FAMIXViewToTableAssociation >> initialize [
	super initialize.

	view := nil.
	table := nil.
]

{ #category : #accessing }
FAMIXViewToTableAssociation >> printOn: aStream [
	aStream 
		<< ('{1}{2}{3}' format: {self from name. '->'. self to name})
		
]

{ #category : #accessing }
FAMIXViewToTableAssociation >> table [
	<MSEProperty: #table type: #FAMIXTable opposite: #views>
	<MSEComment: 'Table on which the view is defined on'>
	^ table
]

{ #category : #accessing }
FAMIXViewToTableAssociation >> table: aFAMIXTable [
	table := FMMultivalueLink 
					on: self
					update: #views
					from: self table  
					to: aFAMIXTable
]

{ #category : #accessing }
FAMIXViewToTableAssociation >> to [
	<MSEProperty: #table type: #FAMIXTable opposite: #views>
	<MSEComment: 'Table on which the view is defined on'>
	^self table
]

{ #category : #accessing }
FAMIXViewToTableAssociation >> view [
	<MSEProperty: #view type: #FAMIXView opposite: #ofTables>
	<MSEComment: 'View defined on a table'>
	^ view
]

{ #category : #accessing }
FAMIXViewToTableAssociation >> view: aFAMIXView [
	view := FMMultivalueLink 
					on: self
					update: #ofTables
					from: self view  
					to: aFAMIXView
]
