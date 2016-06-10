Class {
	#name : #SQLDependencyTrackerTest,
	#superclass : #TestCase,
	#traits : 'FamixSQLAPICreation',
	#classTraits : 'FamixSQLAPICreation classTrait',
	#instVars : [
		'model'
	],
	#category : #'Famix-SQL-Tests'
}

{ #category : #accessing }
SQLDependencyTrackerTest >> model [
	^ model
]

{ #category : #accessing }
SQLDependencyTrackerTest >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
SQLDependencyTrackerTest >> setUp [
	self model: MooseModel new.
]

{ #category : #'as yet unclassified' }
SQLDependencyTrackerTest >> testDependenciesForSimpleFunction [
| rq table colCle function colNom |
	"create function functionFromPersonne() returns text 
		language plgsql
		as $$Begin
		select cle from personne;
		return '';
		end;$$;"
	table := self create: FAMIXTable withName: 'personne' . 
	colCle := self create: FAMIXColumn withName: 'cle'.
	table addColumn: colCle.
	colNom := self create: FAMIXColumn withName: 'nom'.
	table addColumn: colNom.
	
	function := self create: FAMIXSQLFunction withName: 'functionFromPersonne'.
	rq := self createUnnamed: FAMIXSelectRequest.
	self addSelectColumns: { colCle } into: rq. 
	self addFromTables: { table } into: rq. 
	function addReferencedRequest: rq.
	
	
	self assert: table userFunctions size equals: 1.
	self assert: table userFunctions asOrderedCollection first equals: function.
	self assert: function dependentTables size equals:1.
	self assert: function dependentTables first equals: table.
	
	self assert: colCle userFunctions size equals: 1.
	self assert: colCle userFunctions first equals: function.
	self assert: colNom userFunctions size equals: 0.
	
	"self assert: colCle userViews size equals: 1.
	self assert: colCle userViews first equals: function.
	self assert: colNom userViews size equals: 0.
	
	self assert: colCleView dependentColumns size equals: 1.
	self assert: colCleView dependentColumns first equals: colCle.
	self assert: colCleView dependentTables size equals: 1.
	self assert: colCleView dependentTables first equals: table."

	
	
]

{ #category : #'as yet unclassified' }
SQLDependencyTrackerTest >> testDependenciesForSimpleView [
| rq table colCle view colNom colCleView |
	"create view viewFromPersonne as select cle from personne"
	table := self create: FAMIXTable withName: 'personne' . 
	colCle := self create: FAMIXColumn withName: 'cle'.
	table addColumn: colCle.
	colNom := self create: FAMIXColumn withName: 'nom'.
	table addColumn: colNom.
	
	view := self create: FAMIXView withName: 'viewFromPersonne'.
	colCleView := self create: FAMIXColumn withName: 'cle'.
	rq := self createUnnamed: FAMIXSelectRequest.
	self addSelectColumns: { colCle } into: rq. 
	self addFromTables: { table } into: rq. 
	view query: rq.
	view addColumn: colCleView.
	FAMIXColumnToColumnAssociation new sourceColumn: colCleView ; targetColumn: colCle ; mooseModel: self model.

	
	self assert: table userViews size equals: 1.
	self assert: table userViews asOrderedCollection first equals: view.
	self assert: view dependentTables size equals:1.
	self assert: view dependentTables first equals: table.
	
	self assert: colCle userColumns size equals: 1.
	self assert: colCle userColumns first equals: colCleView.
	self assert: colNom userColumns size equals: 0.
	
	self assert: colCle userViews size equals: 1.
	self assert: colCle userViews first equals: view.
	self assert: colNom userViews size equals: 0.
	
	self assert: colCleView dependentColumns size equals: 1.
	self assert: colCleView dependentColumns first equals: colCle.
	self assert: colCleView dependentTables size equals: 1.
	self assert: colCleView dependentTables first equals: table.

	
	
]
