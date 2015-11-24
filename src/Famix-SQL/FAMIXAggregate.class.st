"
A FAMIXAggregate represents an SQL aggregate.
"
Class {
	#name : #FAMIXAggregate,
	#superclass : #FAMIXBehaviouralEntity,
	#instVars : [
		'type',
		'sfunction',
		'ffunction',
		'referencedByViews',
		'referencedByFunctions'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXAggregate class >> annotation [
	<MSEClass: #Aggregate super: #FAMIXBehaviouralEntity>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXAggregate >> ffunction [
	<MSEProperty: #ffunction type: #FAMIXSQLFunction opposite: #aggregateAsFfunction>
	<MSEComment: 'The final function called to compute the aggregate s result.'>
	^ ffunction
]

{ #category : #accessing }
FAMIXAggregate >> ffunction: anObject [
	ffunction := anObject
]

{ #category : #initialization }
FAMIXAggregate >> initialize [
	super initialize.
	referencedByViews := FMMultivalueLink on: self opposite: #aggregate:.
]

{ #category : #tests }
FAMIXAggregate >> isAggregate [
	^ true
]

{ #category : #accessing }
FAMIXAggregate >> referencedByFunctions [
	<MSEProperty: #referencedByFunctions type: #FAMIXFunctionToAggregateAssociation opposite: #aggregate> <multivalued>
	<MSEComment: 'Functions referencing the aggregate.'>
	^ referencedByFunctions
]

{ #category : #accessing }
FAMIXAggregate >> referencedByFunctions: anObject [
	referencedByFunctions := anObject
]

{ #category : #accessing }
FAMIXAggregate >> referencedByViews [
	<MSEProperty: #referencedByViews type: #FAMIXViewToAggregateAssociation opposite: #aggregate> <multivalued>
	<MSEComment: 'Views referencing the aggregate.'>
	^ referencedByViews
]

{ #category : #accessing }
FAMIXAggregate >> referencedByViews: anObject [
	referencedByViews := anObject
]

{ #category : #accessing }
FAMIXAggregate >> sfunction [
	<MSEProperty: #sfunction type: #FAMIXSQLFunction opposite: #aggregateAsSfunction>
	<MSEComment: 'The function taking the current state value and the current input data value(s), and returns the next state value.'>
	^ sfunction
]

{ #category : #accessing }
FAMIXAggregate >> sfunction: anObject [
	sfunction := anObject
]

{ #category : #accessing }
FAMIXAggregate >> type [
	<MSEProperty: #type type: #FAMIXType>
	<MSEComment: 'The data type for the aggregate s state value.'>
	^ type
]

{ #category : #accessing }
FAMIXAggregate >> type: anObject [
	type := anObject
]
