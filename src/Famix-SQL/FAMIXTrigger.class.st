Class {
	#name : #FAMIXTrigger,
	#superclass : #FAMIXRelationalEntity,
	#instVars : [
		'ownerTable',
		'invokedFunction'
	],
	#category : #'Famix-SQL'
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
FAMIXTrigger >> invokedFunction [
	<MSEProperty: #invokedFunctions type: #FAMIXFunctionCallFromTriggerAssociation opposite: #sourceTrigger> <multivalued> 
	<MSEComment: 'Functions called.'>
	
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
	<MSEProperty: #ownerTable type: #FAMIXTable opposite: #sourceTrigger>
	<MSEComment: 'Table that owns this trigger.'>
	
	^ownerTable
]

{ #category : #accessing }
FAMIXTrigger >> ownerTable: anObject [
	ownerTable := anObject
]

{ #category : #accessing }
FAMIXTrigger >> printOn: aStream [
	
	aStream nextPutAll: self name .
	aStream nextPutAll: ' on '.
	aStream nextPutAll: self ownerTable name .
	
	aStream nextPutAll: ' (Trigger)'
]
