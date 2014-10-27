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
