Class {
	#name : #FAMIXTableGroup,
	#superclass : #MooseGroup,
	#category : #'Famix-SQL'
}

{ #category : #meta }
FAMIXTableGroup class >> annotation [
	<MSEClass: #TableGroup super: #MooseGroup>
	<package: #FAMIX>
	^ self
]

{ #category : #utilities }
FAMIXTableGroup >> computeDeriveDependenciesFromSourceCode [
	"This method compute derived dependencies considering the relations among software entities. 
	1- the algorithm cycle on all the tables;
	2- for each table we pick all the maps pointing to this table
	3- starting from this maps we build an invokation call graph and we pick up all the other maps that we can find
	4- finally we create a derived dependency amongs all the table that are involved in all the maps.
	
	Note: there is a condition that avoid the creation of multiple derived dependency among two classes.
	
	
	considering the invokation call graph starting from the classes on the of the classes we find all other maps that are involve and consequently all the table that are involved in potential relations"

	self do: [:table |
		| startingMaps invokingClasses allInterestingClasses interestingMaps tableToConnect |
		
		startingMaps := table mooseModel allMaps select: [:each | each to = table].
		
		invokingClasses := OrderedCollection new.
		startingMaps do: [:each |
			(each from isMemberOf: FAMIXClass) ifTrue: [invokingClasses addAll: each from withDeepInvokingClasses]].
		invokingClasses := invokingClasses asSet.
		
		allInterestingClasses := (invokingClasses flatCollect: [:class | class withDeepInvokedClasses]) asSet.
		
		"now that i have all tables i look for all the mapping that i am interest in"
		interestingMaps := (table mooseModel allMaps select: [:each | allInterestingClasses includes: each from]) asSet.
		
		tableToConnect := (interestingMaps collect: #mapTarget) asSet sorted: [:a :b | a name < b name].

		(1 to: tableToConnect size) do: [:rowIndex | 
			((rowIndex + 1) to: tableToConnect size) do: [:colIndex |
				(self mooseModel allDerivedDependencies anySatisfy: [:each | (each source = (tableToConnect at: rowIndex)) and: [(each target = (tableToConnect at: colIndex))]]) ifFalse: [ 
					| dep |
					dep := MJFAMIXDerivedDependency new isDirected: false.
					dep source: (tableToConnect at: rowIndex).
					dep target: (tableToConnect at: colIndex).
					dep rationale: 'Connection derived from connections among source code elements.'.
				
					(tableToConnect at: rowIndex) addOutgoingDerivedDependency: dep.
					(tableToConnect at: colIndex) addIncomingDerivedDependency: dep.
					self mooseModel silentlyAdd: dep]]]
	]
	
]

{ #category : #utilities }
FAMIXTableGroup >> levenshteinDistancesAmongFieldsTable [
	
	| aLevenshteinDistanceStrategy progr tableLeftGroup tableRightGroup result |
	
	tableLeftGroup := self asArray.
	tableRightGroup := self asArray.
	result := OrderedCollection new.
	aLevenshteinDistanceStrategy := DudeLevenshteinDistanceStrategy threshold: 2.
	progr := 1.
	
	UIManager default
		displayProgress: 'Computing levenshtein distances'
		at: Sensor cursorPoint
		from: 1 
		to: ((tableLeftGroup size * tableRightGroup size)/2) asInteger
		during: [ :bar | 
			bar value: progr.
			
			"these nested loops logically organize the table in a matrix and the computation is done on the whole matrix"
			(1 to: tableLeftGroup size) asArray do: [:rowIndex |
				| columnsPKGroup |
				
				columnsPKGroup := (tableLeftGroup at: rowIndex) columns select: [:col | col isPK notNil and: [col isPK] ].
				
				(1 to: tableRightGroup size) asArray do: [:colIndex |
					| distance columnsGroup |
					
					columnsGroup := ((tableRightGroup at: colIndex) columns reject: [:col | col isFK notNil and:[col isFK]]) reject:  [:col | col isPK notNil and: [col isPK] ].
					columnsPKGroup do: [:pk | 
						columnsGroup do: [:col |
							distance := aLevenshteinDistanceStrategy levenshteinDistanceSource: pk name target: col name.
							(distance < 4)  ifTrue: [
								| normalization |
								normalization := (distance asFloat / (pk name size max: col name size)).
								normalization < 0.43 ifTrue: [ 
									result add: (MalWeightedEdge new from: pk; to: col; weight: distance)]]]].
				progr := progr+1.
				bar value: progr]]].
	^result
]

{ #category : #views }
FAMIXTableGroup >> maximumNumberOfFKsPerClass [
	| max |
	
	max := 0.
	self do: [:table | (table fkColumns size > max) ifTrue: [max := table fkColumns size] ].
	
	^max
]

{ #category : #views }
FAMIXTableGroup >> maximumNumberOfPKsPerClass [
	| max |
	
	max := 0.
	self do: [:table | (table pkColumns size > max) ifTrue: [max := table pkColumns size] ].
	
	^max
]

{ #category : #accessing }
FAMIXTableGroup >> ranked [
	^(((PageRank new
	referenced: [:element |
		(element isMemberOf: FAMIXTable) ifTrue: [ element mappedNamedEntities] ifFalse: [
		(element isMemberOf: FAMIXClass) ifTrue: [ element clientClasses] ifFalse: [#()]]
		];
	runOn: self entities) associations 
	asSortedCollection: [ :a :b | a value >= b value ]) collect: [ :ea | ea ])
]

{ #category : #views }
FAMIXTableGroup >> viewDBTables [
	"<menuItem: 'View DB Tables' category: 'JEAs Visualizations'> "

	| view |
	view := MOViewRenderer new.
	self viewDBTablesOn: view.
	view open.
	
]

{ #category : #views }
FAMIXTableGroup >> viewDBTablesOn: view [
	
	view shape rectangle withoutBorder.
	view interaction nodraggable.
	view node: #tables forIt: [ 
		(self sorted: [:a :b | a name < b name ])  do: [:table | 
				table viewDBTableOn: view.].
			view gridLayout].
]

{ #category : #views }
FAMIXTableGroup >> viewTableRank [
	<menuItem: 'Table Rank' category: 'JEAs Visualizations'>
	| view |
	view := MOViewRenderer new.
	self viewTableRankOn: view.
	^ view openWithStatusbar title: 'Table Rank'
]

{ #category : #views }
FAMIXTableGroup >> viewTableRankOn: view [ 
	| objects |
	
	objects := self ranked.
	
	view shape label
		text: [:each | each key name , (each value integerPart asString , '.' , each value fractionPart asString asString sliceFrom: 1 to: 3 )].	
	view nodes: objects.
	
	view bottomFlowLayout maxWidth: 600
]

{ #category : #views }
FAMIXTableGroup >> viewTables [
	<menuItem: 'View Tables' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewTablesOn: view.
	view root applyLayout.
	view open.
	
]

{ #category : #views }
FAMIXTableGroup >> viewTablesFKs [
	<menuItem: 'View Tables with FK Relations' category: 'JEAs Visualizations'> 

	| view |
	view := MOViewRenderer new.
	self viewTablesFKsOn: view.
	view root applyLayout.
	view open.
	
]

{ #category : #views }
FAMIXTableGroup >> viewTablesFKsOn: view [
	
	view shape tableShape.
	view interaction nodraggable. 
	view interaction menuMorphBlock: [:each | each mooseMenuMorph ].  
	view nodes: self.

	view interaction nodraggable.
	view shape line color: Color lightGray.
	"view edges: self mooseModel allFKAssociations from: [:each | each sourceTable]  to: [:each | each targetTable].

	view shape line color: Color transparent."
	view edges: self mooseModel allFKAssociations from: [:each | each sourceColumn ownerTable ]  to: [:each | each targetColumn ownerTable].
	
	view horizontalTreeLayout  horizontalGap: 150.
]

{ #category : #views }
FAMIXTableGroup >> viewTablesOn: view [
	
	self do: [:table |
		table viewTableOn: view].
	view gridLayout.
]

{ #category : #views }
FAMIXTableGroup >> viewUMLTablesWithEJBeans [
	"<menuItem: 'Tables with Entity Beans UML class diagram' category: 'JEAs Visualizations'> "

	| view |
	view := MOViewRenderer new.
	self viewUMLTablesWithEJBeansOn: view.
	view open.
	
]

{ #category : #views }
FAMIXTableGroup >> viewUMLTablesWithEJBeansOn: view [
	
	| lonelyTables notLonelyTables |	
	
	lonelyTables := self reject: [:each | each inUse].
	notLonelyTables := self select: [:each | each inUse].
	
	notLonelyTables isEmpty ifFalse: [
		view interaction nodraggable.
		view shape rectangle withoutBorder.
		view node: #notLonelyTables forIt: [
			view interaction nodraggable.
			view shape rectangle withoutBorder.
			view nodes: notLonelyTables forEach: [:table |
						table mappedNamedEntities first implementedEntityBean viewUMLOfImplementorOn: view.
						table viewTableUsageOn: view.
						view shape line.
						view edges: table mooseModel allMaps from: #mapSource to: #mapTarget.
						view treeLayout.].
			view gridLayout]].

	lonelyTables isEmpty ifFalse: [
		view shape rectangle withoutBorder.
		view interaction nodraggable.
		view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
		view interaction popupText: [:group | 'Lonely Tables' ].
		view node: lonelyTables forIt: [
			view shape rectangle withoutBorder.
			view interaction menuMorphBlock: [ :each | each mooseMenuMorph ].
			view interaction nodraggable.
			view nodes: lonelyTables forEach: [:table | table viewTableUsageOn: view.]. "using: view shape umlClassDiagramLikeForTable."
			view flowLayout maxWidth: 600; gapSize: 2.
		]].

]
