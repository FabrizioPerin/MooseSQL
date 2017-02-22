Extension { #name : #FAMIXAssociation }

{ #category : #'*Famix-SQL' }
FAMIXAssociation >> printOn: aStream [

	self from ifNotNil: [self from printOn: aStream].
	aStream << ' -> '.
	self to ifNotNil: [ self to printOn: aStream].
	aStream << self printOnType
]

{ #category : #'*Famix-SQL' }
FAMIXAssociation >> printOnType [
	^ ''
]
