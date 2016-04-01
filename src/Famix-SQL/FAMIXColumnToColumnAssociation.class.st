"
A FAMIXColumnAssociation is an association between two columns .  #sourceColumn can be  a column of a view 

Instance Variables
	sourceColumn:		column of a table (mostly a view except in case of FKAssociation)
	targetColumn:		column of a table

"
Class {
	#name : #FAMIXColumnToColumnAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceColumn',
		'targetColumn'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXColumnToColumnAssociation class >> annotation [
	<MSEClass: #ColumnToColumnAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXColumnToColumnAssociation >> from [
	<MSEProperty: #from type: #FAMIXColumn opposite: #usedColumns>
	<MSEComment: 'Column (mostly from a view) references another column.'>
	
	^ self sourceColumn
]

{ #category : #'initialize-release' }
FAMIXColumnToColumnAssociation >> initialize [
	super initialize.
	
	sourceColumn := nil.
	targetColumn := nil.
]

{ #category : #printing }
FAMIXColumnToColumnAssociation >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: self printOnType
]

{ #category : #printing }
FAMIXColumnToColumnAssociation >> printOnType [
	^' (Column association)'
]

{ #category : #accessing }
FAMIXColumnToColumnAssociation >> sourceColumn [

	<MSEProperty: #sourceColumn type: #FAMIXColumn opposite: #usedColumns>
	<MSEComment: 'Column referencing another column.'>
	
	^sourceColumn 
]

{ #category : #accessing }
FAMIXColumnToColumnAssociation >> sourceColumn: aRelationalEntity [
	sourceColumn := FMMultivalueLink
		on: self
		update: #usedColumns
		from: self sourceColumn
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXColumnToColumnAssociation >> sourceTable [

	<MSEProperty: #sourceTable type: #FAMIXRelationalEntity > <derived>
	<MSEComment: 'Column referenced by another column.'>
	
	^sourceColumn ownerTable
]

{ #category : #accessing }
FAMIXColumnToColumnAssociation >> targetColumn [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedByColumns>
	<MSEComment: 'Column referenced by another column.'>
	
	^targetColumn
]

{ #category : #accessing }
FAMIXColumnToColumnAssociation >> targetColumn: aRelationalEntity [

	targetColumn := FMMultivalueLink 
								on: self
								update: #referencedByColumns
								from: self targetColumn
								to: aRelationalEntity
]

{ #category : #accessing }
FAMIXColumnToColumnAssociation >> targetTable [
	<MSEProperty: #targetTable type: #FAMIXRelationalEntity > <derived>
	<MSEComment: 'Relational table referenced by another relational table.'>
	
	^targetColumn ownerTable
]

{ #category : #accessing }
FAMIXColumnToColumnAssociation >> to [
	<MSEProperty: #to type: #FAMIXColumn opposite: #referencedByColumns>
	<MSEComment: 'Column referenced by another column.'>
	
	^ self targetColumn
]
