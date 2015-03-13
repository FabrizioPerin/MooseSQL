Class {
	#name : #FAMIXColumnAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceColumn',
		'targetColumn'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation class >> annotation [
	<MSEClass: #ColumnAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> from [

	^ self sourceColumn
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: self printOnType
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> printOnType [
	^' (Column association)'
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> sourceColumn [

	<MSEProperty: #sourceColumn type: #FAMIXRelationalEntity opposite: #references>
	<MSEComment: 'Relational element references another relational element.'>
	
	^sourceColumn 
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> sourceColumn: aRelationalEntity [
	sourceColumn := FMMultivalueLink
		on: self
		update: #references
		from: self sourceColumn
		to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> sourceTable [

	<MSEProperty: #sourceColumn type: #FAMIXRelationalEntity > <derived>
	<MSEComment: 'Relational table references another relational table.'>
	
	^sourceColumn ownerTable
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> targetColumn [
	<MSEProperty: #targetColumn type: #FAMIXRelationalEntity opposite: #referencedBy>
	<MSEComment: 'Relational element referenced by another relational element.'>
	
	^targetColumn
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> targetColumn: aRelationalEntity [

	targetColumn := FMMultivalueLink 
								on: self
								update: #referencedBy
								from: self targetColumn
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> targetTable [
	<MSEProperty: #targetTable type: #FAMIXRelationalEntity > <derived>
	<MSEComment: 'Relational table referenced by another relational table.'>
	
	^targetColumn ownerTable
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> to [

	^ self targetColumn
]
