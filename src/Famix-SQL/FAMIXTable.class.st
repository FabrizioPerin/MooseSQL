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
		'completeName',
		'views'
	],
	#category : #'Famix-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXTable class >> annotation [
	<MSEClass: #Table super: #FAMIXRelationalEntity>
	<package: #FAMIX>
	^self
]

{ #category : #metrics }
FAMIXTable >> addAView: aFAMIXViewAssociation [
	self views add: aFAMIXViewAssociation
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
	completeName isNil 
		ifFalse:	[ ^completeName]
		ifTrue: [ ^name ]
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
	views := FMMultivalueLink 
					on: self 
					opposite: #table:.
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
	
	self completeName isNil
		ifFalse: [ aStream nextPutAll: self completeName ]
		ifTrue: [ self name isNil ifFalse: [ aStream nextPutAll: self name ] ].
	
	aStream nextPutAll: ' (Table)'
]

{ #category : #visualizations }
FAMIXTable >> viewAccessors [
	<menuItem: 'View Accessors' category: 'JEAs Visualizations'>
	| aView |
	
	aView := ROMondrianViewBuilder new.
	self viewAccessorsOn:  aView.
	aView open.
]

{ #category : #visualizations }
FAMIXTable >> viewAccessorsIn: composite [
	<moosePresentationOrder: 264>
	composite roassalWithoutInertia 
		title: 'Database accesses';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithColoredBorders;
		painting: [ :view :each | each mooseInterestingEntity viewAccessorsOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXTable ]
]

{ #category : #visualizations }
FAMIXTable >> viewAccessorsOn: aView [

	aView shape rectangle.
	aView node: self forIt: [
		aView shape label text:#name.
		aView node: self ].

	aView shape rectangle.
	aView nodes: self accessorSourceEntities asSet forEach: [ :node |
		aView shape label text:#name.
		aView node: node ].

	aView 
		edges: self mooseModel allDBAccesses
		from: #from
		to: #to.

	aView horizontalDominanceTreeLayout layered
]

{ #category : #visualizations }
FAMIXTable >> viewDBTableOn: view [
	self viewTableOn: view
]

{ #category : #visualizations }
FAMIXTable >> viewMappings [
	<menuItem: 'View Mappings' category: 'JEAs Visualizations'>
	| aView |
	
	aView := ROMondrianViewBuilder new.
	self viewMappingsOn:  aView.
	aView open.
]

{ #category : #visualizations }
FAMIXTable >> viewMappingsIn: composite [
	<moosePresentationOrder: 264>
	composite roassalWithoutInertia 
		title: 'Database mappings';
		titleIcon: MooseJEEIcons jeeSystemComplexityWithColors;
		painting: [ :view :each | each mooseInterestingEntity viewMappingsOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXTable ]
]

{ #category : #visualizations }
FAMIXTable >> viewMappingsOn: aView [

	aView shape rectangle.
	aView 
		node: self 
		forIt: [
			aView shape label text:#name.
			aView node: self ].

	aView shape rectangle.
	aView 
		nodes: self mappedNamedEntities asSet 
		forEach: [ :node |
			aView shape label text:#name.
			aView node: node ].

	aView 
		edges: self mooseModel allDBAccesses
		from: #from
		to: #to.

	aView horizontalDominanceTreeLayout layered
]

{ #category : #visualizations }
FAMIXTable >> viewTable [
	<menuItem: 'Table' category: 'JEAs Visualizations'> 
	
	| view |
	view := ROMondrianViewBuilder new.
	self viewTableOn: view.
	view root applyLayout.
	view open
]

{ #category : #visualizations }
FAMIXTable >> viewTableOn: view [

	view shape rectangle.
	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
	view 
		node: self 
		forIt: [
			view shape rectangle.
			view interaction nodraggable.
			view 
				node: #table
				forIt: [
					view shape label text: #name.
					view interaction nodraggable.
					view node: self ].
				
			view shape rectangleWithoutBorder.
			view interaction nodraggable.
			view 
				node: #columns 
				forIt: [
					view shape label text: #name.
					view shape fontColor: [ :col | 
						( col isPK notNil and: [ col isPK ] ) 
							ifTrue: [ Color blue ] 
							ifFalse: [ Color black ] ].
					view interaction nodraggable.
					view nodes: self columns.
					view verticalLineLayout gapSize: -3 ].
	
			view verticalLineLayout ]
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

{ #category : #metrics }
FAMIXTable >> views [
	<MSEProperty: #views type: #FAMIXViewAssociation opposite: #table> <multivalued> <derived>
	<MSEComment: 'views defined on this table'>
	^views
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
