Class {
	#name : #FAMIXSQLConstraintTests,
	#superclass : #TestCase,
	#category : #'Famix-Tests-SQL'
}

{ #category : #initialization }
FAMIXSQLConstraintTests >> testAddFKColumnName [
	| const |

	const := FAMIXSQLConstraint new.

	const addFKColumnName: #Col1.
	const addFKColumnName: #Col2.
	
	self assert: (const fkColumnNames size = 2). 
	self assert: (const fkColumnNames first = #Col1).
	self assert: (const fkColumnNames second = #Col2).  
]

{ #category : #initialization }
FAMIXSQLConstraintTests >> testAddPKColumnName [
	| const |

	const := FAMIXSQLConstraint new.

	const addPKColumnName: #Col1.
	const addPKColumnName: #Col2.
	
	self assert: (const pkColumnNames size = 2). 
	self assert: (const pkColumnNames first = #Col1).
	self assert: (const pkColumnNames second = #Col2).  
]

{ #category : #initialization }
FAMIXSQLConstraintTests >> testAddUniqueColumnName [
	| const |

	const := FAMIXSQLConstraint new.

	const addUniqueColumnName: 'uniqueColumn'.
	
	self assert: (const uniqueColumnNames size = 1).
	self assert: (const uniqueColumnNames first = 'uniqueColumn').
]

{ #category : #tests }
FAMIXSQLConstraintTests >> testAnnotation [
	self assert: FAMIXSQLConstraint annotation == FAMIXSQLConstraint.
]

{ #category : #initialization }
FAMIXSQLConstraintTests >> testIsCheck [
	| const |

	const := FAMIXSQLConstraint new.
	
	const isCheck: true.
	
	self assert: (const expressionString = nil).
	
	const expressionString: 'should be an expression'.
	
	self assert: (const expressionString = 'should be an expression').
	
]

{ #category : #initialization }
FAMIXSQLConstraintTests >> testIsFKConstraint [	
	| const |

	const := FAMIXSQLConstraint new.

	self assert: (const isFKConstraint = nil).
	
	const isFKConstraint: true.
	
	self assert: const isFKConstraint.
]

{ #category : #initialization }
FAMIXSQLConstraintTests >> testIsPKConstraint [	
	| const |

	const := FAMIXSQLConstraint new.

	self assert: (const isPKConstraint = nil).
	
	const isPKConstraint: true.
	
	self assert: const isPKConstraint.
]

{ #category : #initialization }
FAMIXSQLConstraintTests >> testIsUnique [
	| const |

	const := FAMIXSQLConstraint new.

	self assert: (const isUnique = nil).
	
	const isUnique: true.
	
	self assert: const isUnique.
]

{ #category : #initialization }
FAMIXSQLConstraintTests >> testName [
	| const |

	const := FAMIXSQLConstraint new.
	
	self assert: (const name = nil).
	
	const := FAMIXSQLConstraint new name: 'Constraint_1'.
	
	self assert: (const name = 'Constraint_1').
]

{ #category : #initialization }
FAMIXSQLConstraintTests >> testReferencedTableName [
	| const |

	const := FAMIXSQLConstraint new.
	
	self assert: (const referencedTableName = nil).
	
	const referencedTableName: 'Tab1'.  
	
	self assert: (const referencedTableName = #Tab1). 

]
