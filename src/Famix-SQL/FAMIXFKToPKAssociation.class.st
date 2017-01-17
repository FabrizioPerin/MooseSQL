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
	<package: #SQL>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXFKToPKAssociation >> from [
	<MSEProperty: #from type: #FAMIXColumn opposite: #usedColumns>
	<MSEComment: 'Column (mostly from a view) references another column.'>
	
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
FAMIXFKToPKAssociation >> to [
	<MSEProperty: #to type: #FAMIXColumn opposite: #referencedByColumns>
	<MSEComment: 'Column referenced by another column.'>
	
	^ self targetColumn
]
