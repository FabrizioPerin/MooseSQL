Class {
	#name : #FAMIXView,
	#superclass : #FAMIXTable,
	#instVars : [
		'ofTables',
		'missingTableNames',
		'tables'
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

{ #category : #accessing }
FAMIXView >> views [
	<MSEProperty: #views type: #FAMIXView> <multivalued> 
	<MSEComment: 'views used by this view'>
	^tables select: [ :t | t isView ]
]
