"
FAMIXRelationalEntity represents a relational entity such as Table, Column, Sequence, View.
"
Class {
	#name : #FAMIXRelationalEntity,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'mappedBy',
		'references',
		'sourceAccessors',
		'constraints'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #meta }
FAMIXRelationalEntity class >> annotation [
	<MSEClass: #RelationalEntity super: #FAMIXNamedEntity>
	<package: #SQL>
	^self
]

{ #category : #sorting }
FAMIXRelationalEntity >> <= aFamixRelationalEntity [ 
	^self className = aFamixRelationalEntity className
	ifTrue: [ self name <= aFamixRelationalEntity name ]
	ifFalse: [ self className <= aFamixRelationalEntity className ]
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> addCheckConstraintWith: anExpression [
	^ FAMIXSQLConstraint new
		mooseModel: self mooseModel;
		belongsTo: self;
		isCheck: true;
		expression: anExpression;
		yourself
]

{ #category : #accessing }
FAMIXRelationalEntity >> addConstraint: aMJFAMIXSQLConstraint [
	constraints add: aMJFAMIXSQLConstraint
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> addMappedBy: aMapping [

	mappedBy add: aMapping

]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> addReferencedBy: aForeignKeyAssoc [

	referencedBy add: aForeignKeyAssoc

]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> addReferences: aForeignKeyAssoc [

	references add: aForeignKeyAssoc

]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> addSourceAccessors: aDBAccess [

	sourceAccessors add: aDBAccess

]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> belongsTo [ 

	^ ''
]

{ #category : #accessing }
FAMIXRelationalEntity >> constraints [
	<MSEProperty: #constraints type: #FAMIXSQLConstraint opposite: #belongsTo> <multivalued> <derived>
	<MSEComment: 'Constraints contained into this relational entity.'>

	^ constraints
]

{ #category : #accessing }
FAMIXRelationalEntity >> constraints: aCollection [
	constraints value: aCollection
]

{ #category : #querying }
FAMIXRelationalEntity >> dependentEntities [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> initialize [
	super initialize.
	mappedBy := FMMultivalueLink on: self opposite: #mapTarget:.
	references := FMMultivalueLink on: self opposite: #sourceColumn:.
	
	sourceAccessors := FMMultivalueLink on: self opposite: #accessedEntity:.
	constraints := FMMultivalueLink 
		on: self
		opposite: #belongsTo:.
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> mappedBy [

	<MSEProperty: #mappedBy type: #FAMIXMapping opposite: #mapTarget> <multivalued> <derived>
	<MSEComment: 'Map relationships.'>
	
	^mappedBy
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> mappedNamedEntities [
	^self mapDirection: #mapSource on: self mooseModel allMaps 
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> mooseNameOn: aStream [ 
	self name isNil 
		ifFalse: [ aStream nextPutAll: self name ]
		
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> references [

	<MSEProperty: #references type: #FAMIXFKToPKAssociation opposite: #sourceColumn> <multivalued> 
	<MSEComment: 'Foreign Key constraint.'>
	
	^references
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> removePointersToMaps [
	mappedBy := FMMultivalueLink on: self opposite: #mapTarget:
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> sourceAccessorEntities [
	^( self sourceAccessors collect: [ :each | each from ] ) asSet asMooseGroup
]

{ #category : #'as yet unclassified' }
FAMIXRelationalEntity >> sourceAccessors [
	<MSEProperty: #sourceAccessors type: #FAMIXDBAccess opposite: #accessedEntity> <multivalued> <derived>
	<MSEComment: 'DB Access relationship.'>
	
	^sourceAccessors

]

{ #category : #querying }
FAMIXRelationalEntity >> userEntities [
	self subclassResponsibility 
]
