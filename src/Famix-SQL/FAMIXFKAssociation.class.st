"
a FamixFKAssociation is an association from a column of a table to a column of another table. This later is a primary key in its table.
"
Class {
	#name : #FAMIXFKAssociation,
	#superclass : #FAMIXColumnAssociation,
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXFKAssociation class >> annotation [
	<MSEClass: #FKAssociation super: #FAMIXColumnAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> from [
	<MSEProperty: #sourceColumn type: #FAMIXColumn opposite: #usedPK>
	<MSEComment: 'Relational element references another relational element.'>
	^ self sourceColumn
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> printOnType [
	^'(FK association)'
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> sourceColumn [
	<MSEProperty: #sourceColumn type: #FAMIXColumn opposite: #usedPK>
	<MSEComment: 'Column (mostly from a view) references another column.'>
	
	^sourceColumn 
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> targetColumn [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedByPK>
	<MSEComment: 'Column (primary key) referenced by foreign key.'>
	
	^targetColumn 
]

{ #category : #'as yet unclassified' }
FAMIXFKAssociation >> to [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedByPK>
	<MSEComment: 'Column (primary key) referenced by foreign key.'>
	^ self targetColumn
]
