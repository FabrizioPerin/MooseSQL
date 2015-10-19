"
A PetitSQLIslandVisitor is a visitor that only visit the nodes of the AST.

Instance Variables
	collFamixTables:		gathers FAMIXTables 
	currentColumn:		corresponds to the current column for which properties are computed
	currentColumns:		corresponds to a collection of columns 
	currentFunction:		corresponds to the current function for which properties are computed
	currentTable:		corresponds to the current table for which properties are computed
	currentView:		corresponds to the current view for which properties are computed
	model:		corresponds to the mooseModel

"
Class {
	#name : #PetitSQLIslandVisitor,
	#superclass : #Object,
	#instVars : [
		'model',
		'currentEntitiesStack'
	],
	#category : #'PetitSQLIsland-Visitors'
}

{ #category : #accessing }
PetitSQLIslandVisitor >> currentEntitiesStack [
	^ currentEntitiesStack
]

{ #category : #accessing }
PetitSQLIslandVisitor >> currentEntitiesStack: anObject [
	currentEntitiesStack := anObject
]

{ #category : #'stack management' }
PetitSQLIslandVisitor >> getCurrentEntities [
	^ self currentEntitiesStack top
]

{ #category : #'stack management' }
PetitSQLIslandVisitor >> getCurrentEntity [
	self assert: (self getCurrentEntities size = 1).
	^ self getCurrentEntities first
]

{ #category : #initialization }
PetitSQLIslandVisitor >> initialize [
	super initialize.
	currentEntitiesStack := Stack new.
]

{ #category : #accessing }
PetitSQLIslandVisitor >> model [
	^ model
]

{ #category : #accessing }
PetitSQLIslandVisitor >> model: anObject [
	model := anObject
]

{ #category : #'stack management' }
PetitSQLIslandVisitor >> popCurrentEntities [
	^ self currentEntitiesStack pop
]

{ #category : #'stack management' }
PetitSQLIslandVisitor >> popCurrentEntity [
	self assert: (self getCurrentEntities size = 1).
	^ self popCurrentEntities first
]

{ #category : #'stack management' }
PetitSQLIslandVisitor >> pushCurrentEntities: aCollectionOfEntities [
	self currentEntitiesStack push: aCollectionOfEntities
]

{ #category : #'stack management' }
PetitSQLIslandVisitor >> pushCurrentEntity: anEntity [
	self pushCurrentEntities: { anEntity }
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitASTFunctionBodyNode: aSQLASTFunctionBodyNode [ 
	^ aSQLASTFunctionBodyNode items collect: [ :req | req acceptVisitor: self ]
	
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitASTFunctionNameNode: aSQLASTFunctionNameNode [ 
	^ aSQLASTFunctionNameNode functionName
]

{ #category : #helpers }
PetitSQLIslandVisitor >> visitASTFunctionSignatureNode: aSQLASTFunctionSignatureNode [
	aSQLASTFunctionSignatureNode functionName acceptVisitor: self.
	aSQLASTFunctionSignatureNode parameters acceptVisitor: self
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitASTParameterNode: aSQLASTParameterNode [ 
	^ aSQLASTParameterNode parameterType acceptVisitor: self
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitASTParametersNode: aSQLASTParametersNode [ 
	^ aSQLASTParametersNode parameters collect: [ :anASTParameterNode | anASTParameterNode acceptVisitor: self ]
]

{ #category : #visitor }
PetitSQLIslandVisitor >> visitASTTypeNameNode: aSQLASTTypeNameNode [ 
	^ aSQLASTTypeNameNode typeName acceptVisitor: self
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitAffectationNode: aSQLASTAffectationNode [ 
	aSQLASTAffectationNode columnReference acceptVisitor: self .
	aSQLASTAffectationNode rightAffectationMember acceptVisitor: self 
	
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitAllSelectedColumnsNode: aNode [
	
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitAlterTableConstraintFKNode: anAlterTableConstraintFKNode [
	^anAlterTableConstraintFKNode foreignKeyClause acceptVisitor: self.
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitAlterTableConstraintPKNode: anAlterTableConstraintPKNode [
	| cols |
	cols := self getCurrentEntity columns select: [ :c | anAlterTableConstraintPKNode columns includes: c name  ] .
	self assert: cols size = anAlterTableConstraintPKNode columns size .
	^cols 
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitAlterTableNode: anAlterTableNode [

	self pushCurrentEntity: (self model entities
		detect: [ :e | e isTable and: [ e name = anAlterTableNode tableReference tableName] ] ).
		anAlterTableNode constraint acceptVisitor: self.
	self popCurrentEntity 
	
]

{ #category : #visitor }
PetitSQLIslandVisitor >> visitArgumentNode: aSQLASTArgumentNode [ 
	^ FAMIXParameter new
		mooseModel: self model;
		yourself
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitColumnConstraintNode: aColumnConstraintNode [

]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitColumnReferenceNode: aColumnReferenceNode [
  
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitColumnTypeNode: aColumnTypeNode [

]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitColumnsExpressionsNode: aColumnsExpressionsNode [
	 self pushCurrentEntities: (aColumnsExpressionsNode columnsOrExpressions collect: [ :aColOrExprNode | aColOrExprNode acceptVisitor: self ]).
	^ self popCurrentEntities 
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitComplexIdentifierNode: aPetitSQLNode [
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitConditionNode: aSQLASTConditionNode [ 
	^ (aSQLASTConditionNode terms collect: [ :aTerm | aTerm acceptVisitor: self ]) select: #isNotNil
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitCreateColumnNode: aCreateColumnNode [
	
	| default |
	aCreateColumnNode type acceptVisitor: self.
	default := (aCreateColumnNode constraints detect: #isDefaultConstraint ifNone: [nil]).
	default ifNotNil: [ :d | d acceptVisitor: self].
	
]

{ #category : #visitor }
PetitSQLIslandVisitor >> visitCreateFunctionNode: aSQLASTCreateFunctionNode [
	self pushCurrentEntity: aSQLASTCreateFunctionNode. "Push this node to be able to add the language to the FAMIX modele."
	self pushCurrentEntity: (aSQLASTCreateFunctionNode signature acceptVisitor: self).
	aSQLASTCreateFunctionNode body acceptVisitor: self.
	self popCurrentEntity. "Pop the signature"
	self popCurrentEntity. "Pop the SQLASTCreateFunctionNode"
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitCreateSequenceNode: aCreateSequenceNode [

]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitCreateTableNode: aCreateTableNode [

	aCreateTableNode columns do: [ :each | each acceptVisitor: self ].
	aCreateTableNode inheritance ifNotNil: [ aCreateTableNode inheritance acceptVisitor: self ].

]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitCreateTriggerNode: aCreateTriggerNode [

]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitCreateViewNode: aCreateViewNode [
	self pushCurrentEntity:(aCreateViewNode selectRequest acceptVisitor: self).
	^self popCurrentEntity
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitCrossJoinNode: aSQLASTCrossJoinNode [
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitDatabaseNode: aDatabaseNode [
	^ aDatabaseNode statements do: [ :s | s acceptVisitor: self ]
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitDefaultConstraintNode: aCreateDefaultConstraintNode [
	^aCreateDefaultConstraintNode default acceptVisitor: self. 

]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitExpressionNode: aExpressionNode [
	
	 
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitForeignKeyClauseNode: aForeignKeyClauseNode [
	
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitFunctionCallNode: aSQLASTFunctionInvocationNode [

]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitInheritanceNode: anASTInheritanceNode [
	
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitLiteralValueNode: aLiteralValueNode [
	^ aLiteralValueNode value
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitLocalVariablesDeclarationNode: aSQLASTLocalVariablesDeclarationNode [
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitOptionallyRenamedColumnNode: anOptionallyRenamedColumnNode [
	^ anOptionallyRenamedColumnNode columnReference acceptVisitor: self.

]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitOptionallyRenamedExpressionNode: anOptionallyRenamedExpressionNode [

	anOptionallyRenamedExpressionNode expression terms do: [:each | each acceptVisitor: self].

]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitOptionallyRenamedFunctionCallNode: anOptionallyRenamedFunctionCallNode [
	^ anOptionallyRenamedFunctionCallNode functionCall acceptVisitor: self
	
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitOriginsNode: anOriginsNode [
	| tablesOrFunctions | 
	tablesOrFunctions := anOriginsNode origins
		collect: [ :anOriginNode |  anOriginNode acceptVisitor: self  ].
		
	tablesOrFunctions do: [ :aTableOrFunction | self getCurrentEntity addDependencyIfNotExistTo: aTableOrFunction ].
	^ tablesOrFunctions
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitOwnerConstraintNode: anOwnerConstraintNode [
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitSelectRequestNode: aSelectRequestNode [
	aSelectRequestNode origins acceptVisitor: self.
	aSelectRequestNode columnsOrExpressionsOrStar acceptVisitor: self.
	aSelectRequestNode condition ifNotNil: [ aSelectRequestNode condition acceptVisitor: self ].
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitTableReferenceNode: aTableReferenceNode [

	^  self model entities detect: [ :each | each isTable and: [ each name = aTableReferenceNode tableName ] ].
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitUpdateRequestNode: aSQLASTUpdateRequestNode [ 
	| affectations |
	self pushCurrentEntity: (aSQLASTUpdateRequestNode tableReference acceptVisitor: self).

	affectations := aSQLASTUpdateRequestNode affectations collect: [ :aff | aff acceptVisitor: self ].
	self popCurrentEntity.
	^ affectations
]

{ #category : #visiting }
PetitSQLIslandVisitor >> visitValueHolderReferenceNode: aSQLASTValueHolderNode [
]
