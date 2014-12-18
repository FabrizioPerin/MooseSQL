Class {
	#name : #FAMIXFKAssociation,
	#superclass : #FAMIXColumnAssociation,
	#category : #'Famix-SQL'
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
