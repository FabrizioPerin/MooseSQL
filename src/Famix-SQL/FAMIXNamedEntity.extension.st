Extension { #name : #FAMIXNamedEntity }

{ #category : #'*famix-sql' }
FAMIXNamedEntity >> addMaps: aMapping [
	self maps add: aMapping
]

{ #category : #'*famix-sql' }
FAMIXNamedEntity >> mapDirection: directionSymbol on: dependencyList [

	"From a list of dependencies of a given type, select the ones going to or coming from receiver"

	directionSymbol = #mapSource
				ifTrue: [
					^ (dependencyList  select: [:each | each to = self]) collect: [:each | each from].
					].
	directionSymbol = #mapTarget
				ifTrue: [
					^ (dependencyList  select: [:each | each from = self]) collect: [:each | each to].
					].
			
	SyntaxErrorNotification signal: 'second argument should be #maps or #mapped'.
]

{ #category : #'*famix-sql' }
FAMIXNamedEntity >> mappedRelationalEntities [
	^self mapDirection:  #mapTarget on: self mooseModel allMaps.
]

{ #category : #'*famix-sql' }
FAMIXNamedEntity >> maps [
	<MSEProperty: #maps type: #FAMIXMapping opposite: #mapSource> <multivalued>  <derived>
	<MSEComment: 'Map relationship.'>
	
	^self privateState attributeAt: #maps ifAbsentPut: [FMMultivalueLink on: self opposite: #mapSource:].
]

{ #category : #'*famix-sql' }
FAMIXNamedEntity >> removePointersToMaps [
	
	^self privateState attributeAt: #maps put: (FMMultivalueLink on: self opposite: #mapSource:).
]
