Class {
	#name : #FAMIXViewAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'view',
		'table'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #accessing }
FAMIXViewAssociation >> from [
	^self view
]

{ #category : #accessing }
FAMIXViewAssociation >> initialize [
	super initialize.

	view := nil.
	table := nil.
]

{ #category : #accessing }
FAMIXViewAssociation >> printOn: aStream [
	aStream 
		<< ('{1}{2}{3}' format: {self from name. '->'. self to name})
		
]

{ #category : #accessing }
FAMIXViewAssociation >> table [
	<MSEProperty: #table type: #FAMIXTable opposite: #views>
	<MSEComment: 'Table on which the view is defined on'>
	^ table
]

{ #category : #accessing }
FAMIXViewAssociation >> table: aFAMIXTable [
	table := FMMultivalueLink 
					on: self
					update: #views
					from: self table  
					to: aFAMIXTable
]

{ #category : #accessing }
FAMIXViewAssociation >> to [
	^self table
]

{ #category : #accessing }
FAMIXViewAssociation >> view [
	<MSEProperty: #view type: #FAMIXView opposite: #ofTables>
	<MSEComment: 'View defined on a table'>
	^ view
]

{ #category : #accessing }
FAMIXViewAssociation >> view: aFAMIXView [
	view := FMMultivalueLink 
					on: self
					update: #ofTables
					from: self view  
					to: aFAMIXView
]
