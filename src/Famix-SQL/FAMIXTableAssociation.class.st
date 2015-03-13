Class {
	#name : #FAMIXTableAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceTable',
		'targetTable'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXTableAssociation class >> annotation [
	<MSEClass: #TableAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXTableAssociation >> from [
	^ sourceTable
]

{ #category : #accessing }
FAMIXTableAssociation >> initialize [
	super initialize.
	
	sourceTable := nil.
	targetTable := nil.
]

{ #category : #accessing }
FAMIXTableAssociation >> sourceTable [
	<MSEProperty: #sourceTable type: #FAMIXView opposite: #tables>
	<MSEComment: 'View defined'>
	^ sourceTable
]

{ #category : #accessing }
FAMIXTableAssociation >> sourceTable: aRelationalEntity [
	sourceTable := FMMultivalueLink
		on: self
		update: #tables
		from: self sourceTable
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXTableAssociation >> targetTable [
	<MSEProperty: #targetTable type: #FAMIXTable opposite: #views>
	<MSEComment: 'Table on which the view is defined on'>
	^ targetTable
]

{ #category : #accessing }
FAMIXTableAssociation >> targetTable: aRelationalEntity [

	targetTable := FMMultivalueLink 
								on: self
								update: #views
								from: self targetTable
								to: aRelationalEntity
]

{ #category : #accessing }
FAMIXTableAssociation >> to [
	^ targetTable
]
