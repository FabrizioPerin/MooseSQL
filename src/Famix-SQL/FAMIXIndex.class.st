Class {
	#name : #FAMIXIndex,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'isUnique',
		'indexedColumns',
		'referencedTable'
	],
	#category : #'Famix-SQL'
}

{ #category : #accessing }
FAMIXIndex >> indexedColumns [
	^ indexedColumns
]

{ #category : #accessing }
FAMIXIndex >> indexedColumns: anObject [
	indexedColumns := anObject
]

{ #category : #accessing }
FAMIXIndex >> initialize [
	super initialize.
	indexedColumns := OrderedCollection new.
	isUnique := false.
]

{ #category : #accessing }
FAMIXIndex >> isUnique [
	^ isUnique
]

{ #category : #accessing }
FAMIXIndex >> isUnique: anObject [
	isUnique := anObject
]

{ #category : #accessing }
FAMIXIndex >> referencedTable [
	^ referencedTable
]

{ #category : #accessing }
FAMIXIndex >> referencedTable: anObject [
	referencedTable := anObject
]
