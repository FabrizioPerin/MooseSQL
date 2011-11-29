Class {
	#name : #FAMIXDBAccessGroupTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXDBAccessGroupTests >> testAnnotation [
	self assert: FAMIXDBAccessGroup annotation == FAMIXDBAccessGroup.
]
