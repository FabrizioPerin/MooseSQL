"
A FAMIXColumn corresponds to an SQL column

    Instance Variables
	canBeNull:		is true by default and false when the column has the constraint ""NOT NULL""
	defaultValueConstraint:		corresponds to the default value constraint
	indexes:		<Object>
	invokedFunctions:		function called to build the column
	referencedByFunctions: functions using the column in their creation 
	referencedByColumns : columns of views using the column in their creation
	usedColumns : columns used in the column creation (column (self) belongs to a view)
	referencedByFK: the column if a key referenced by a foreign key
	isFK:		is a foreign key
	isInherited:		is inherited when the table is inherited 
	isPK:		is a primary key
	isUnique:		corresponds to the unique constraint
	ownerTable:		corresponds to the table owning the table
	referencedBy:		functions referencing the given column
	type:		type of the column
	used:		<Object>


    Implementation Points
"
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
		'indexes',
		'defaultValueConstraint',
		'isInherited',
		'invokedFunctions',
		'referencedByFunctions',
		'referencedByColumns',
		'usedColumns',
		'referencedByFK',
		'usedPK',
		'referencedBy'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXColumn class >> annotation [
	<MSEClass: #Column super: #FAMIXRelationalEntity>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXColumn >> addDependencyIfNotExistFromColumn: aFAMIXColumn [ 
	aFAMIXColumn addDependencyIfNotExistToColumn: self
]

{ #category : #'as yet unclassified' }
FAMIXColumn >> addDependencyIfNotExistFromFunction: aFAMIXFunction [
	aFAMIXFunction addDependencyIfNotExistToColumn: self
]

{ #category : #'as yet unclassified' }
FAMIXColumn >> addDependencyIfNotExistTo: aFAMIXFunctionOrColumn [
	aFAMIXFunctionOrColumn addDependencyIfNotExistFromColumn: self
]

{ #category : #'as yet unclassified' }
FAMIXColumn >> addDependencyIfNotExistToColumn: aFAMIXColumn [ 
	FAMIXColumnAssociation new targetColumn: aFAMIXColumn ; sourceColumn: self; mooseModel: self mooseModel
]

{ #category : #'as yet unclassified' }
FAMIXColumn >> addDependencyIfNotExistToFunction: aFAMIXFunction [
	FAMIXFunctionCallFromColumnAssociation new targetFunction: aFAMIXFunction ; sourceColumn: self; mooseModel: self mooseModel
]

{ #category : #accessing }
FAMIXColumn >> addIndex:  aFAMIXSQLIndexing [
	indexes add: aFAMIXSQLIndexing
]

{ #category : #accessing }
FAMIXColumn >> belongsTo [
	<MSEProperty: #ownerTable type: #FAMIXTable opposite: #columns> <derived>
	<MSEComment: 'Table that owns this column. Should provides the implementation for belongsTo.'>
	
	
	
	^self ownerTable
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
FAMIXColumn >> defaultValueConstraint [
	<MSEProperty: #defaultValue type: #FAMIXDefaultValueConstraint opposite: #column> 
	<MSEComment: 'Default value constraint defined on this column.'>
	^ defaultValueConstraint
]

{ #category : #accessing }
FAMIXColumn >> defaultValueConstraint: aDefaultValueConstraint [
	defaultValueConstraint := aDefaultValueConstraint.
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
	
	isPK := false.
	isFK := false.
	isInherited := false.
	ownerTable := nil.
	type := nil.
	used := nil.
	isUnique := false.
	canBeNull := true.
	indexes := FMMultivalueLink on: self opposite: #column:.
	invokedFunctions := FMMultivalueLink on: self opposite: #sourceColumn:.
	usedColumns := FMMultivalueLink on: self opposite: #sourceColumn:.
	referencedByColumns := FMMultivalueLink on: self opposite: #targetColumn:.
	referencedByFunctions := FMMultivalueLink on: self opposite: #targetColumn:.
	referencedByFK := FMMultivalueLink on: self opposite: #targetColumn:.
	referencedBy := FMMultivalueLink on: self opposite: #targetColumn:.
	
	defaultValueConstraint := nil.
]

{ #category : #'as yet unclassified' }
FAMIXColumn >> invokedFunctions [

	<MSEProperty: #invokedFunctions type: #FAMIXFunctionCallFromColumnAssociation opposite: #sourceColumn> <multivalued> 
	<MSEComment: 'Functions called.'>
	
	^invokedFunctions
]

{ #category : #'as yet unclassified' }
FAMIXColumn >> invokedFunctions: aCollectionOfInvokedFunctions [
	invokedFunctions value: aCollectionOfInvokedFunctions 
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
FAMIXColumn >> isInherited [
	<MSEProperty: #isInherited type: #Boolean> 
	<MSEComment: 'This column is inherited from another table'>
	^ isInherited
]

{ #category : #accessing }
FAMIXColumn >> isInherited: anObject [
	isInherited := anObject
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
		aStream nextPutAll: '.'].
	aStream nextPutAll: self name.
	aStream nextPutAll: ' (Column)'.
]

{ #category : #accessing }
FAMIXColumn >> referencedByColumns [
	<MSEProperty: #referencedByColumns type: #FAMIXColumnAssociation opposite: #targetColumn>
	<MSEComment: 'Columns referencing the given column.'>
	^ referencedByColumns
]

{ #category : #accessing }
FAMIXColumn >> referencedByColumns: anObject [
	referencedByColumns := anObject
]

{ #category : #accessing }
FAMIXColumn >> referencedByFK [
	<MSEProperty: #referencedByFK type: #FAMIXFKAssociation opposite: #targetColumn>
	<MSEComment: 'FK referencing the given column.'>
	^ referencedByFK
]

{ #category : #accessing }
FAMIXColumn >> referencedByFK: anObject [
	referencedByFK := anObject
]

{ #category : #accessing }
FAMIXColumn >> referencedByFunctions [
	<MSEProperty: #referencedByFunctions type: #FAMIXColumnReference opposite: #targetColumn>
	<MSEComment: 'Functions referencing the column.'>
	^ referencedByFunctions
]

{ #category : #accessing }
FAMIXColumn >> referencedByFunctions: anObject [
	referencedByFunctions := anObject
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

{ #category : #accessing }
FAMIXColumn >> usedColumns [
	<MSEProperty: #usedColumns type: #FAMIXColumnAssociation opposite: #sourceColumn>
	<MSEComment: 'Column referenced by the given column.'>
	^ usedColumns
]

{ #category : #accessing }
FAMIXColumn >> usedColumns: anObject [
	usedColumns := anObject
]

{ #category : #accessing }
FAMIXColumn >> usedPK [
	<MSEProperty: #usedPK type: #FAMIXFKAssociation opposite: #sourceColumn>
	<MSEComment: 'Column referenced by the given column.'>
	^ usedPK
]

{ #category : #accessing }
FAMIXColumn >> usedPK: anObject [
	usedPK := anObject
]
