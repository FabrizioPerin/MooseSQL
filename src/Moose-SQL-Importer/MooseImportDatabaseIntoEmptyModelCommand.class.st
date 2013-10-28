Class {
	#name : #MooseImportDatabaseIntoEmptyModelCommand,
	#superclass : #MPImportCommand,
	#category : #'Moose-SQL-Importer'
}

{ #category : #'as yet unclassified' }
MooseImportDatabaseIntoEmptyModelCommand >> execute [
	
	| file mooseModel |
	
	file := UITheme builder 
		fileOpen: 'Import information from SQL file'
		extensions: #('sql').

	file isNil 
		ifTrue: [ DialogWindow new alert: 'File not found.'.]
		ifFalse:[
			mooseModel := MooseModel new.
			mooseModel name: (file name sliceFrom: ((file name findLastOccurrenceOfString: DiskStore delimiter asString startingAt: 1) + 1)  to: file name size ).
	
			mooseModel importDBStructureFrom: (StandardFileStream readOnlyFileNamed: file name).
			
			mooseModel add: FAMIXSQLSourceLanguage new.
			
			mooseModel install].
]

{ #category : #'as yet unclassified' }
MooseImportDatabaseIntoEmptyModelCommand >> label [
	^ 'Import Relational Data Base in an empty model'
]
