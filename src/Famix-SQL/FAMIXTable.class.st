"
A FAMIXTable corresponds to an sql table. 

    Instance Variables
	childInheritances:		inherited tables
	columns:		columns belonging to the table
	completeName:		<Object>
	consumerFunctions:		functions referencing the tables
	dataBase:		<Object>
	indexes:		<Object>
	nameAsRegEx:		<Object>
	nameAsRegExIgCa:		<Object>
	ownerDataBase:		<Object>
	parentInheritance:		<Object>
	triggers:		triggers built on the table
	used:		<Object>
	views:		views built using the table.


"
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
		'views',
		'childInheritances',
		'parentInheritance',
		'consumerFunctions',
		'triggers'
	],
	#category : #'Famix-SQL-Core'
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

{ #category : #'as yet unclassified' }
FAMIXTable >> addDependencyIfNotExistFrom: aFAMIXFunctionOrColumn [
	aFAMIXFunctionOrColumn addDependencyIfNotExistToTable: self
]

{ #category : #'as yet unclassified' }
FAMIXTable >> addDependencyIfNotExistFromFunction: aFAMIXSQLFunction [ 
	aFAMIXSQLFunction addDependencyIfNotExistToTable: self 
]

{ #category : #'as yet unclassified' }
FAMIXTable >> addDependencyIfNotExistFromTable: aFAMIXView [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FAMIXTable >> addDependencyIfNotExistFromTrigger: aFAMIXTrigger [ 
	aFAMIXTrigger ownerTable: self.
]

{ #category : #'as yet unclassified' }
FAMIXTable >> addDependencyIfNotExistFromView: aFAMIXView [ 
	aFAMIXView addDependencyIfNotExistToTable: self
]

{ #category : #'as yet unclassified' }
FAMIXTable >> addDependencyIfNotExistTo: aFAMIXTableOrFunction [ 
	aFAMIXTableOrFunction addDependencyIfNotExistFromTable: self.
]

{ #category : #accessing }
FAMIXTable >> addIndex: aSQLIndex [
	indexes add: aSQLIndex.
]

{ #category : #accessing }
FAMIXTable >> addTrigger: aFAMIXTrigger [
	triggers add: aFAMIXTrigger
]

{ #category : #accessing }
FAMIXTable >> belongsTo [
	<MSEProperty: #belongsTo type: #FAMIXDataBase> <derived>
	<MSEComment: 'Database containing the table'>
	

	^self ownerDataBase
]

{ #category : #accessing }
FAMIXTable >> childInheritances [
	<MSEProperty: #childInheritances type: #FAMIXSQLInheritance opposite: #parentTable> <multivalued> 
	<MSEComment: 'Subinheritance relationships, i.e. known children of this type.'>

	^ childInheritances
]

{ #category : #accessing }
FAMIXTable >> childInheritances: anObject [
	childInheritances := anObject
]

{ #category : #accessing }
FAMIXTable >> columns [
	<MSEProperty: #columns type: #FAMIXColumn opposite: #ownerTable> <multivalued>
	<MSEComment: 'Columns contained into this table.'>
	
	^columns
]

{ #category : #accessing }
FAMIXTable >> columns: aCollectionOfColumns [

	columns value: aCollectionOfColumns.
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

{ #category : #'accessing-computed' }
FAMIXTable >> computeDependentTables [
	| result |
	result := Set new.
	self columns do: [ :aColumn | 
		result addAll: (aColumn references collect: #targetTable) ].
	^ FAMIXTableGroup new addAll: result
]

{ #category : #accessing }
FAMIXTable >> consumerFunctions [
	<MSEProperty: #consumerFunctions type: #FAMIXFunctionToTableAssociation opposite: #table > <multivalued> 
	<MSEComment: 'List of Functions referencing the table.'>

	^ consumerFunctions
]

{ #category : #accessing }
FAMIXTable >> consumerFunctions: aCollection [
	consumerFunctions value: aCollection
]

{ #category : #querying }
FAMIXTable >> dependentEntities [
	^ self dependentTables asSet
]

{ #category : #'accessing-computed' }
FAMIXTable >> dependentTables [
	<navigation: #dependentTables>

	^self
		lookUpPropertyNamed: #dependentTables
		computedAs:
			[| result |
			result := Set new.
			self columns do: [ :aColumn | 
				result addAll: ((aColumn queryOutgoing: FAMIXColumnToColumnAssociation) atScope: FAMIXTable) ].
			FAMIXTableGroup new addAll: result]
]

{ #category : #testing }
FAMIXTable >> fkColumns [
	^self columns select: #isFK .   
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
	consumerFunctions := FMMultivalueLink 
					on: self
					opposite: #table:.
	triggers := FMMultivalueLink 
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
	childInheritances := FMNullMultivalueLink 
		on: self
		opposite: #parentTable:
		selector: #childInheritances.
	parentInheritance := nil.
]

{ #category : #testing }
FAMIXTable >> isTable [
	^ true
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
	<MSEProperty: #ownerDataBase type: #FAMIXDataBase opposite: #tables>
	<MSEComment: 'Database to which the table belongs to'>
	^ownerDataBase
]

{ #category : #accessing }
FAMIXTable >> ownerDataBase: aFAMIXDataBase [

	ownerDataBase := aFAMIXDataBase.
]

{ #category : #accessing }
FAMIXTable >> parentInheritance [
	<MSEProperty: #parentInheritance type: #FAMIXSQLInheritance opposite: #childTable>
	<MSEComment: 'parent Table linked to in this relationship. to-side of the association'>
	^ parentInheritance
]

{ #category : #accessing }
FAMIXTable >> parentInheritance: anObject [
	parentInheritance := anObject
]

{ #category : #testing }
FAMIXTable >> pkColumns [
	<MSEProperty: #pkColumns type: #FAMIXColumn> <multivalued> <derived>
	<MSEComment: 'Primary key columns of the table.'>
	^self columns select: #isPK .  
]

{ #category : #accessing }
FAMIXTable >> printOn: aStream [
	
	self completeName isNil
		ifFalse: [ aStream nextPutAll: self completeName ]
		ifTrue: [ self name isNil ifFalse: [ aStream nextPutAll: self name ] ].
	
	aStream nextPutAll: ' (Table)'
]

{ #category : #accessing }
FAMIXTable >> triggers [
	<MSEProperty: #triggers type: #FAMIXTrigger opposite: #ownerTable> <multivalued>
	<MSEComment: 'Triggers used by this table.'>
	^ triggers
]

{ #category : #accessing }
FAMIXTable >> triggers: aOrderedCollection. [
	triggers value: aOrderedCollection.
]

{ #category : #querying }
FAMIXTable >> userEntities [
	^ (self userTables , self userFunctions , self userTriggers , self userViews) asSet
]

{ #category : #'accessing-computed' }
FAMIXTable >> userFunctions [
	<navigation: #userFunctions>

	^self
		lookUpPropertyNamed: #userFunctions
		computedAs:
			[| result |
			result := Set new.
			self columns do: [ :aColumn | 
				result addAll: ((aColumn queryIncoming: FAMIXFunctionToColumnAssociation) atScope: FAMIXSQLFunction) ].
			
			result addAll: ((self queryIncoming: FAMIXFunctionToTableAssociation) atScope: FAMIXSQLFunction)]
]

{ #category : #'accessing-computed' }
FAMIXTable >> userTables [
	<navigation: #userTables>

	^self
		lookUpPropertyNamed: #userTables
		computedAs:
			[| result |
			result := Set new.
			"consider the user tables with columnToColumn association. One of the column of self is used either as a foreign key by another table or as a column in a view"
			self columns do: [ :aColumn | 
				result addAll: ((aColumn queryIncoming: FAMIXColumnToColumnAssociation) atScope: FAMIXTable) ].
			
			"consider the user tables with viewToTable association. The table is used in the from clause of the view definition"
			result addAll: ((self queryIncoming: FAMIXViewToTableAssociation) atScope: FAMIXView).
			
			FAMIXTableGroup new addAll: result]
]

{ #category : #'accessing-computed' }
FAMIXTable >> userTriggers [
<navigation: #userTriggers>

	^self
		lookUpPropertyNamed: #userTriggers
		computedAs: [self triggers]
]

{ #category : #'accessing-computed' }
FAMIXTable >> userViews [
<navigation: #userViews>

	^self
		lookUpPropertyNamed: #userViews
		computedAs: [self views collect: #view]
]

{ #category : #visualizations }
FAMIXTable >> viewDBTableOn: view [
	self deprecated: 'Use FAMIXTable>>#viewTableOn: instead'.
	self viewTableOn: view
]

{ #category : #'disabled-visualization' }
FAMIXTable >> viewDirectAccessors [
	"<menuItem: 'View Accessors' category: 'JEAs Visualizations'>"
	| aView |
	
	aView := RTMondrianViewBuilder new.
	self viewDirectAccessorsOn:  aView.
	aView open.
]

{ #category : #'disabled-visualization' }
FAMIXTable >> viewDirectAccessorsIn: composite [
	"<moosePresentationOrder: 264>"
	composite roassal2 
		title: 'Database accesses';
		"titleIcon: MooseJEEIcons jeeSystemComplexityWithColoredBorders;"
		painting: [ :view :each | each mooseInterestingEntity viewDirectAccessorsOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXTable ]
]

{ #category : #visualizations }
FAMIXTable >> viewDirectAccessorsOn: aView [

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

{ #category : #'disabled-visualization' }
FAMIXTable >> viewMappings [
	"<menuItem: 'View Mappings' category: 'JEAs Visualizations'>
	| aView |
	
	aView := ROMondrianViewBuilder new.
	self viewMappingsOn:  aView.
	aView open."
]

{ #category : #'disabled-visualization' }
FAMIXTable >> viewMappingsIn: composite [
	"<moosePresentationOrder: 264>"
	composite roassal2 
		title: 'Database mappings';
		"titleIcon: MooseJEEIcons jeeSystemComplexityWithColors;"
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

{ #category : #'disabled-visualization' }
FAMIXTable >> viewTable [
	"<menuItem: 'Table' category: 'JEAs Visualizations'> "
	
	| view |
	view := RTMondrianViewBuilder new.
	self viewTableOn: view.
	view root applyLayout.
	view open
]

{ #category : #visualizations }
FAMIXTable >> viewTableOn: view [

	view shape rectangle.
"	view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
"	view 
		node: self 
		forIt: [
			view shape rectangle.
			
			view 
				node: #table
				forIt: [
					view shape label text: #name.
					
					view node: self ].
				
			
			
			view 
				node: #columns 
				forIt: [
					view shape label text: #name; color: [ :col | 
						( col isPK notNil and: [ col isPK ] ) 
							ifTrue: [ Color blue ] 
							ifFalse: [ Color black ] ].
					
					view nodes: self columns.
					view layout verticalLine ].
	
			view layout verticalLine ]
]

{ #category : #'disabled-visualization' }
FAMIXTable >> viewTableUsage [
	"<menuItem: 'Table''s used elements' category: 'MooseJEE Visualizations'>" 
	
	"| view |
	view := MOViewRenderer new.
	self viewTableUsageOn: view.
	view open"
]

{ #category : #visualizations }
FAMIXTable >> viewTableUsageOn: view [
	view shape umlClassDiagramLikeForTable.
	view interaction popupText.
	view node: self.
]

{ #category : #metrics }
FAMIXTable >> views [
	<MSEProperty: #views type: #FAMIXViewToTableAssociation opposite: #table> <multivalued> 
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
		tablesReferenceTheCurentOne := (( result at: cursor ) columns flatCollect: [:each | each referencedByColumns]) collect: [:assoc | assoc sourceColumn ownerTable].
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
		tablesReferencedByTheCurrent := ((result at: cursor) columns flatCollect: #usedPK) collect: [:each | each targetColumn ownerTable].
		result addAll: ( tablesReferencedByTheCurrent reject: [ :each | result includes: each ] ).
		cursor := cursor + 1.
	].

	^ result.
]
