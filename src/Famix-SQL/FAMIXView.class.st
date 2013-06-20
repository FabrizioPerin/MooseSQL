Class {
	#name : #FAMIXView,
	#superclass : #FAMIXTable,
	#instVars : [
		'ofTables'
	],
	#category : #'Famix-SQL'
}

{ #category : #accessing }
FAMIXView >> initialize [
	super initialize.
	ofTables := OrderedCollection new.
]

{ #category : #accessing }
FAMIXView >> ofTables [
	^ ofTables
]

{ #category : #accessing }
FAMIXView >> ofTables: aCollectionOfTables [
	ofTables := aCollectionOfTables
]

{ #category : #accessing }
FAMIXView >> printOn: aStream [
	
	self completeName isNil
		ifFalse: [ aStream nextPutAll: self completeName ]
		ifTrue: [ self name isNil ifFalse: [ aStream nextPutAll: self name ] ].
	
	aStream nextPutAll: ' (View)'
]
