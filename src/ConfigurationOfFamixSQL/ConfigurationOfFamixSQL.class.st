Class {
	#name : #ConfigurationOfFamixSQL,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfFamixSQL
}

{ #category : #private }
ConfigurationOfFamixSQL class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfFamixSQL class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfFamixSQL class >> loadDefault [
	
	(self project version: 'default') load.
	
	Categorizer sortAllCategories.
]

{ #category : #accessing }
ConfigurationOfFamixSQL class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfFamixSQL >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #default.
		spec repository: 'http://www.squeaksource.com/Moose'.
		
		spec  project: 'PetitSQLParser for Moose' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				version: 'defaultWithoutPetit';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].
		
		spec 
			"Core"	
			package: 'Famix-SQL';
			
			"importers"
			package: 'Moose-SQL-Importer' with: [spec requires: #('PetitSQLParser for Moose' 'Famix-SQL').];
				
			"Tests"
			package: 'Famix-Tests-SQL'with: [spec requires: 'Famix-SQL'];
			package: 'Moose-Tests-SQL-Importer' with: [spec requires: 'Moose-SQL-Importer'].
			
		
		spec group: 'Model' with: #(	'Famix-SQL').
		spec group: 'Model-Tests' with: #('Famix-Tests-SQL').
		
		spec group: 'Importer' with: #('Moose-SQL-Importer').
		spec group: 'Importer-Tests' with: #('Moose-Tests-SQL-Importer').
	
		spec group: 'default' with: #('Model' 'Importer' 'Model-Tests' 'Importer-Tests').
	]
]

{ #category : #accessing }
ConfigurationOfFamixSQL >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
