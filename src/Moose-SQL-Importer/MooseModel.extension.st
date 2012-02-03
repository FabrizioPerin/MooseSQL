Extension { #name : #MooseModel }

{ #category : #'*moose-sql-importer' }
MooseModel >> importDBStructureFrom: aFileStream [
	
	| parser result ejbVer |

	UIManager default
		displayProgress: 'Importing DB From an SQL file'
		at: Sensor cursorPoint
		from: 1 
		to: 5
		during: [ :bar | 
			| importer |
			
			bar value: 2.
			bar value: 'Parsing SQL file'.
			importer := MooseSQLiteImporter new targetModel: self.
			importer importSQLCreateScriptFrom: ([ aFileStream contentsOfEntireFile ]
																				ensure: [ aFileStream close ]).
			
			bar value: 4.
			bar value: 'Building relations'.
			
			bar value: 5].
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
