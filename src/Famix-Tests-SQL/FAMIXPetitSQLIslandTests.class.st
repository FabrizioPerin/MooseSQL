"
A FAMIXPetitSQLIslandTests enables to test the whole process of parsing when PetitSQLIslandParser is used. The tests are available only if the PetitSQLIsland project is charged.

Instance Variables
	model:		MooseModel
	soutenanceColumnType:		type names of  the columns from the soutenance table
	soutenanceDefaultColumns:		names of the columns from the soutenance table having a default constraint.
	soutenanceNotNullColumns:		names of the columns from the soutenance table having a not null constraint.
	soutenanceUniqueColumns:		names of the columns from the soutenance table having a unique constraint.
	tableColumns:		names of the columns  (as dictionary)
	tableNames:		names of the tables


"
Class {
	#name : #FAMIXPetitSQLIslandTests,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'tableNames',
		'tableColumns',
		'soutenanceColumnType',
		'soutenanceNotNullColumns',
		'soutenanceUniqueColumns',
		'soutenanceDefaultColumns',
		'soutenanceDefaultValues'
	],
	#category : #'Famix-Tests-SQL'
}

{ #category : #description }
FAMIXPetitSQLIslandTests >> description [
	
	tableNames := #('soutenance' 'sujet' 'theme') asOrderedCollection.
	tableColumns := {
		'soutenance' -> {'cle'. 'cle_diplome'. 'jury'. 'jury_en'. 'date_soutenance'. 'hal'} asOrderedCollection.
		'sujet' -> {'cle'. 'titre'. 'titre_en'. 'resume'. 'resume_en' } asOrderedCollection .
		'theme' -> { 'cle'. 'nom'. 'description'. 'nom_en'. 'description_en'. 'cle_responsable'. 'debut'. 'fin' } asOrderedCollection } asDictionary .
	soutenanceColumnType := #('integer' 'integer' 'character varying(4096)' 'character varying[]' 'date' 'timestamp without time zone' ) asOrderedCollection .
	soutenanceNotNullColumns := #( 'cle' 'jury_en') asOrderedCollection .
	soutenanceUniqueColumns := #( 'cle_diplome') asOrderedCollection.
	soutenanceDefaultColumns := #( 'cle' 'date_soutenance') asOrderedCollection.
	soutenanceDefaultValues := #( 'nextval' 'nil') asOrderedCollection.
	
]

{ #category : #tests }
FAMIXPetitSQLIslandTests >> nbColumns [
	| nb |
	nb := 0.
	tableColumns values do: [ :v | nb := nb + v size ].
	^nb 
]

{ #category : #running }
FAMIXPetitSQLIslandTests >> setUp [
	| db sqlCode visitor |

	self description.
	sqlCode := '
CREATE TABLE soutenance (
	cle integer DEFAULT nextval(''seq_soutenance_cle''::regclass) NOT NULL,
    cle_diplome integer UNIQUE,
    jury character varying(4096),
    jury_en character varying[] NOT NULL,
    date_soutenance date DEFAULT ''2014-10-27'',
    hal timestamp without time zone
);

CREATE TABLE sujet (
    cle integer DEFAULT nextval(''seq_sujet_cle''::regclass) NOT NULL,
    titre character varying[] NOT NULL,
    titre_en character varying[],
    resume character varying,
    resume_en character varying
);

CREATE TABLE theme (
    cle integer DEFAULT nextval(''seq_theme_cle''::regclass) NOT NULL,
    nom character varying(1024) NOT NULL,
    description character varying(8192),
    nom_en character varying(1024) NOT NULL,
    description_en character varying(8192) NOT NULL,
    cle_responsable integer,
    debut date,
    fin date
);

--
-- PostgreSQL database dump complete
--
'.
model:= MooseModel new.
visitor := PetitSQLIslandDef new model: model.
db := FAMIXDataBase new name: 'SI'.

(PetitSQLIslandASTNodesParser new parse: (sqlCode trim))  do: [:cell | cell acceptVisitor: visitor].
model.

]

{ #category : #tests }
FAMIXPetitSQLIslandTests >> testFAMIXColumn [
	| columns soutenanceColumns |
	columns := model entities select: [ :e | e isColumn ].
	self assert: columns size equals: self nbColumns.
		
	soutenanceColumns := columns select: [ :c | c ownerTable name = 'soutenance' ].
	self assert: (soutenanceColumns collect: #name) equals: (tableColumns at: 'soutenance') .
	self assert: ((soutenanceColumns collect: #type) collect: #name) equals: soutenanceColumnType.
	
	self assert: ((soutenanceColumns reject: #canBeNull) collect: #name) equals: soutenanceNotNullColumns .
	self assert: ((soutenanceColumns select: #isUnique) collect: #name) equals: soutenanceUniqueColumns .
	self assert: ((soutenanceColumns select: [:c | c defaultValueConstraint notNil]) collect: #name) equals: soutenanceDefaultColumns .
	self assert: ((soutenanceColumns select: [:c | c defaultValueConstraint notNil]) collect: [: c | c defaultValueConstraint function]) equals: soutenanceDefaultValues .
	
	
	

]

{ #category : #tests }
FAMIXPetitSQLIslandTests >> testFAMIXTable [
	| tables |
	tables := model entities select: [ :e | e isTable ].
	self assert: tables size equals: tableNames size.
	self assert: (tables collect: #name) equals: tableNames .

]
