Class {
	#name : #FAMIXTable,
	#superclass : #FAMIXRelationalEntity,
	#instVars : [
		'columns',
		'dataBase',
		'ownerDataBase',
		'nameAsRegExIgCa',
		'nameAsRegEx',
		'used',
		'indexes',
		'completeName'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXTable class >> annotation [
	<MSEClass: #Table super: #FAMIXRelationalEntity>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXTable >> addColumn: aFAMIXTablesColumn [
	columns add: aFAMIXTablesColumn.
]

{ #category : #accessing }
FAMIXTable >> addIndex: aSQLIndex [
	indexes add: aSQLIndex.
]

{ #category : #accessing }
FAMIXTable >> columns [
	<MSEProperty: #columns type: #FAMIXColumn opposite: #ownerTable> <multivalued> <derived>
	<MSEComment: 'Columns contained into this table.'>
	
	^columns
]

{ #category : #accessing }
FAMIXTable >> columns: aOrderedCollection [

	columns value: aOrderedCollection.
]

{ #category : #accessing }
FAMIXTable >> completeName [
	^ completeName
]

{ #category : #accessing }
FAMIXTable >> completeName: anObject [
	completeName := anObject
]

{ #category : #testing }
FAMIXTable >> fkColumns [
	^self columns select: [:column | column isFK notNil and: [column isFK]].  
]

{ #category : #testing }
FAMIXTable >> hasComposePK [
	^self pkColumns size > 1
]

{ #category : #accessing }
FAMIXTable >> inUse [
	used isNil 
		ifTrue: [self inUse: self mappedNamedEntities isEmpty not].
	^used
]

{ #category : #accessing }
FAMIXTable >> inUse: aBooleanOrNil [
	used := aBooleanOrNil.
]

{ #category : #accessing }
FAMIXTable >> indexes [
	<MSEProperty: #indexes type: #FAMIXSQLIndex opposite: #indexedTable> <multivalued> <derived>
	<MSEComment: 'SQL indexes defined on this table.'>
	
	^indexes
]

{ #category : #accessing }
FAMIXTable >> indexes: aOrderedCollection [

	indexes value: aOrderedCollection.
]

{ #category : #initialization }
FAMIXTable >> initialize [

	super initialize.
	columns := FMMultivalueLink 
		on: self
		opposite: #ownerTable:.
	ownerDataBase := nil.
	nameAsRegExIgCa := nil.
	nameAsRegEx := nil.
	indexes := FMMultivalueLink 
		on: self
		opposite: #indexedTable:.
]

{ #category : #accessing }
FAMIXTable >> name [
	^name
]

{ #category : #accessing }
FAMIXTable >> nameAsRegex [
	^nameAsRegEx isNil  
		ifTrue: [('.*', self name, '.*') asRegex]
		ifFalse: [nameAsRegEx]
]

{ #category : #accessing }
FAMIXTable >> nameAsRegexIgnoringCase [
	^nameAsRegExIgCa isNil 
		ifTrue: [('.*', self name, '.*') asRegexIgnoringCase]
		ifFalse: [nameAsRegExIgCa]
]

{ #category : #accessing }
FAMIXTable >> nameWithAnnotationAsRegex [
	^nameAsRegEx isNil  
		ifTrue: [nameAsRegEx := ('.*@Table\(name = "',self name,'".*') asRegex]
		ifFalse: [nameAsRegEx]
]

{ #category : #metrics }
FAMIXTable >> numberOfColumns [
	<property: #NOCol longName: 'Number of columns' description:
			'The number of columns defined for this tables including primary and foreign keys'>
	
	^columns size
]

{ #category : #metrics }
FAMIXTable >> numberOfForeignKeys [
	<property: #NOFK longName: 'Number of foreign keys' description:
			'The number of columns defined for this tables that are foreign keys'>
	
	^self fkColumns size
]

{ #category : #metrics }
FAMIXTable >> numberOfPrimaryKeys [
	<property: #NOPK longName: 'Number of primary keys' description:
			'The number of columns defined for this tables that are primary keys'>
	
	^self pkColumns size
]

{ #category : #accessing }
FAMIXTable >> ownerDataBase [

	^ownerDataBase
]

{ #category : #accessing }
FAMIXTable >> ownerDataBase: aFAMIXDataBase [

	ownerDataBase := aFAMIXDataBase.
]

{ #category : #testing }
FAMIXTable >> pkColumns [
	^self columns select: [:column | column isPK notNil and: [column isPK]].  
]

{ #category : #accessing }
FAMIXTable >> printOn: aStream [
	
	aStream nextPutAll: self completeName.
	aStream nextPutAll: ' (Table)'
]

{ #category : #visualizations }
FAMIXTable >> viewDBTableOn: view [
	view shape DBTableShape.
	view interaction popupText.
	view node: self.
]

{ #category : #visualizations }
FAMIXTable >> viewTable [
	<menuItem: 'Table' category: 'MooseJEE Visualizations'> 
	
	| view |
	view := MOViewRenderer new.
	self viewTableOn: view.
	view root applyLayout.
	view open
]

{ #category : #visualizations }
FAMIXTable >> viewTableOn: view [

	view shape tableShape.
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
	view interaction popupText.
	view node: self forIt: [
		view shape rectangle 
			withoutBorder; 
			text: [:col | col name];
			fontColor: [:col | 
				(col isPK notNil and:[col isPK]) 
				ifTrue: [Color blue] 
				ifFalse: [Color black]].
		view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
		view interaction popupText.
		view nodes: self columns.
		view verticalLineLayout. ].
]

{ #category : #visualizations }
FAMIXTable >> viewTableUsage [
	<menuItem: 'Table''s used elements' category: 'MooseJEE Visualizations'> 
	
	| view |
	view := MOViewRenderer new.
	self viewTableUsageOn: view.
	view open
]

{ #category : #visualizations }
FAMIXTable >> viewTableUsageOn: view [
	view shape umlClassDiagramLikeForTable.
	view interaction popupText.
	view node: self.
]

{ #category : #accessing }
FAMIXTable >> withDeepReferencedByTables [

	| cursor result tablesReferenceTheCurentOne |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.
	
	[cursor <= result size] whileTrue: [
		tablesReferenceTheCurentOne := (( result at: cursor ) columns flatCollect: [:each | each referencedBy]) collect: [:assoc | assoc sourceColumn ownerTable].
		result addAll: ( tablesReferenceTheCurentOne reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]

{ #category : #accessing }
FAMIXTable >> withDeepReferencesTables [

	| cursor result tablesReferencedByTheCurrent |

	cursor := 1.
	result := OrderedCollection new.
	result add: self.
	
	[cursor <= result size] whileTrue: [
		tablesReferencedByTheCurrent := ((result at: cursor) columns flatCollect: [:each | each references]) collect: [:each | each targetColumn ownerTable].
		result addAll: ( tablesReferencedByTheCurrent reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]
