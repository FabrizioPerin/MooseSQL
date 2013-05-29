Extension { #name : #MooseModel }

{ #category : #'*moose-sql-importer' }
MooseModel >> importDBStructureFrom: aFileStream [
	| importer |
	
	importer := MooseSQLiteImporter new targetModel: self.
	importer importSQLCreateScriptFrom: ([ aFileStream contentsOfEntireFile ]
															ensure: [ aFileStream close ]).
			
	^self
]

{ #category : #'*moose-sql-importer' }
MooseModel >> importDBStructureFromUI [
	<menuItem: 'Import database definition from SQL file' category: 'Import / Export'>
	
	| file |
	
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse:[self importDBStructureFrom: file readStream].
]
