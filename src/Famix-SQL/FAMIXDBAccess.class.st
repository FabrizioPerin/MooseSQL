"
A FAMIXDBAccess represents accesses to a database Table by a behavioural entity.
"
Class {
	#name : #FAMIXDBAccess,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'accessorEntity',
		'accessedEntity'
	],
	#category : #'Famix-SQL'
}

{ #category : #'fame annotation' }
FAMIXDBAccess class >> annotation [
	<MSEClass: #DBAccess super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> accessedEntity [
	
	<MSEProperty: #accessedEntity type: #FAMIXRelationalEntity opposite: #sourceAccessors>
	<MSEComment: 'Relational entity accessed by a sourced entity.'>
	
	^accessedEntity
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> accessedEntity: aRelationalEntity [
	

	accessedEntity := FMMultivalueLink 
								on: self
								update: #sourceAccessors
								from: self accessedEntity  
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> accessorEntity [

	<MSEProperty: #accessorEntity type: #FAMIXSourcedEntity opposite: #dbAccesses>
	<MSEComment: 'Source entity that access a Relational entity.'>
	
	^accessorEntity
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> accessorEntity: aSourcedEntity [

	accessorEntity := FMMultivalueLink 
								on: self
								update: #dbAccesses
								from: self accessorEntity  
								to: aSourcedEntity
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> from [
	^ self accessorEntity
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> initialize [
	super initialize.
	
	accessorEntity := nil.
	accessedEntity := nil.
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from mooseName].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (DBAccess)'
]

{ #category : #'as yet unclassified' }
FAMIXDBAccess >> to [
	^ self accessedEntity
]
