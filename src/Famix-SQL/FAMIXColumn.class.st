Class {
	#name : #FAMIXColumn,
	#superclass : #FAMIXRelationalEntity,
	#instVars : [
		'isPK',
		'isFK',
		'ownerTable',
		'type',
		'used',
		'isUnique',
		'canBeNull',
		'defaultValue',
		'indexes',
		'defaultValueConstraint'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXColumn class >> annotation [
	<MSEClass: #Column super: #FAMIXRelationalEntity>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXColumn >> addIndex:  aFAMIXSQLIndexing [
	indexes add: aFAMIXSQLIndexing
]

{ #category : #accessing }
FAMIXColumn >> canBeNull [
	<property: #canBeNull longName: 'Can Be Null' description:
			'This column can be null'>
	^ canBeNull
]

{ #category : #accessing }
FAMIXColumn >> canBeNull: anObject [
	canBeNull := anObject
]

{ #category : #accessing }
FAMIXColumn >> defaultValue [
	^ defaultValue
]

{ #category : #accessing }
FAMIXColumn >> defaultValue: wathever [ 
	defaultValue := wathever.
]

{ #category : #accessing }
FAMIXColumn >> defaultValueConstraint [
	<MSEProperty: #defaultValue type: #FAMIXDefaultValueConstraint opposite: #column> 
	<MSEComment: 'Default value constraint defined on this column.'>
	^ defaultValueConstraint
]

{ #category : #accessing }
FAMIXColumn >> defaultValueConstraint: aDefaultValueConstraint [
	defaultValueConstraint := aDefaultValueConstraint.
	aDefaultValueConstraint column: self.
]

{ #category : #accessing }
FAMIXColumn >> inUse [
	used isNil 
		ifTrue: [self inUse: self mappedNamedEntities isEmpty not].
	^used
]

{ #category : #accessing }
FAMIXColumn >> inUse: aBooleanOrNil [
	used := aBooleanOrNil.
]

{ #category : #accessing }
FAMIXColumn >> indexes [
	<MSEProperty: #indexes type: #FAMIXSQLIndexing opposite: #column> <multivalued> <derived>
	<MSEComment: 'Indexes defined on this column.'>
	
	^ indexes
]

{ #category : #accessing }
FAMIXColumn >> indexes:  aOrderedCollection [
	indexes value: aOrderedCollection.
]

{ #category : #accessing }
FAMIXColumn >> initialize [
	super initialize.
	
	isPK := nil.
	isFK := nil.
	ownerTable := nil.
	type := nil.
	used := nil.
	isUnique := nil.
	canBeNull := nil.
	indexes := FMMultivalueLink on: self opposite: #column:.
	defaultValueConstraint := nil.
]

{ #category : #testing }
FAMIXColumn >> isColumn [
	^true
]

{ #category : #accessing }
FAMIXColumn >> isFK [
	<MSEProperty: #isFK type: #Boolean> 
	<MSEComment: 'This column is foreign key from another table'>
	
	^isFK
]

{ #category : #accessing }
FAMIXColumn >> isFK: aBooleanOrNil [

	isFK := aBooleanOrNil.
]

{ #category : #accessing }
FAMIXColumn >> isPK [
	<MSEProperty: #isPK type: #Boolean> 
	<MSEComment: 'This column is a primary key'>
	^isPK
]

{ #category : #accessing }
FAMIXColumn >> isPK: aBooleanOrNil [

	isPK := aBooleanOrNil.
]

{ #category : #accessing }
FAMIXColumn >> isUnique [
	<property: #isUnique longName: 'is Unique' description:
			'The content of this column must be unique'>
	^ isUnique
]

{ #category : #accessing }
FAMIXColumn >> isUnique: anObject [
	isUnique := anObject
]

{ #category : #accessing }
FAMIXColumn >> ownerTable [
	<MSEProperty: #ownerTable type: #FAMIXTable opposite: #columns>
	<MSEComment: 'Table that owns this column. Should provides the implementation for belongsTo.'>
	
	"ownerTable isNil ifTrue: [
		ownerTable := self mooseModel allTables 
			detect: [:table | table columns anySatisfy: [:column | column = self]]
			ifNone: [nil]]."
	
	^ownerTable
]

{ #category : #accessing }
FAMIXColumn >> ownerTable: aFAMIXTableOrNil [
	ownerTable := FMMultivalueLink 
		on: self
		update: #columns
		from: self ownerTable
		to: aFAMIXTableOrNil
]

{ #category : #accessing }
FAMIXColumn >> printOn: aStream [
	| table |
	
	table := self ownerTable.
	table ifNotNil: [
		table mooseNameOn: aStream.
		aStream nextPutAll: '>>>'].
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Column)'.
]

{ #category : #accessing }
FAMIXColumn >> type [
	<property: #type longName: 'type' description:
			'Type of this column'>
	^type
]

{ #category : #accessing }
FAMIXColumn >> type: aString [
	type := aString
]
