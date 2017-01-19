Class {
	#name : #FAMIXRelationalEntityTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXRelationalEntityTests >> testAnnotation [
	self assert: FAMIXRelationalEntity annotation == FAMIXRelationalEntity.
]

{ #category : #tests }
FAMIXRelationalEntityTests >> testBelongsTo [
	self assert: FAMIXRelationalEntity new belongsTo = ''.
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntityTests >> testConstraints [
	| mooseModel table3 |
	
	mooseModel := FAMIXSQLTestResources new sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: FAMIXTable).
	self assert: table3 constraints size equals: 2.
]

{ #category : #tests }
FAMIXRelationalEntityTests >> testMappedNamedEntities [
	| table class mapping mm |
	
	mm := MooseModel new.
	table := FAMIXTable new.
	class := FAMIXClass new.
	
	mapping := FAMIXMapping new
		mapTarget: table;
		mapSource: class.
	class addMaps: mapping.
	table addMappedBy: mapping.
	
	mm add: class.
	mm add: table.
	mm add: mapping.
	
	self assert: table mappedNamedEntities size = 1.
	self assert: table mappedNamedEntities first = class
]

{ #category : #tests }
FAMIXRelationalEntityTests >> testSourceAccessors [
	
	| table dbAccess |
	
	table := FAMIXTable new name: #Table1.
	
	dbAccess := FAMIXDBAccess new accessedEntity: table.
	
	table addSourceAccessors: dbAccess.
	
	self assert: (table isMemberOf: FAMIXTable).

	self assert: (table sourceAccessors isMemberOf: FMMultivalueLink).
	self assert: (table sourceAccessors first = dbAccess).
	self assert: (table sourceAccessors first to = table).
]
