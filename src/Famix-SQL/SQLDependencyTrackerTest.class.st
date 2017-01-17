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
	"self assert: function dependentTables size equals:1.
	self assert: function dependentTables first equals: table."
	
	self assert: colCle userFunctions size equals: 1.
	self assert: colCle userFunctions first equals: function.
	self assert: colNom userFunctions size equals: 0.
	
	
	
	self assert: function dependentColumns size equals: 1.
	self assert: function dependentColumns  first equals: colCle.
	
	self assert: function dependentTables size equals: 1.
	self assert: function dependentTables asOrderedCollection first equals: table.

	

	
	
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

{ #category : #'as yet unclassified' }
SQLDependencyTrackerTest >> testDependenciesWithSubRequest [
| rq subrq personne support colDebut colClePersonne colCle view colView function selExp selExpCol whereExp whereExp1 whereExp2 expRefCol whereSubExp2 subSelExp foo colFin |
	"CREATE VIEW vue_entrees_par_annee AS
    SELECT
      date_part(support.debut) AS annee
FROM personne, support
WHERE
  ((personne.cle = support.cle_personne) AND (date_part(support.debut) IN (
    SELECT DISTINCT foo(support.debut) AS annee FROM support )));"
	personne := self create: FAMIXTable withName: 'personne' . 
	colCle := self create: FAMIXColumn withName: 'cle'.
	personne addColumn: colCle.
	
	support := self create: FAMIXTable withName: 'support'.
	colClePersonne := self create: FAMIXColumn withName: 'cle_personne'.
	colDebut := self create: FAMIXColumn withName: 'debut'.
	support addColumn: colClePersonne.
	support addColumn: colDebut.
	
	function := self create: FAMIXSQLFunction withName: 'date_part()'.
	function parameters add: (FAMIXParameter new mooseModel: self model ).
	
	foo := self create: FAMIXSQLFunction withName: 'foo()'.
	foo parameters add: (FAMIXParameter new mooseModel: self model ).
	
	view := self create: FAMIXView withName: 'vue_entrees_par_annee'.
	colView := self create: FAMIXColumn withName: 'annee'.
	FAMIXColumnToFunctionAssociation new sourceColumn: colView ; targetFunction: function ; mooseModel: self model .
	rq := self createUnnamed: FAMIXSelectRequest.
	view query: rq.
	selExp := self createUnnamed: FAMIXSQLExpression.
	selExp alias: 'annee'.
	rq addSelectClause: selExp.
	FAMIXExpressionToFunctionAssociation new sourceExpression: selExp ; targetFunction: function ; mooseModel: self model.
	selExpCol := self createUnnamed: FAMIXSQLExpression.
	selExp referencedExpressions add: selExpCol .
	FAMIXExpressionToColumnAssociation new sourceExpression: selExpCol ; targetColumn: colDebut ;  mooseModel: self model.
	
	
	self addFromTables: { personne . support } into: rq.
	
	whereExp := self createUnnamed: FAMIXSQLExpression.
	whereExp1 := self createUnnamed: FAMIXSQLExpression.
	FAMIXExpressionToColumnAssociation new sourceExpression: whereExp1 ; targetColumn: colCle ; mooseModel: self model.
	FAMIXExpressionToColumnAssociation new sourceExpression: whereExp1 ; targetColumn: colClePersonne ; mooseModel: self model.
	
	whereExp2 := self createUnnamed: FAMIXSQLExpression.
	whereSubExp2 := self createUnnamed: FAMIXSQLExpression.
	whereExp2 referencedExpressions add: whereSubExp2.
	FAMIXExpressionToFunctionAssociation new sourceExpression: whereSubExp2 ; targetFunction: function ;  mooseModel: self model.
	expRefCol := self createUnnamed: FAMIXSQLExpression.
	whereSubExp2 referencedExpressions add: expRefCol.
	FAMIXExpressionToColumnAssociation new sourceExpression: expRefCol ; targetColumn: colDebut ; mooseModel: self model.
	subrq := self createUnnamed: FAMIXSelectRequest.
	whereSubExp2 referencedRequests add: subrq .
	
	subSelExp := self createUnnamed: FAMIXSQLExpression.
	subSelExp alias: 'annee'.
	subrq addSelectClause: subSelExp.
	FAMIXExpressionToFunctionAssociation new sourceExpression: subSelExp ; targetFunction: foo ; mooseModel: self model.
	selExpCol := self createUnnamed: FAMIXSQLExpression.
	subSelExp referencedExpressions add: selExpCol .
	FAMIXExpressionToColumnAssociation new sourceExpression: selExpCol ; targetColumn: colFin ;  mooseModel: self model.
	
	whereExp referencedExpressions add: whereExp1.
	whereExp referencedExpressions add: whereExp2.
	rq addWhereClause: whereExp.
	
	self model install.
	
	self assert: personne userViews size equals: 1.
	self assert: personne userViews asOrderedCollection first equals: view.
	self assert: view dependentTables size equals:2.
	self assert: (view dependentTables includes: personne).
	
	self assert: view dependentColumns size equals:3.
	self assert: (view dependentColumns includes: colCle).
	self assert: (view dependentColumns includes: colDebut).
	self assert: (view dependentColumns includes: colClePersonne).
	
	self assert: view dependentFunctions size equals:2.
	self assert: (view dependentFunctions includes: function).
	self assert: (view dependentFunctions includes: foo).
]
