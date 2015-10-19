"
A PetitSQLIslandDef is a visitor used to create FAMIX entities.

"
Class {
	#name : #PetitSQLIslandDef,
	#superclass : #PetitSQLIslandVisitor,
	#category : #'PetitSQLIsland-Visitors'
}

{ #category : #helpers }
PetitSQLIslandDef >> createTableAssociationFrom: aFamixTable to: each [ 
	^ FAMIXViewToTableAssociation new
		mooseModel: self model;
		view: aFamixTable;
		table: each;
		yourself
]

{ #category : #visiting }
PetitSQLIslandDef >> visitASTFunctionBodyNode: aSQLASTFunctionBodyNode [ 
]

{ #category : #helpers }
PetitSQLIslandDef >> visitASTFunctionSignatureNode: aSQLASTFunctionSignatureNode [
	| createFunctionNode |
	createFunctionNode := self getCurrentEntity.
	^ FAMIXSQLFunction new
		name: (aSQLASTFunctionSignatureNode functionName acceptVisitor: self);
		mooseModel: self model;
		sqlParameters: (aSQLASTFunctionSignatureNode parameters acceptVisitor: self);
		language: createFunctionNode language;
		yourself
]

{ #category : #visiting }
PetitSQLIslandDef >> visitASTParameterNode: aSQLASTParameterNode [ 
	^ FAMIXParameter new
		name: aSQLASTParameterNode parameterName;
		declaredType: (aSQLASTParameterNode parameterType acceptVisitor: self);
		mooseModel: self model;
		yourself
]

{ #category : #visiting }
PetitSQLIslandDef >> visitAlterTableConstraintPKNode: anAlterTableConstraintPKNode [
	| cols |
	cols := super visitAlterTableConstraintPKNode: anAlterTableConstraintPKNode.
	^cols do: [ :c | c isPK: true ]
]

{ #category : #visiting }
PetitSQLIslandDef >> visitColumnTypeNode: aColumnTypeNode [
	^ [self model entities
		detect: [ :e | e isPrimitiveType and: [ e name = aColumnTypeNode name ] ] ]
		on: NotFound
		do: [ FAMIXPrimitiveType new
				name: aColumnTypeNode name;
				mooseModel: self model ]
]

{ #category : #visiting }
PetitSQLIslandDef >> visitCreateColumnNode: aCreateColumnNode [
	| col |
	col := FAMIXColumn new
		name: aCreateColumnNode identifier;
		mooseModel: self model;
		type: (aCreateColumnNode type acceptVisitor: self);
		isUnique: aCreateColumnNode hasUniqueConstraint;
		canBeNull: aCreateColumnNode hasNotNullConstraint not;
		yourself.
		^ col.
]

{ #category : #visiting }
PetitSQLIslandDef >> visitCreateSequenceNode: aCreateSequenceNode [

	FAMIXSequence new mooseModel: self model; name: aCreateSequenceNode complexIdentifier tableName.
]

{ #category : #visiting }
PetitSQLIslandDef >> visitCreateTableNode: aCreateTableNode [
	self
		pushCurrentEntity: 
			(FAMIXTable new
				name: aCreateTableNode tableName;
				mooseModel: self model;
				yourself).
	self getCurrentEntity columns: (aCreateTableNode columns collect: [ :each | each acceptVisitor: self ]).
	aCreateTableNode inheritance ifNotNil: [ aCreateTableNode inheritance acceptVisitor: self ].
	^ self popCurrentEntity 
]

{ #category : #visiting }
PetitSQLIslandDef >> visitCreateTriggerNode: aCreateTriggerNode [
	
	
				

]

{ #category : #visiting }
PetitSQLIslandDef >> visitCreateViewNode: aCreateViewNode [

	| view |
	view := FAMIXView new name: aCreateViewNode tableName ; mooseModel: self model; yourself.
	
	^view.
]

{ #category : #visiting }
PetitSQLIslandDef >> visitInheritanceNode: anASTInheritanceNode [
	self flag: 'This code can not works from now since id does not uses the stack (and currentTable inst. var is undeclared).'.
	Warning signal: 'This code can not works from now since id does not uses the stack (and currentTable inst. var is undeclared).'.
	"| tableColName otherCols table |
	table := self model entities detect: [ :t | t isTable and: [anASTInheritanceNode identifier = t name ] ] .
	self assert: table isNotNil .
	tableColName := currentTable columns collect: #name.
	otherCols := table columns reject: [ :tc | tableColName includes: tc name ].
	otherCols do: [ :c | | col| 
		col := FAMIXColumn new
		name: c name;
		mooseModel: self model;
		ownerTable: currentTable;
		type: c type;
		isUnique: c isUnique;
		canBeNull: c canBeNull;
		isInherited: true;
		yourself.
		c defaultValueConstraint ifNotNil: [col defaultValueConstraint: c defaultValueConstraint]
		].

	FAMIXSQLInheritance new mooseModel: self model ; childTable: currentTable ; parentTable: table."
	
]

{ #category : #visiting }
PetitSQLIslandDef >> visitSelectRequestNode: aSelectRequestNode [
]

{ #category : #visiting }
PetitSQLIslandDef >> visitTableReferenceNode: aTableReferenceNode [
	| famixTable |
	famixTable := self model entities detect: [ :each | each isTable and: [ each name = aTableReferenceNode tableName ] ].
	self createTableAssociationFrom: self getCurrentEntity to: famixTable.
	^ famixTable
]
