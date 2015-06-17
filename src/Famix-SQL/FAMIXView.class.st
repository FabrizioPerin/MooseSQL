"
A FAMIXView is a kind of table  built from a request.

    Instance Variables
	ofTables:		tables from which the view is built.


"
Class {
	#name : #FAMIXView,
	#superclass : #FAMIXTable,
	#instVars : [
		'ofTables'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXView >> addDependencyIfNotExistTo: aFAMIXTableOrFunction [ 
	aFAMIXTableOrFunction addDependencyIfNotExistFromView: self.
]

{ #category : #adding }
FAMIXView >> addDependencyIfNotExistToTable: aFAMIXTable [ 
	FAMIXViewAssociation new table: aFAMIXTable ; view: self; mooseModel: self mooseModel
]

{ #category : #accessing }
FAMIXView >> belongsTo [
	<MSEProperty: #ownerDataBase type: #FAMIXDataBase> <derived>
	<MSEComment: 'Database containing the view'>
	

	^self ownerDataBase
]

{ #category : #accessing }
FAMIXView >> fromTables [
	<MSEProperty: #tables type: #FAMIXTable > <multivalued> <derived>
	<MSEComment: 'tables used by this view'>
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
	<MSEProperty: #ofTables type: #FAMIXViewAssociation opposite: #view> <multivalued>
	<MSEComment: 'tables used by this view'>
	^ofTables
]

{ #category : #accessing }
FAMIXView >> printOn: aStream [
	
	self completeName isNil
		ifFalse: [ aStream nextPutAll: self completeName ]
		ifTrue: [ self name isNil ifFalse: [ aStream nextPutAll: self name ] ].
	
	aStream nextPutAll: ' (View)'
]
