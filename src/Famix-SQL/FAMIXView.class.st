Class {
	#name : #FAMIXView,
	#superclass : #FAMIXTable,
	#instVars : [
		'ofTables',
		'tables',
		'fromTables'
	],
	#category : #'Famix-SQL'
}

{ #category : #adding }
FAMIXView >> addDependencyIfNotExistToTable: aFAMIXTable [ 
	FAMIXViewAssociation new table: aFAMIXTable ; view: self; mooseModel: self mooseModel
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
	^fromTables select: [ :t | t isView ]
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

{ #category : #accessing }
FAMIXView >> tables [
	<MSEProperty: #tables type: #FAMIXViewAssociation opposite: #sourceTable> <multivalued> 
	<MSEComment: 'tables used by this view'>
	^tables
]
