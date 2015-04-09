Class {
	#name : #FAMIXSQLFunction,
	#superclass : #FAMIXBehaviouralEntity,
	#instVars : [
		'sqlParameters',
		'referencedBy',
		'referencedColumns',
		'referencedTables'
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
	sqlParameters := FMMultivalueLink on: self opposite: #parentBehaviouralEntity:.
	referencedBy := FMMultivalueLink on: self opposite: #targetFunction:.
	referencedColumns := FMMultivalueLink on: self opposite: #sourceFunction:
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
FAMIXSQLFunction >> referencedBy: anObject [
	referencedBy value: anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedColumns [
	<MSEProperty: #referencedColumns type: #FAMIXColumnReference opposite: #sourceFunction> <multivalued> 
	<MSEComment: 'List of columns referenced by the function.'>
	^ referencedColumns
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedColumns: anObject [
	referencedColumns value: anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedTables [
	<MSEProperty: #referencedTables type: #FAMIXTable> <multivalued> <computed>
	<MSEComment: 'List of Tables referenced by the function.'>
	^ ((referencedColumns collect: #targetColumn) collect: #ownerTable) asSet
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
