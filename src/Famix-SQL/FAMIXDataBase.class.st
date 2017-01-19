Class {
	#name : #FAMIXDataBase,
	#superclass : #FAMIXRelationalEntity,
	#instVars : [
		'tables',
		'functions'
	],
	#category : #'Famix-SQL'
}

{ #category : #meta }
FAMIXDataBase class >> annotation [
	<MSEClass: #DataBase super: #FAMIXRelationalEntity>
	<package: #SQL>
	^self
]

{ #category : #accessing }
FAMIXDataBase >> addTable: aFAMIXDBTable [
	tables add: aFAMIXDBTable.
]

{ #category : #accessing }
FAMIXDataBase >> functions [
	<MSEProperty: #functions type: #FAMIXSQLFunction opposite: #ownerDataBase>
	<multivalued>
	<derived>
	<MSEComment: 'functions belonging to the database'>
	^ functions
]

{ #category : #accessing }
FAMIXDataBase >> functions: aOrderedCollection [

	functions  value: aOrderedCollection.
]

{ #category : #initialization }
FAMIXDataBase >> initialize [
	super initialize.
	tables := FMMultivalueLink 
					on: self
					opposite: #ownerDataBase:.
	functions := FMMultivalueLink 
					on: self
					opposite: #ownerDataBase:.
]

{ #category : #accessing }
FAMIXDataBase >> printOn: aStream [
	
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Database)'
]

{ #category : #accessing }
FAMIXDataBase >> tables [
<MSEProperty: #tables type: #FAMIXTable opposite: #ownerDataBase> <multivalued> <derived>
	<MSEComment: 'Tables belonging to the database'>
	^tables
]

{ #category : #accessing }
FAMIXDataBase >> tables: aOrderedCollection [

	tables  value: aOrderedCollection.
]
