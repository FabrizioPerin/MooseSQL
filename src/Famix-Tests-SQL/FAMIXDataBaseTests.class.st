Class {
	#name : #FAMIXDataBaseTests,
	#superclass : #FAMIXRelationalEntityTests,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXDataBaseTests >> testAnnotation [
	self assert: FAMIXDataBase annotation == FAMIXDataBase.
]

{ #category : #'as yet unclassified' }
FAMIXDataBaseTests >> testPrintOn [
	| db stream |

	db := FAMIXDataBase new name: 'Database1'.
	
	stream := ReadWriteStream on: ''.
	db printOn: stream.
	
	self assert: (stream contents = (db name asString , ' (Database)')).
]

{ #category : #'as yet unclassified' }
FAMIXDataBaseTests >> testTables [
	| db stream |

	db := FAMIXDataBase new name: 'Database1'.
	
	
	
	db tables: (OrderedCollection with: (FAMIXTable new name: 'table1') with: (FAMIXTable new name: 'table2')).
	
	self assert: (db tables isCollection).
	self assert: db tables size equals: 2.
	self assert: (db tables first isMemberOf: FAMIXTable).
	self assert: db tables first name equals: 'table1'.
	

]
