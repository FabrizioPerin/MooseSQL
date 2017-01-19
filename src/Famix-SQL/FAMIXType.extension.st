Extension { #name : #FAMIXType }

{ #category : #'*Famix-SQL' }
FAMIXType >> stateAggregateValues [
	<MSEProperty: #stateAggregateValues type: #FAMIXAggregate opposite: #type> <multivalued> <derived>
	<MSEComment: 'stateAggregateValues with this type'>
	<package: #SQL>
	^ self privateState 
			attributeAt: #stateAggregateValues
			ifAbsentPut: [FMMultivalueLink on: self opposite: #type:]
]

{ #category : #'*Famix-SQL' }
FAMIXType >> stateAggregateValues: aCollection [
	self stateAggregateValues value: aCollection 
]
