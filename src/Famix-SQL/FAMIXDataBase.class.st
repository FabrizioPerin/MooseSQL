Class {
	#name : #FAMIXDataBase,
	#superclass : #FAMIXRelationalEntity,
	#instVars : [
		'tables'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXDataBase class >> annotation [
	<MSEClass: #DataBase super: #FAMIXRelationalEntity>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXDataBase >> addTable: aFAMIXDBTable [
	tables add: aFAMIXDBTable.
]

{ #category : #initialization }
FAMIXDataBase >> initialize [
	super initialize.
	tables := OrderedCollection new.
]

{ #category : #accessing }
FAMIXDataBase >> printOn: aStream [
	
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Database)'
]

{ #category : #accessing }
FAMIXDataBase >> tables [
	^tables
]

{ #category : #accessing }
FAMIXDataBase >> tables: aOrderedCollection [

	tables := aOrderedCollection.
]
