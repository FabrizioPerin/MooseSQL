Extension { #name : #FAMIXMethod }

{ #category : #'*famix-sql' }
FAMIXMethod >> ownedTable [
	self flag: #TODOTest.
	^self privateState attributeAt: #ownedTable ifAbsent: [nil]
]

{ #category : #'*famix-sql' }
FAMIXMethod >> ownedTable: anObject [

	self flag: #TODOTest.
	self privateState attributeAt: #ownedTable put: anObject
]
