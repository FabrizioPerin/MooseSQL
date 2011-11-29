Class {
	#name : #FAMIXFKAssociationGroupTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXFKAssociationGroupTests >> testAnnotation [
	self assert: FAMIXFKAssociationGroup annotation == FAMIXFKAssociationGroup.
]
