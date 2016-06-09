Extension { #name : #FAMIXAssociation }

{ #category : #'*Famix-SQL' }
FAMIXAssociation >> printOn: aStream [

	self from isNil	
		ifFalse: [aStream nextPutAll: self from name].
	aStream nextPutAll: ' -> '.
	self to isNil	
		ifFalse: [aStream nextPutAll: self to name].
	aStream nextPutAll: self printOnType
]

{ #category : #'*Famix-SQL' }
FAMIXAssociation >> printOnType [
	^ ''
]
