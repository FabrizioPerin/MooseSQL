"
A FAMIXDBAccess represents accesses to a database Table by a behavioural entity.
"
Class {
	#name : #FAMIXDBAccess,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'accessorEntity',
		'accessedEntity',
		'isSelect',
		'isUpdate',
		'isDelete',
		'isInsert'
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
	
	isUpdate := false.
	isDelete := false.
	isSelect := false.
	isInsert := false.
]

{ #category : #accessing }
FAMIXDBAccess >> isDelete [
	^ isDelete
]

{ #category : #accessing }
FAMIXDBAccess >> isDelete: anObject [
	isDelete := anObject
]

{ #category : #accessing }
FAMIXDBAccess >> isInsert [
	^ isInsert
]

{ #category : #accessing }
FAMIXDBAccess >> isInsert: anObject [
	isInsert := anObject
]

{ #category : #accessing }
FAMIXDBAccess >> isSelect [
	^ isSelect
]

{ #category : #accessing }
FAMIXDBAccess >> isSelect: anObject [
	isSelect := anObject
]

{ #category : #accessing }
FAMIXDBAccess >> isUpdate [
	^ isUpdate
]

{ #category : #accessing }
FAMIXDBAccess >> isUpdate: anObject [
	isUpdate := anObject
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
