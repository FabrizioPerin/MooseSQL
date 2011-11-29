Class {
	#name : #FAMIXTableGroupTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXTableGroupTests >> testAnnotation [
	self assert: FAMIXTableGroup annotation == FAMIXTableGroup.
]

{ #category : #tests }
FAMIXTableGroupTests >> testMaximumNumberOfFKsPerClass [

	| mooseModel |
	
	
	mooseModel := FAMIXSQLTestResources new sampleMooseModelContainingJustADB.
	
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allTables maximumNumberOfFKsPerClass = 2).
]

{ #category : #tests }
FAMIXTableGroupTests >> testMaximumNumberOfPKsPerClass [

	| mooseModel |
	
	
	mooseModel := FAMIXSQLTestResources new sampleMooseModelContainingJustADB.
	
	self assert: (mooseModel allTables size = 3).
	self assert: (mooseModel allTables maximumNumberOfPKsPerClass = 3).
]
