"
A FAMIXSequence corresponds to the SQL sequence
"
Class {
	#name : #FAMIXSequence,
	#superclass : #FAMIXRelationalEntity,
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXSequence class >> annotation [
	<MSEClass: #Sequence super: #FAMIXRelationalEntity>
	<package: #SQL>
	^self
]

{ #category : #accessing }
FAMIXSequence >> isSequence [
	^ true
]
