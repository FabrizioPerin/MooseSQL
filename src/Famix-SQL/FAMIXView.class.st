Class {
	#name : #FAMIXView,
	#superclass : #FAMIXTable,
	#instVars : [
		'ofTables',
		'missingTableNames',
		'tables',
		'fromTables'
	],
	#category : #'Famix-SQL'
}

{ #category : #accessing }
FAMIXView >> addATable: aFAMIXViewAssociation [
	self ofTables add: aFAMIXViewAssociation 
]

{ #category : #accessing }
FAMIXView >> addMissingTableName: aString [
	missingTableNames add: aString
]

{ #category : #accessing }
FAMIXView >> fromTables [
	<MSEProperty: #tables type: #FAMIXTable > <multivalued> <derived>
	<MSEComment: 'tables used by this view'>
	^tables collect: [ :tableAsso | tableAsso targetTable ]
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
	missingTableNames := Set new.
]

{ #category : #testing }
FAMIXView >> isView [
	^ true
]

{ #category : #accessing }
FAMIXView >> missingTableNames [
	^missingTableNames 
]

{ #category : #accessing }
FAMIXView >> missingTableNames: aSetOrNil [
	missingTableNames := aSetOrNil
]

{ #category : #accessing }
FAMIXView >> ofTables [
	<MSEProperty: #ofTables type: #FAMIXViewAssociation opposite: #view> <multivalued> <derived>
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
	<MSEProperty: #tables type: #FAMIXTableAssociation opposite: #sourceTable> <multivalued> 
	<MSEComment: 'tables used by this view'>
	^tables
]
