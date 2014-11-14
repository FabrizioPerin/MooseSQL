Class {
	#name : #FAMIXFKAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceTable',
		'targetTable',
		'sourceColumn',
		'targetColumn'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXFKAssociation class >> annotation [
	<MSEClass: #FKAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> from [

	^ self sourceColumn
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> initialize [
	super initialize.
	
	sourceTable := nil.
	targetTable := nil.
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (FK association)'
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> sourceColumn [

	<MSEProperty: #sourceColumn type: #FAMIXRelationalEntity opposite: #references>
	<MSEComment: 'Relational element references another relational element.'>
	
	^sourceColumn 
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> sourceColumn: aRelationalEntity [
	
	sourceColumn := FMMultivalueLink 
								on: self
								update: #references
								from: self sourceColumn
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> sourceTable [

	<MSEProperty: #sourceColumn type: #FAMIXRelationalEntity > <derived>
	<MSEComment: 'Relational table references another relational table.'>
	
	^sourceColumn ownerTable
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> targetColumn [
	<MSEProperty: #targetColumn type: #FAMIXRelationalEntity opposite: #referencedBy>
	<MSEComment: 'Relational element referenced by another relational element.'>
	
	^targetColumn
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> targetColumn: aRelationalEntity [

	targetTable := FMMultivalueLink 
								on: self
								update: #referencedBy
								from: self targetColumn
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> targetTable [
	<MSEProperty: #targetTable type: #FAMIXRelationalEntity > <derived>
	<MSEComment: 'Relational table referenced by another relational table.'>
	
	^targetColumn ownerTable
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> to [

	^ self targetColumn
]
