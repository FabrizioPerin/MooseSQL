Class {
	#name : #FAMIXView,
	#superclass : #FAMIXTable,
	#instVars : [
		'ofTables'
	],
	#category : #'Famix-SQL'
}

{ #category : #accessing }
FAMIXView >> addATable: aFAMIXViewAssociation [
	self ofTables add: aFAMIXViewAssociation 
]

{ #category : #accessing }
FAMIXView >> initialize [
	super initialize.
	
	ofTables := FMMultivalueLink 
					on: self 
					opposite: #view:.
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
