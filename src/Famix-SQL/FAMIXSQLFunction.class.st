Class {
	#name : #FAMIXSQLFunction,
	#superclass : #FAMIXBehaviouralEntity,
	#instVars : [
		'sqlParameters',
		'referencedBy'
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
	sqlParameters := FMMultivalueLink 
					on: self
					opposite: #parentBehaviouralEntity:.
	referencedBy := FMMultivalueLink on: self opposite: #targetFunction:.
	
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

{ #category : #'as yet unclassified' }
FAMIXSQLFunction >> referencedBy [

	<MSEProperty: #referencedBy type: #FAMIXAssociation opposite: #targetFunction> <multivalued> 
	<MSEComment: 'Entities referencing the given function'>
	
	^referencedBy 
]

{ #category : #accessing }
FAMIXSQLFunction >> sqlParameters [
	<MSEProperty: #sqlParameters type: #FAMIXEntity opposite: #parentBehaviouralEntity> <multivalued> 
	<MSEComment: 'List of formal parameters declared by this behaviour.'>
	
	^sqlParameters
]

{ #category : #accessing }
FAMIXSQLFunction >> sqlParameters: aCollOfSQLParameters [
	sqlParameters value: aCollOfSQLParameters 
]
