"
FAMIXSQLIndexing represent an association between a FAMIXSQLIndex and a indexed FAMIXColumn.

Instance Variables:
	index	contains the FAMIXSQLIndex object and represent the ""from"" part of this association. 
	column	contains the FAMIXColumn object and represent the ""to"" part of this association. 
"
Class {
	#name : #FAMIXSQLIndexing,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'index',
		'column'
	],
	#category : #'Famix-SQL'
}

{ #category : #meta }
FAMIXSQLIndexing class >> annotation [
	<MSEClass: #SQLIndexing super: #FAMIXAssociation>
	<package: #SQL>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXSQLIndexing >> column [
	<MSEProperty: #column type: #FAMIXColumn opposite: #indexes>
	<MSEComment: 'Column indexed by a SQL index.'>
	
	^column
]

{ #category : #'as yet unclassified' }
FAMIXSQLIndexing >> column: aFAMIXColumn [
	
	column := FMMultivalueLink 
						on: self
						update: #indexes
						from: self column
						to: aFAMIXColumn
]

{ #category : #'as yet unclassified' }
FAMIXSQLIndexing >> from [
	^self index
]

{ #category : #'as yet unclassified' }
FAMIXSQLIndexing >> index [
	<MSEProperty: #index type: #FAMIXSQLIndex opposite: #indexedColumns>
	<MSEComment: 'Index defined on a column'>
	
	^index
]

{ #category : #'as yet unclassified' }
FAMIXSQLIndexing >> index: aFAMIXSQLIndex [
	
	index := FMMultivalueLink 
						on: self
						update: #indexedColumns
						from: self index
						to: aFAMIXSQLIndex
]

{ #category : #'as yet unclassified' }
FAMIXSQLIndexing >> printOn: aStream [
	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: ' (IndexRelation)'
]

{ #category : #'as yet unclassified' }
FAMIXSQLIndexing >> to [
	^self column
]
