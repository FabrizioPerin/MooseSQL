"
A PetitSQLIslandRef is a visitor used to defined  references between FAMIX entities.

"
Class {
	#name : #PetitSQLIslandRef,
	#superclass : #PetitSQLIslandVisitor,
	#category : #'PetitSQLIsland-Visitors'
}

{ #category : #visiting }
PetitSQLIslandRef >> checkFunctionParameters: famixFunctionParameters with: astFunctionParameters [
	^ famixFunctionParameters size = astFunctionParameters size
		ifTrue: [ 
			| iterator |
			iterator := ReadStream on: astFunctionParameters.
			famixFunctionParameters
				allSatisfy: [ :param | 
					| astParam |
					astParam := iterator next.
					param name = astParam key and: [ param declaredType = astParam value ] ] ]
		ifFalse: [ false ]
]

{ #category : #helpers }
PetitSQLIslandRef >> createColumnAssociationsFromTableColumns: aCollectionOfColumnsWithAlias toViewColumns: aCollectionOfViewColumns [
	aCollectionOfViewColumns do: [ :col | |tableColOrExpressionWithAlias|
		tableColOrExpressionWithAlias := (aCollectionOfColumnsWithAlias detect: [ :assoc | col name = assoc value ]) key.
		
			tableColOrExpressionWithAlias isCollection ifTrue: [ 
				"in that case column is defined from an expression"
				tableColOrExpressionWithAlias do: [ :aColumnOrFunction | col addDependencyIfNotExistTo: aColumnOrFunction ] ]
		ifFalse: [ col addDependencyIfNotExistToColumn: tableColOrExpressionWithAlias]
		
		  ]
	
]

{ #category : #helpers }
PetitSQLIslandRef >> createColumnsFromAssociations: aCollOfAssociationsColumnAlias inView: aView [
	^aCollOfAssociationsColumnAlias collect: [ :assoc | self createFamixColumnFrom: assoc key inView: aView alias: assoc value ].
]

{ #category : #helpers }
PetitSQLIslandRef >> createFamixColumnFrom: aFamixColumnOrFunction [
	^ self createFamixColumnFrom: aFamixColumnOrFunction withName: aFamixColumnOrFunction name
		
]

{ #category : #helpers }
PetitSQLIslandRef >> createFamixColumnFrom: aFamixColumnOrFunction alias: aString [
	^ self createFamixColumnFrom: aFamixColumnOrFunction withName: aString
]

{ #category : #helpers }
PetitSQLIslandRef >> createFamixColumnFrom: column inView: aView alias: aStringOrNil [
	| col |
	col := aStringOrNil
		ifNil: [ self createFamixColumnFrom: column ]
		ifNotNil: [ self createFamixColumnFrom: column alias: aStringOrNil ].
	col ownerTable: aView.
	^col
]

{ #category : #helpers }
PetitSQLIslandRef >> createFamixColumnFrom: aFamixColumnOrFunction withName: aString [
	| col |
		col := FAMIXColumn new
		name: aString;
		mooseModel: self model;
		yourself.
		
		self flag: 'Should look at function return type'.
		
		(aFamixColumnOrFunction isCollection not and: [ aFamixColumnOrFunction isColumn ]) ifTrue: [col type: aFamixColumnOrFunction type].
		^ col
		
]

{ #category : #helpers }
PetitSQLIslandRef >> retrieveFamixColumnCorrespondingTo: anASTCol from: aCollFamixTables [
	| famixCol |
	"flatCollect is useful since collFamixTables may be a collection of collections"
	famixCol := (aCollFamixTables flatCollect: [ :famixTable | famixTable columns ])
		detect: [ :each |
			anASTCol isValueHolderReference
				ifFalse: [ 
			each name = anASTCol column tableName
				and: [ anASTCol column tableSpace ifNotNil: [ each ownerTable name = anASTCol column tableSpace ] ifNil: [ true ] ] ]
				ifTrue: [ 
			each name = anASTCol valueHeld tableName
				and: [ anASTCol valueHeld tableSpace ifNotNil: [ each ownerTable name = anASTCol valueHeld tableSpace ] ifNil: [ true ] ] ] ]
		ifNone: [ ^ nil ]. "So this is a parameter reference."
	^ famixCol
]

{ #category : #visiting }
PetitSQLIslandRef >> visitASTFunctionBodyNode: aSQLASTFunctionBodyNode [  
	aSQLASTFunctionBodyNode items do: [:aRequestOrFunction | (aRequestOrFunction acceptVisitor: self) addDependencyIfNotExistFrom: self getCurrentEntity   ].
]

{ #category : #helpers }
PetitSQLIslandRef >> visitASTFunctionSignatureNode: aSQLASTFunctionSignatureNode [
	self pushCurrentEntity: (self model
		detect: [ :entity | 
			entity isSQLFunction
				and: [ 
					entity name = (aSQLASTFunctionSignatureNode functionName acceptVisitor: self)
						and: [ self checkFunctionParameters: entity sqlParameters with: (aSQLASTFunctionSignatureNode parameters acceptVisitor: self)] ] ]). 
	^ self popCurrentEntity 			
	
]

{ #category : #visiting }
PetitSQLIslandRef >> visitASTParameterNode: aSQLASTParameterNode [ 
	^ aSQLASTParameterNode parameterName -> (aSQLASTParameterNode parameterType acceptVisitor: self)
]

{ #category : #visiting }
PetitSQLIslandRef >> visitAllSelectedColumnsNode: aNode [
	^ self getCurrentEntities
		flatCollect: [ :aTableOrFunction | 
			aTableOrFunction isSQLFunction
				ifTrue: [ OrderedCollection new ]
				ifFalse: [ 
					aTableOrFunction columns
						collect: [ :aColumn | 
							PetitSQLTmpAliased
								new
								key: aColumn;
								value: aColumn name;
								yourself ] ] ]
]

{ #category : #visiting }
PetitSQLIslandRef >> visitAlterTableConstraintFKNode: anAlterTableConstraintFKNode [
	| cols |
	"Here currentEntity is a Table"
	cols := self getCurrentEntity columns select: [ :c | anAlterTableConstraintFKNode columns includes: c name  ] .
	self assert: cols size = anAlterTableConstraintFKNode columns size .
	cols do: [ :c | c isFK: true ].
	"adding column in currentEntities"
	self pushCurrentEntities: cols.
	anAlterTableConstraintFKNode foreignKeyClause acceptVisitor: self.
	^self popCurrentEntities
	"removing column from currentEntities. Here currentEntity is a Table"
]

{ #category : #visiting }
PetitSQLIslandRef >> visitColumnReferenceNode: aColumnReferenceNode [
	^self retrieveFamixColumnCorrespondingTo: aColumnReferenceNode from: self getCurrentEntities.
	
	
]

{ #category : #visiting }
PetitSQLIslandRef >> visitColumnTypeNode: aColumnTypeNode [
	^ self model allTypes entityNamed: aColumnTypeNode name
]

{ #category : #visiting }
PetitSQLIslandRef >> visitCreateColumnNode: aCreateColumnNode [
	self
		pushCurrentEntity:
			(self model entities detect: [ :anEntity | anEntity isColumn and: [ anEntity name = aCreateColumnNode identifier ] ]).
	aCreateColumnNode hasDefaultConstraint
		ifTrue: [ self getCurrentEntity defaultValueConstraint: ((aCreateColumnNode constraints detect: #isDefaultConstraint) acceptVisitor: self) ].
	^self popCurrentEntity
]

{ #category : #visiting }
PetitSQLIslandRef >> visitCreateTriggerNode: aCreateTriggerNode [
	| trigger |
	trigger := FAMIXTrigger new
		name: aCreateTriggerNode identifier;
		mooseModel: self model;
		yourself.
	
	self pushCurrentEntity: trigger.

	trigger ownerTable: (aCreateTriggerNode table acceptVisitor: self). 
	trigger invokedFunction: (aCreateTriggerNode procedure acceptVisitor: self).
	self popCurrentEntity.
	^trigger
	
	

]

{ #category : #visiting }
PetitSQLIslandRef >> visitCreateViewNode: aCreateViewNode [
	| tmpRequestObject columns |
	self pushCurrentEntity:
			(self model entities detect: [ :anEntity | anEntity isView and: [ anEntity name = aCreateViewNode tableName ] ]).	
	
	"Here we obtain all the columns with eventually their alias in an association array (column -> alias)"
	tmpRequestObject := aCreateViewNode selectRequest acceptVisitor: self.
	columns := self createColumnsFromAssociations: tmpRequestObject columnsWithAliasAssociations inView: self getCurrentEntity.
	self getCurrentEntity
		columns: columns.
		self createColumnAssociationsFromTableColumns:tmpRequestObject columnsWithAliasAssociations toViewColumns: self getCurrentEntity columns.
	^self popCurrentEntity
]

{ #category : #visiting }
PetitSQLIslandRef >> visitDefaultConstraintNode: aCreateDefaultConstraintNode [
	| defaultConstraint |
	defaultConstraint := FAMIXDefaultValueConstraint new mooseModel: self model.
	aCreateDefaultConstraintNode default
		ifNotNil: [ 
			aCreateDefaultConstraintNode default isLiteralValue
				ifTrue: [ defaultConstraint value: (aCreateDefaultConstraintNode default acceptVisitor: self) ]
				ifFalse: [ defaultConstraint function: (aCreateDefaultConstraintNode default acceptVisitor: self) ] ].
	^ defaultConstraint
]

{ #category : #visiting }
PetitSQLIslandRef >> visitForeignKeyClauseNode: aForeignKeyClauseNode [
	| cols referencedTable |
	referencedTable := self model entities
		detect: [ :e | e isTable and: [ e name = aForeignKeyClauseNode tableIdentifier tableName ] ].
	cols := referencedTable columns select: [ :c | aForeignKeyClauseNode columnIdentifiers includes: c name ].
	self assert: cols size = aForeignKeyClauseNode columnIdentifiers size.
	^ self getCurrentEntities
		do: [ :cf | 
			cols
				do: [ :ct | 
					FAMIXFKToPKAssociation 
						new
						mooseModel: self model;
						sourceColumn: cf;
						targetColumn: ct ] ]
]

{ #category : #visiting }
PetitSQLIslandRef >> visitFunctionCallNode: aSQLASTFunctionCallNode [
	| famixFunct |
	famixFunct := [ self model entities detect: [ :e | e isSQLFunction and: [ e name = aSQLASTFunctionCallNode name and: [ aSQLASTFunctionCallNode arguments size = e sqlParameters size ] ] ] ]
		on: NotFound
		do: [ 
			famixFunct := FAMIXSQLFunction new
				name: aSQLASTFunctionCallNode name;
				signature: aSQLASTFunctionCallNode name asString;
				sqlParameters: (aSQLASTFunctionCallNode arguments collect: [ :anArgumentNode | anArgumentNode acceptVisitor: self ]);
				mooseModel: self model;
				isStub: true;
				yourself ].
	^ famixFunct 
]

{ #category : #visiting }
PetitSQLIslandRef >> visitOptionallyRenamedColumnNode: anOptionallyRenamedColumnNode [
	
	"Here we create an association for the referenced column with the alias"
	^ PetitSQLTmpAliased new  key:(anOptionallyRenamedColumnNode columnReference acceptVisitor: self) ; value: anOptionallyRenamedColumnNode columnName ; yourself
]

{ #category : #visiting }
PetitSQLIslandRef >> visitOptionallyRenamedExpressionNode: anOptionallyRenamedExpressionNode [
	|  name pa |
	
	name := anOptionallyRenamedExpressionNode alias
		"If the alias is nil, it means that the expression is composed of a unique function call that gives its name to the column"
		ifNil: [ anOptionallyRenamedExpressionNode expression terms first name ].
		pa := PetitSQLTmpAliased new. 
	(anOptionallyRenamedExpressionNode expression terms do: [:each | pa addKey: (each acceptVisitor: self)]).
	pa value: name.
	^ pa

]

{ #category : #visiting }
PetitSQLIslandRef >> visitSelectRequestNode: aSelectRequestNode [
	| requestObject   |
	requestObject := PetitSQLTmpRequest new.
	self pushCurrentEntities: (aSelectRequestNode origins acceptVisitor: self).
	requestObject selectedEntitiesWithAliases: (aSelectRequestNode columnsOrExpressionsOrStar acceptVisitor: self).
	aSelectRequestNode condition ifNotNil: [  requestObject setUsedEntities:( aSelectRequestNode condition acceptVisitor: self) ].
	self popCurrentEntities.
	^ requestObject
]

{ #category : #visiting }
PetitSQLIslandRef >> visitTriggerTableNode: aSQLASTTriggerTableNode [
	^(self model entities detect: [ :anEntity | anEntity isTable and: [ anEntity name = aSQLASTTriggerTableNode tableName ] ])
]

{ #category : #visiting }
PetitSQLIslandRef >> visitValueHolderReferenceNode: aSQLASTValueHolderNode [
	^self retrieveFamixColumnCorrespondingTo: aSQLASTValueHolderNode from: self getCurrentEntities.
	
	
]
