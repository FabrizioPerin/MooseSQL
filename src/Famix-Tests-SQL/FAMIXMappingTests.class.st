Class {
	#name : #FAMIXMappingTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXMappingTests >> testAnnotation [
	self assert: FAMIXMapping annotation == FAMIXMapping.
]

{ #category : #tests }
FAMIXMappingTests >> testFAMIXMappingCreation [
	
	| mooseModel  class table map mapping jEETestModel |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	class := mooseModel entityNamed: #'anotherPackage::ABMPEntityBean'.
	table := mooseModel entityNamed: #Table1.
	
	mapping := FAMIXMapping new mapTarget: table; mapSource: class.
	
	class addMaps: mapping.
	table addMappedBy: mapping.
	
	mooseModel add: mapping.
	
	self assert: (mooseModel allMaps size = 1).
	
	map := (mooseModel allMaps select: [:each | each from = class and: [each to = table]]).
	self assert: map size = 1.

]
