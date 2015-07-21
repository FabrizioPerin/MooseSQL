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

{ #category : #loading }
ConfigurationOfFamixSQL class >> loadDevelopment [

	(self project version: #development) load.
]

{ #category : #accessing }
ConfigurationOfFamixSQL class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfFamixSQL >> baseline10: spec [ 
	<version: '1.0-baseline'>
	
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

{ #category : #baselines }
ConfigurationOfFamixSQL >> baseline11: spec [ 
	<version: '1.1-baseline'>
	
	spec for: #common do: [
		spec blessing: #default.
		spec repository: 'http://www.squeaksource.com/Moose'.
		
		spec 
			"Core"	
			package: 'Famix-SQL';
			
			"importers"
			package: 'Moose-SQL-Importer';
				
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

{ #category : #baselines }
ConfigurationOfFamixSQL >> baseline12: spec [ 
	<version: '1.2-baseline'>
	
	spec for: #common do: [
		spec blessing: #default.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/MooseSQL/main'.
		
		spec 
			"Core"	
			package: 'Famix-SQL';
			
			"importers"
			package: 'Moose-SQL-Importer';
				
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

{ #category : #baselines }
ConfigurationOfFamixSQL >> baseline20: spec [ 
	<version: '2.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #default.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/MooseSQL/main'.
		
		spec 
			"Core"	
			package: 'Famix-SQL';
			
			"importers"
			package: 'Moose-SQL-Importer';
				
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

{ #category : #'as yet unclassified' }
ConfigurationOfFamixSQL >> baseline40: spec [ 
	<version: '4.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/MooseSQL/main'.
		
		spec 
			"Core"	
			package: 'Famix-SQL';
			
			"importers"
			package: 'Moose-SQL-Importer';
				
			"Tests"
			package: 'Famix-Tests-SQL'with: [spec requires: 'Famix-SQL'];
			package: 'Moose-Tests-SQL-Importer' with: [spec requires: 'Moose-SQL-Importer'].
			
		
		spec group: 'Model' with: #('Famix-SQL').
		spec group: 'Model-Tests' with: #('Famix-Tests-SQL').
		
		spec group: 'Importer' with: #('Moose-SQL-Importer').
		spec group: 'Importer-Tests' with: #('Moose-Tests-SQL-Importer').
	
		spec group: 'default' with: #('Model' 'Importer' 'Model-Tests' 'Importer-Tests').
	]
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
ConfigurationOfFamixSQL >> development: spec [
	<symbolicVersion: #development>

	spec for: #'pharo1.4.x' version: '1.1-baseline'.
	spec for: #'pharo2.x' version: '2.1'.
	spec for: #'pharo3.x' version: '2.0-baseline'.
	spec for: #'pharo4.x' version: '4.0-baseline'.

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

{ #category : #baselines }
ConfigurationOfFamixSQL >> version21: spec [
	<version: '2.1' imports: #('1.2-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'FabrizioPerin'.
		spec description: 'release 2.1 for Moose 4.9 on pharo 2.0'.
		spec timestamp: '04/03/2014 11:00'.
	
		spec
			"Models"
			package: 'Famix-SQL' with: 'Famix-SQL-FabrizioPerin.35';
			
			"importers"
			package: 'Moose-SQL-Importer' with: 'Moose-SQL-Importer-FabrizioPerin.21';
				
			"Tests"
			package: 'Famix-Tests-SQL'with: 'Famix-Tests-SQL-FabrizioPerin.18';
			package: 'Moose-Tests-SQL-Importer' with: 'Moose-Tests-SQL-Importer-FabrizioPerin.2'.
			
		
		spec group: 'Tests' with: #( 
			'Famix-Tests-SQL'
			'Moose-Tests-SQL-Importer').			
		].
]

{ #category : #'as yet unclassified' }
ConfigurationOfFamixSQL >> version40: spec [
	<version: '4.0' imports: #('4.0-baseline')>

	spec for: #common do: [
		spec blessing: #release.
		spec author: 'FabrizioPerin'.
		spec description: 'release 4.0 for Moose 5.1 on pharo 4.0'.
		spec timestamp: '14/07/2015 11:00'.
	
		spec
			"Models"
			package: 'Famix-SQL' with: 'Famix-SQL-AnneEtien.70';
			
			"importers"
			package: 'Moose-SQL-Importer' with: 'Moose-SQL-Importer-FabrizioPerin.21';
				
			"Tests"
			package: 'Famix-Tests-SQL'with: 'Famix-Tests-SQL-AnneEtien.25';
			package: 'Moose-Tests-SQL-Importer' with: 'Moose-Tests-SQL-Importer-FabrizioPerin.2'.
			
		
		spec group: 'Tests' with: #( 
			'Famix-Tests-SQL'
			'Moose-Tests-SQL-Importer').			
		].
]
