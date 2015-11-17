Extension { #name : #FAMIXEntity }

{ #category : #'*Famix-SQL' }
FAMIXEntity >> isAggregate [
	^ false
]

{ #category : #'*Famix-SQL' }
FAMIXEntity >> isColumn [
	^false
]

{ #category : #'*Famix-SQL' }
FAMIXEntity >> isDefaultConstraint [
	^false
]

{ #category : #'*Famix-SQL' }
FAMIXEntity >> isFKAssociation [
	^false
]

{ #category : #'*Famix-SQL' }
FAMIXEntity >> isSQLFunction [
	^ false
]

{ #category : #'*Famix-SQL' }
FAMIXEntity >> isSequence [
	^ false
]

{ #category : #'*Famix-SQL' }
FAMIXEntity >> isTable [
	^false
]

{ #category : #'*Famix-SQL' }
FAMIXEntity >> isTrigger [
	^ false
]

{ #category : #'*Famix-SQL' }
FAMIXEntity >> isView [
	^ false
]
