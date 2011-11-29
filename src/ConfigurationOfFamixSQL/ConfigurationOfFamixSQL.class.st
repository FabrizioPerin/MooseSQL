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
		
		spec  project: 'PetitSQLParser for MooseJEE' with: [
			spec
				className: 'ConfigurationOfPetitSQLParser';
				file: 'ConfigurationOfPetitSQLParser';
				version: 'default';
				repository: 'http://www.squeaksource.com/PetitSQLParser' ].
		
		spec 
			"Core"	
			package: 'Famix-SQL' with: [spec repository: 'http://www.squeaksource.com/Moose'];
		
			"Tests"
			package: 'Famix-Tests-SQL'with: [
				spec repository: 'http://www.squeaksource.com/Moose'.
				spec requires: 'Famix-SQL'];
			
			"importers"
			package: 'Moose-JEE-Importers-SQL' with: [
				spec repository: 'http://www.squeaksource.com/MooseJEE'.
				spec requires: 'PetitSQLParser for MooseJEE'].	
		
		spec group: 'Tests' with: #( 
			'Famix-Tests-SQL').
		
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
