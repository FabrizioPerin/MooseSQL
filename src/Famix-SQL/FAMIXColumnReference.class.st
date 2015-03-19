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
FAMIXColumnReference >> from [
	^sourceFunction.
]

{ #category : #accessing }
FAMIXColumnReference >> sourceFunction [

	<MSEProperty: #sourceFunction type: #FAMIXSQLFunction opposite: #referencedColumns>
	<MSEComment: 'Function references a column.'>
	^ sourceFunction
]

{ #category : #accessing }
FAMIXColumnReference >> sourceFunction: anObject [
	sourceFunction := FMMultivalueLink
		on: self
		update: #referencedColumns
		from: self sourceFunction 
		to: anObject
]

{ #category : #accessing }
FAMIXColumnReference >> targetColumn [
	<MSEProperty: #targetColumn type: #FAMIXColumn opposite: #referencedBy>
	<MSEComment: 'Column referenced by a function.'>
	^ targetColumn
]

{ #category : #accessing }
FAMIXColumnReference >> targetColumn: anObject [
	targetColumn := FMMultivalueLink
		on: self
		update: #referencedBy
		from: self targetColumn
		to: anObject
]

{ #category : #accessing }
FAMIXColumnReference >> to [
	^targetColumn.
]
