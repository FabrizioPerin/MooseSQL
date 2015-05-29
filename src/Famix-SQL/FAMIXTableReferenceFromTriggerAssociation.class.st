Class {
	#name : #FAMIXTableReferenceFromTriggerAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'table',
		'sourceTrigger'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXTableReferenceFromTriggerAssociation class >> annotation [
	<MSEClass: #TableReferenceFromTrigger super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXTableReferenceFromTriggerAssociation >> from [
	^self sourceTrigger
]

{ #category : #accessing }
FAMIXTableReferenceFromTriggerAssociation >> initialize [
	super initialize.
	sourceTrigger := nil.
	table := nil.
]

{ #category : #accessing }
FAMIXTableReferenceFromTriggerAssociation >> sourceTrigger [
	<MSEProperty: #sourceTrigger type: #FAMIXTrigger opposite: #ownerTable>
	<MSEComment: 'the trigger source of the table reference'>
	^ sourceTrigger
]

{ #category : #accessing }
FAMIXTableReferenceFromTriggerAssociation >> sourceTrigger: anObject [
	sourceTrigger := FMMultivalueLink 
		on: self
		update: #ownerTable
		from: self sourceTrigger
		to: anObject
]

{ #category : #accessing }
FAMIXTableReferenceFromTriggerAssociation >> table [
	<MSEProperty: #table type: #FAMIXTable opposite: #triggers>
	<MSEComment: 'Table referenced by a trigger'>
	^ table
]

{ #category : #accessing }
FAMIXTableReferenceFromTriggerAssociation >> table: anObject [
	table := FMMultivalueLink 
		on: self
		update: #triggers
		from: self table
		to: anObject
]

{ #category : #accessing }
FAMIXTableReferenceFromTriggerAssociation >> to [
	^self table
]
