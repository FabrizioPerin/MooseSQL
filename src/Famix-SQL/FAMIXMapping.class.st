"
FAMIXMapping represents the relation between a FAMIXClass or a FAMIXAttribute and a Database table and its fields. A FAMIXClass maps in a Table and a FAMIXAttribute map in a column.

Instance Variables
	mapped:		a FMMultivalueLink containing relational entities
	maps:		a FMMultivalueLink containing named entities

mapped
	- xxxxx

maps
	- xxxxx

"
Class {
	#name : #FAMIXMapping,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'mapSource',
		'mapTarget'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXMapping class >> annotation [
	<MSEClass: #Mapping super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> from [

	^ self mapSource
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> initialize [
	super initialize.
	"maps := FMMultivalueLink on: self opposite: #defines:.
	mapped := FMMultivalueLink on: self opposite: #definedBy:."
	
	mapSource:=nil.
	mapTarget:=nil.
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> mapSource [

	<MSEProperty: #mapSource type: #FAMIXNamedEntity opposite: #maps>
	<MSEComment: 'Named Entity maps a Relational elements.'>
	
	^mapSource
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> mapSource: aNamedEntity [
	
	mapSource := FMMultivalueLink 
								on: self
								update: #maps
								from: self mapSource
								to: aNamedEntity
	
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> mapTarget [
	<MSEProperty: #mapTarget type: #FAMIXRelationalEntity opposite: #mappedBy>
	<MSEComment: 'Relational element mapped into the system by a Named Entity.'>
	
	^mapTarget
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> mapTarget: aRelationalEntity [

	mapTarget := FMMultivalueLink 
								on: self
								update: #mappedBy
								from: self mapTarget
								to: aRelationalEntity
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (Maps)'
]

{ #category : #'as yet unclassified' }
FAMIXMapping >> to [

	^ self mapTarget
]
