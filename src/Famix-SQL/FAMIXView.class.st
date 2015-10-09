"
A FAMIXView is a kind of table  built from a request.

    Instance Variables
	ofTables:		tables from which the view is built.


"
Class {
	#name : #FAMIXView,
	#superclass : #FAMIXTable,
	#instVars : [
		'ofTables',
		'usedColumns'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXView class >> annotation [
	<MSEClass: #View super: #FAMIXTable>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXView >> addDependencyIfNotExistTo: aFAMIXTableOrFunction [ 
	aFAMIXTableOrFunction addDependencyIfNotExistFromView: self.
]

{ #category : #adding }
FAMIXView >> addDependencyIfNotExistToTable: aFAMIXTable [ 
	FAMIXViewToTableAssociation new table: aFAMIXTable ; view: self; mooseModel: self mooseModel
]

{ #category : #accessing }
FAMIXView >> belongsTo [
	<MSEProperty: #belongsTo type: #FAMIXDataBase> 
	<MSEComment: 'Database containing the view'>
	

	^self ownerDataBase
]

{ #category : #accessing }
FAMIXView >> fromTables [
	<MSEProperty: #fromTables type: #FAMIXTable > <multivalued> <derived>
	<MSEComment: 'tables used by this view (return tables or views)'>
	^ self ofTables collect: [ :tableAsso | tableAsso table ]
]

{ #category : #accessing }
FAMIXView >> fromViews [
	<MSEProperty: #fromViews type: #FAMIXView> <multivalued> <derived>
	<MSEComment: 'views used by this view'>
	^self fromTables select: [ :t | t isView ]
]

{ #category : #accessing }
FAMIXView >> initialize [
	super initialize.
	
	ofTables := FMMultivalueLink 
					on: self 
					opposite: #view:.
	tables := FMMultivalueLink 
					on: self 
					opposite: #sourceTable:.
	
]

{ #category : #testing }
FAMIXView >> isView [
	^ true
]

{ #category : #accessing }
FAMIXView >> ofTables [
	<MSEProperty: #ofTables type: #FAMIXViewToTableAssociation opposite: #view> <multivalued>
	<MSEComment: 'tables used by this view (return FAMIXViewAssociation)'>
	^ofTables
]

{ #category : #accessing }
FAMIXView >> printOn: aStream [
	
	self completeName isNil
		ifFalse: [ aStream nextPutAll: self completeName ]
		ifTrue: [ self name isNil ifFalse: [ aStream nextPutAll: self name ] ].
	
	aStream nextPutAll: ' (View)'
]

{ #category : #accessing }
FAMIXView >> usedColumns [
	<MSEProperty: #usedColumns type: #FAMIXViewToColumnAssociation opposite: #view> <multivalued>
	<MSEComment: 'column used by this view '>
	^usedColumns
]

{ #category : #accessing }
FAMIXView >> usedColumns: anObject [
	usedColumns := anObject
]
