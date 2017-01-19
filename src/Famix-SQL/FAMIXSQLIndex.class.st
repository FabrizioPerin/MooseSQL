"
FAMIXSQLIndex represent an SQL index defined on database columns.

Instance Variables:
	indexedTable		Contains the reference to the FAMIXTable object on which columns this index has been defined. 
	isUnique			A boolean that sais if this index is unique or not.
	indexName			Name of this index.
	indexedColumns	Contains a list of references to FAMIXSQLIndexing objects that hold the relation with the actual indexed FAMIXColumns.
"
Class {
	#name : #FAMIXSQLIndex,
	#superclass : #MooseEntity,
	#instVars : [
		'indexedTable',
		'isUnique',
		'indexName',
		'indexedColumns'
	],
	#category : #'Famix-SQL'
}

{ #category : #accessing }
FAMIXSQLIndex >> addIndexedColumn: aFAMIXSQLIndexing [
	indexedColumns add: aFAMIXSQLIndexing
]

{ #category : #accessing }
FAMIXSQLIndex >> indexedColumns [
	<MSEProperty: #indexedColumns type: #FAMIXSQLIndexing opposite: #index>
	<MSEComment: 'Table indexed by this index. Should provides the implementation for belongsTo.'>
	^ indexedColumns
]

{ #category : #accessing }
FAMIXSQLIndex >> indexedTable [
	<MSEProperty: #indexedTable type: #FAMIXTable opposite: #indexes>
	<MSEComment: 'Table indexed by this index. Should provides the implementation for belongsTo.'>
	^ indexedTable
	
	
]

{ #category : #accessing }
FAMIXSQLIndex >> indexedTable: aFAMIXTableOrNil [
	indexedTable := FMMultivalueLink 
		on: self
		update: #indexes
		from: self indexedTable
		to: aFAMIXTableOrNil
]

{ #category : #accessing }
FAMIXSQLIndex >> initialize [
	super initialize.
	indexedTable := nil.
	indexedColumns := FMMultivalueLink on: self opposite: #index:.
]

{ #category : #accessing }
FAMIXSQLIndex >> isUnique [
	^ isUnique
]

{ #category : #accessing }
FAMIXSQLIndex >> isUnique: anObject [
	isUnique := anObject
]

{ #category : #accessing }
FAMIXSQLIndex >> name [
	^ indexName
]

{ #category : #accessing }
FAMIXSQLIndex >> name: aString [
	indexName := aString
]

{ #category : #accessing }
FAMIXSQLIndex >> printOn: aStream [
	
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Index)'
]
