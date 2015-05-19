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
FAMIXFKAssociation >> printOnType [
	^'(FK association)'
]
