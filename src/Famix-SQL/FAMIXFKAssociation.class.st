Class {
	#name : #FAMIXFKAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceTable',
		'targetTable'
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
	
	^sourceTable 
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> sourceColumn: aRelationalEntity [
	
	sourceTable := FMMultivalueLink 
								on: self
								update: #references
								from: self sourceColumn
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> targetColumn [
	<MSEProperty: #targetColumn type: #FAMIXRelationalEntity opposite: #referencedBy>
	<MSEComment: 'Relational element referenced by another relational element.'>
	
	^targetTable
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
FAMIXFKAssociation >> to [

	^ self targetColumn
]
