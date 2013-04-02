Class {
	#name : #FAMIXMappingGroupTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXMappingGroupTests >> testAnnotation [
	self assert: FAMIXMappingGroup annotation == FAMIXMappingGroup.
]

{ #category : #tests }
FAMIXMappingGroupTests >> testSaveListOfMapsOnFileNamed [
	| mooseModel class table mapping mapGroup |
	
	mooseModel := FAMIXSQLTestResources new sampleMooseModelWithDB.
	class := mooseModel entityNamed: #'anotherPackage::ABMPEntityBean'.
	table := mooseModel entityNamed: #Table1.
	mapping := FAMIXMapping new mapTarget: table; mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	mooseModel add: mapping.
	
	mapGroup := mooseModel allMaps.

	self deny: (FileSystem workingDirectory fileNames includes: 'listOfMaps.out').

	mapGroup saveListOfMapsOnFileNamed: 'listOfMaps.out'.
	
	self assert: (FileSystem workingDirectory fileNames includes: 'listOfMaps.out').
	
	(FileSystem workingDirectory / 'listOfMaps.out') asFileReference delete.
	self deny: (FileSystem workingDirectory fileNames includes: 'listOfMaps.out').
]
