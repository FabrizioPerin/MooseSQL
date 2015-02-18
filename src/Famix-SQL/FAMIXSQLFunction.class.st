Class {
	#name : #FAMIXSQLFunction,
	#superclass : #FAMIXBehaviouralEntity,
	#instVars : [
		'sqlParameters'
	],
	#category : #'Famix-SQL'
}

{ #category : #'initialize-release' }
FAMIXSQLFunction class >> annotation [
	<MSEClass: #SQLFunction super: #FAMIXBehaviouralEntity>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXSQLFunction >> initialize [
	super initialize.
	sqlParameters := OrderedCollection new.
	
]

{ #category : #accessing }
FAMIXSQLFunction >> isSQLFunction [
	^true
]

{ #category : #accessing }
FAMIXSQLFunction >> numberOfSQLParameters [
	<MSEProperty: #numberOfSQLParameters type: #Number>
	<MSEComment: 'The number of parameters in a function'>
	
	^self
		lookUpPropertyNamed: #numberOfSQLParameters
		computedAs: [self sqlParameters size]
]

{ #category : #accessing }
FAMIXSQLFunction >> sqlParameters [
	<MSEProperty: #sqlParameters type: #FAMIXEntity opposite: #parentBehaviouralEntity> <multivalued> <derived>
	<MSEComment: 'List of formal parameters declared by this behaviour.'>
	
	^sqlParameters
]

{ #category : #accessing }
FAMIXSQLFunction >> sqlParameters: aCollOfSQLParameters [
	sqlParameters := aCollOfSQLParameters 
]
