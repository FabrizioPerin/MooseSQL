Class {
	#name : #FAMIXFKAssociationTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXFKAssociationTests >> testAnnotation [
	self assert: FAMIXFKAssociation annotation == FAMIXFKAssociation.
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKAssociationCreation [

	| fkAssoc mooseModel |
	
	fkAssoc := FAMIXFKAssociation new.
	
	self assert: (fkAssoc isMemberOf:  FAMIXFKAssociation).
	
	mooseModel := MooseModel new.
	mooseModel add: fkAssoc.
	
	self assert: ((mooseModel allWithType: FAMIXFKAssociation) size = 1).

]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKFrom [
	
	| jEETestModel mooseModel table1 fkAssoc |

	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	table1 := mooseModel entityNamed: #Table1.
	
	fkAssoc := FAMIXFKAssociation new sourceColumn: table1.
	
	self assert: (fkAssoc from = table1).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKFromAndTo [
	
	| jEETestModel mooseModel table1 table2 fkAssoc map class table |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table1 := mooseModel entityNamed: #Table1.
	table2 := mooseModel entityNamed: #Table2.
	
	fkAssoc := FAMIXFKAssociation new targetColumn: table1; sourceColumn: table2.
	
	self assert: (fkAssoc targetColumn = fkAssoc to).  
	self assert: (fkAssoc to = table1).
	  
	self assert: (fkAssoc sourceColumn = fkAssoc from).  
	self assert: (fkAssoc from = table2).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKSourceColumn [
	
	| jEETestModel mooseModel table1 fkAssoc |

	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	table1 := mooseModel entityNamed: #Table1.
	
	fkAssoc := FAMIXFKAssociation new sourceColumn: table1.
	
	self assert: (fkAssoc sourceColumn = table1).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKTargetColumn [
	
	| jEETestModel mooseModel table1 fkAssoc |

	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	table1 := mooseModel entityNamed: #Table1.
	
	fkAssoc := FAMIXFKAssociation new targetColumn: table1.
	
	self assert: (fkAssoc targetColumn = table1).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKTo [
	
	| jEETestModel mooseModel table1 fkAssoc |

	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	
	table1 := mooseModel entityNamed: #Table1.
	
	fkAssoc := FAMIXFKAssociation new targetColumn: table1.
	
	self assert: (fkAssoc to = table1).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testPrintOn [
	| jEETestModel mooseModel table1 table2 fkAssoc stream |

	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table1 := mooseModel entityNamed: #Table1.
	table2 := mooseModel entityNamed: #Table2.
	
	fkAssoc := FAMIXFKAssociation new targetColumn: table1; sourceColumn: table2.
	
	self assert: (fkAssoc targetColumn = fkAssoc to).  
	self assert: (fkAssoc to = table1).
	  
	self assert: (fkAssoc sourceColumn = fkAssoc from).  
	self assert: (fkAssoc from = table2).
	
	stream := ReadWriteStream on: ''.
	fkAssoc printOn: stream.
	
	self assert: (stream contents = (fkAssoc sourceColumn name asString , ' -> ' , fkAssoc targetColumn name asString , '(FK association)')).
]
