"
a FamixFKAssociation is an association from a column of a table to a column of another table. This later is a primary key in its table.
"
Class {
	#name : #FAMIXFKToPKAssociation,
	#superclass : #FAMIXColumnToColumnAssociation,
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXFKToPKAssociation class >> annotation [
	<MSEClass: #FKToPKAssociation super: #FAMIXColumnToColumnAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXFKToPKAssociation >> from [
	<MSEProperty: #from type: #FAMIXColumn opposite: #referencedByFK>
	<MSEComment: 'Relational element references another relational element.'>
	^ self sourceColumn
]

{ #category : #'as yet unclassified' }
FAMIXFKToPKAssociation >> isFKAssociation [
	^true
]

{ #category : #'as yet unclassified' }
FAMIXFKToPKAssociation >> printOnType [
	^'(FK association)'
]

{ #category : #'as yet unclassified' }
FAMIXFKToPKAssociation >> sourceColumn [
	<MSEProperty: #sourceColumn type: #FAMIXColumn opposite: #referencedByFK>
	<MSEComment: 'Column (mostly from a view) references another column.'>
	
	^sourceColumn 
]

{ #category : #'as yet unclassified' }
FAMIXFKToPKAssociation >> sourceColumn: aRelationalEntity [
	sourceColumn := FMMultivalueLink
		on: self
		update: #referencedByFK
		from: self sourceColumn
		to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXFKToPKAssociation >> targetColumn [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #usedPK>
	<MSEComment: 'Column (primary key) referenced by foreign key.'>
	
	^targetColumn 
]

{ #category : #'as yet unclassified' }
FAMIXFKToPKAssociation >> to [
	<MSEProperty: #to type: #FAMIXColumn opposite: #usedPK>
	<MSEComment: 'Column (primary key) referenced by foreign key.'>
	^ self targetColumn
]
