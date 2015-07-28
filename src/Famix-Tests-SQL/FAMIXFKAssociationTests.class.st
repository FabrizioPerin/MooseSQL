Class {
	#name : #FAMIXFKAssociationTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXFKAssociationTests >> testAnnotation [
	self assert: FAMIXFKToPKAssociation annotation == FAMIXFKToPKAssociation.
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKAssociationCreation [

	| fkAssoc mooseModel |
	
	fkAssoc := FAMIXFKToPKAssociation new.
	
	self assert: (fkAssoc isMemberOf:  FAMIXFKToPKAssociation).
	
	mooseModel := MooseModel new.
	mooseModel add: fkAssoc.
	
	self assert: ((mooseModel allWithType: FAMIXFKToPKAssociation) size = 1).

]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKFrom [
	
	| fkAssoc col |
	
	col := FAMIXColumn new.
	 
	fkAssoc := FAMIXFKToPKAssociation new sourceColumn: col.
	
	self assert: (fkAssoc from = col).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKFromAndTo [
	
	| fkAssoc pkCol fkCol |
	
	pkCol := FAMIXColumn new name: #PKCol.
	fkCol := FAMIXColumn new name: #FKCol.
	
	fkAssoc := FAMIXFKToPKAssociation new targetColumn: pkCol; sourceColumn: fkCol.
	
	self assert: (fkAssoc targetColumn = fkAssoc to).  
	self assert: (fkAssoc to = pkCol).
	  
	self assert: (fkAssoc sourceColumn = fkAssoc from).  
	self assert: (fkAssoc from = fkCol).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKSourceColumn [
	
	| fkAssoc col |

col := FAMIXColumn new.
	
	fkAssoc := FAMIXFKToPKAssociation new sourceColumn: col.
	
	self assert: (fkAssoc sourceColumn = col).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKTargetColumn [
	
	| fkAssoc col |
	
	col := FAMIXColumn new.
	
	fkAssoc := FAMIXFKToPKAssociation new targetColumn: col.
	
	self assert: (fkAssoc targetColumn = col).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testMJFAMIXFKTo [
	
	| fkAssoc col |

	col := FAMIXColumn new.
	
	fkAssoc := FAMIXFKToPKAssociation new targetColumn: col.
	
	self assert: (fkAssoc to = col).
]

{ #category : #testsOnJEEModel }
FAMIXFKAssociationTests >> testPrintOn [
	|   fkAssoc stream pkCol fkCol |
	
	pkCol := FAMIXColumn new name: #pkCol.
	fkCol := FAMIXColumn new name: #fkCol.
	
	fkAssoc := FAMIXFKToPKAssociation new
		targetColumn: pkCol;
		sourceColumn: fkCol.
	
	self assert: fkAssoc targetColumn = fkAssoc to.
	self assert: fkAssoc to = pkCol.
	self assert: fkAssoc sourceColumn = fkAssoc from.
	self assert: fkAssoc from = fkCol.
	
	stream := ReadWriteStream on: ''.
	fkAssoc printOn: stream.
	self
		assert:
			stream contents
				= (fkAssoc sourceColumn name asString , ' -> ' , fkAssoc targetColumn name asString , '(FK association)')
]
