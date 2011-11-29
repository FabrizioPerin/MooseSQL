Class {
	#name : #FAMIXColumnGroupTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXColumnGroupTests >> testAnnotation [
	self assert: FAMIXColumnGroup annotation == FAMIXColumnGroup.
]
