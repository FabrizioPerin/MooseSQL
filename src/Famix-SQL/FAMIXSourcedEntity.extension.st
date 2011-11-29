Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*famix-sql' }
FAMIXSourcedEntity >> accessDirection: directionSymbol on: dependencyList [

	"From a list of dependencies of a given type, select the ones going to or coming from receiver"

	directionSymbol = #accessedEntity
				ifTrue: [
					^ (dependencyList  select: [:each | each from = self]) collect: [:each | each to].
					].
	directionSymbol = #accessorEntity
				ifTrue: [
					^ (dependencyList  select: [:each | each to = self]) collect: [:each | each from].
					].
			
	SyntaxErrorNotification signal: 'second argument should be #dbAccesses or #sourceAccessors'.
]

{ #category : #'*famix-sql' }
FAMIXSourcedEntity >> accessedRelationalEntities [
	^self accessDirection:  #accessedEntity on: self mooseModel allDBAccesses
]

{ #category : #'*famix-sql' }
FAMIXSourcedEntity >> accessorSourceEntities [
	^self accessDirection:  #accessorEntity on: self mooseModel allDBAccesses
]

{ #category : #'*famix-sql' }
FAMIXSourcedEntity >> addDBAccess: aDBAccess [
	self dbAccesses add: aDBAccess
]

{ #category : #'*famix-sql' }
FAMIXSourcedEntity >> dbAccesses [
	<MSEProperty: #dbAccesses type: #FAMIXDBAccess opposite: #accessorEntity> <multivalued>  <derived>
	<MSEComment: 'Database access relationship.'>
	
	^self privateState attributeAt: #dbAccesses ifAbsentPut: [FMMultivalueLink on: self opposite: #accessorEntity:].
]
