Class {
	#name : #FAMIXColumnReference,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceFunction',
		'targetColumn'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXColumnReference class >> annotation [
	<MSEClass: #ColumnReference super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXColumnReference >> sourceFunction [

	<MSEProperty: #sourceFunction type: #FAMIXSQLFunction opposite: #referencedBy>
	<MSEComment: 'Function references a column.'>
	^ sourceFunction
]

{ #category : #accessing }
FAMIXColumnReference >> sourceFunction: anObject [
	sourceFunction := anObject
]

{ #category : #accessing }
FAMIXColumnReference >> targetColumn [
	^ targetColumn
]

{ #category : #accessing }
FAMIXColumnReference >> targetColumn: anObject [
	targetColumn := anObject
]
