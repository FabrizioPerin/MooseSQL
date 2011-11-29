Extension { #name : #FAMIXClass }

{ #category : #'*famix-sql' }
FAMIXClass >> accessATable [
	<MSEProperty: #accessATable type: #Boolean>
	"self flag: 'annotate with fame meta descriptions'."
	^self privateState 
		attributeAt: #accessATable 
		ifAbsent: [
			| val |
			val := self mappedRelationalEntities size > 0.
			"self accessATable: val."
			val.]
]

{ #category : #'*famix-sql' }
FAMIXClass >> accessATable: aBooleanOrNil [
	
	^self privateState attributeAt: #accessATable put: aBooleanOrNil
]
