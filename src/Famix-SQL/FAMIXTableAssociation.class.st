Class {
	#name : #FAMIXTableAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceTable',
		'targetTable'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXTableAssociation class >> annotation [
	<MSEClass: #TableAssociation super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXTableAssociation >> from [
	^ sourceTable
]

{ #category : #accessing }
FAMIXTableAssociation >> sourceTable [
	^ sourceTable
]

{ #category : #accessing }
FAMIXTableAssociation >> sourceTable: anObject [
	sourceTable := anObject
]

{ #category : #accessing }
FAMIXTableAssociation >> targetTable [
	^ targetTable
]

{ #category : #accessing }
FAMIXTableAssociation >> targetTable: anObject [
	targetTable := anObject
]

{ #category : #accessing }
FAMIXTableAssociation >> to [
	^ targetTable
]
