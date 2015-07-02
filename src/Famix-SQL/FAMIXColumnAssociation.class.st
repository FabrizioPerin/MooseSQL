"
A FAMIXColumnAssociation is an association between two columns .  #sourceColumn can be  a column of a view 

Instance Variables
	sourceColumn:		column of a table (mostly a view except in case of FKAssociation)
	targetColumn:		column of a table

"
Class {
	#name : #FAMIXColumnAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceColumn',
		'targetColumn'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation class >> annotation [
	<MSEClass: #ColumnAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> from [

	<MSEProperty: #sourceColumn type: #FAMIXColumn opposite: #usedColumns>
	<MSEComment: 'Column (mostly from a view) references another column.'>
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

	<MSEProperty: #sourceColumn type: #FAMIXColumn opposite: #usedColumns>
	<MSEComment: 'Column (mostly from a view) references another column.'>
	
	^sourceColumn 
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> sourceColumn: aRelationalEntity [
	sourceColumn := FMMultivalueLink
		on: self
		update: #usedColumns
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
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedByColumns>
	<MSEComment: 'Column referenced by another column.'>
	
	^targetColumn
]

{ #category : #'as yet unclassified' }
FAMIXColumnAssociation >> targetColumn: aRelationalEntity [

	targetColumn := FMMultivalueLink 
								on: self
								update: #referencedByColumns
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
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedByColumns>
	<MSEComment: 'Column referenced by another column.'>
	^ self targetColumn
]
