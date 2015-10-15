"
A FAMIXTrigger corresponds to an sql trigger

    Instance Variables
	invokedFunction:		function that the trigger invokes
	ownerTable:		table to which the trigger is associated.
"
Class {
	#name : #FAMIXTrigger,
	#superclass : #FAMIXRelationalEntity,
	#instVars : [
		'ownerTable',
		'invokedFunction'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXTrigger class >> annotation [
	<MSEClass: #Trigger super: #FAMIXRelationalEntity>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXTrigger >> addDependencyIfNotExistTo: aFAMIXTable [ 
	aFAMIXTable addDependencyIfNotExistFromTrigger: self.
]

{ #category : #accessing }
FAMIXTrigger >> belongsTo [
	<MSEProperty: #ownerTable type: #FAMIXTable opposite: #triggers>
	<MSEComment: 'Table that owns this trigger.'>
	
	^self ownerTable
]

{ #category : #querying }
FAMIXTrigger >> dependentEntities [
	^ {self invokedFunction}  , {self ownerTable} 
]

{ #category : #accessing }
FAMIXTrigger >> invokedFunction [
	<MSEProperty: #invokedFunction type: #FAMIXSQLFunction opposite: #calledFromTriggers>  
	<MSEComment: 'Function called.'>
	
	^invokedFunction
]

{ #category : #accessing }
FAMIXTrigger >> invokedFunction: anObject [
	invokedFunction := anObject
]

{ #category : #testing }
FAMIXTrigger >> isTrigger [
	^ true
]

{ #category : #accessing }
FAMIXTrigger >> ownerTable [
	<MSEProperty: #ownerTable type: #FAMIXTable opposite: #triggers>
	<MSEComment: 'Table that owns this trigger.'>
	
	^ownerTable
]

{ #category : #accessing }
FAMIXTrigger >> ownerTable: aFAMIXTableOrNil [
	ownerTable := FMMultivalueLink 
		on: self
		update: #triggers
		from: self ownerTable
		to: aFAMIXTableOrNil
]

{ #category : #accessing }
FAMIXTrigger >> printOn: aStream [
	
	aStream nextPutAll: self name .
	aStream nextPutAll: ' on '.
	aStream nextPutAll: self ownerTable name .
	
	aStream nextPutAll: ' (Trigger)'
]

{ #category : #querying }
FAMIXTrigger >> userEntities [
	^ OrderedCollection new.
]
