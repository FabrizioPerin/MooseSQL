Extension { #name : #MooseModel }

{ #category : #'*famix-sql' }
MooseModel >> allColumns [
	<navigation: 'All Table Columns'>
	
	| group |
	
	
	group := self allWithType: FAMIXColumn ofGroupClass: FAMIXColumnGroup.
	group description: 'All Table Columns'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allDBAccesses [
	<navigation: 'All DB accessses'>

	| group |
	
	group :=  self allWithType: FAMIXDBAccess.
	group description: 'All DB accessses'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allDatabases [

	^self allWithType: FAMIXDataBase "asMetaDescription"
]

{ #category : #'*famix-sql' }
MooseModel >> allFKAssociations [
	<navigation: 'All FK associations'>

	| group |
	
	group :=  self allWithType: FAMIXFKAssociation ofGroupClass: FAMIXFKAssociationGroup.
	group description: 'All FK associations'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allIndexes [
	<navigation: 'All SQL Indexes'>
	
	| group |
		
	group := self allWithType: FAMIXSQLIndex ofGroupClass: FAMIXSQLIndexGroup.
	group description: 'All SQL Indexes'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allMaps [
	<navigation: 'All Maps'>

	| group |
	
	group :=  self allWithType: FAMIXMapping ofGroupClass: FAMIXMappingGroup.
	group description: 'All Maps'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allTables [
	<navigation: 'Data Base Tables'>
	
	| group |
	
	group :=  self allWithType: FAMIXTable ofGroupClass: FAMIXTableGroup.
	group description: 'Data Base Tables'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allViews [
	<navigation: 'Data Base Views'>
	
	| group |
	
	group :=  self allWithType: FAMIXView ofGroupClass: FAMIXViewGroup.
	group description: 'Data Base Views'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> cleanUpAllMaps [
	
	self silentlyRemoveAll: (self allWithType: FAMIXMapping).
	self allClasses do: [:class | class removePointersToMaps ].
	self allTables do: [:table | table removePointersToMaps ]
]

{ #category : #'*famix-sql' }
MooseModel >> cleanUpAllMapsGUI [
	<menuItem: 'Clean up all maps' category: 'JEAs Utilities'>
	
	|  question strategy |

	question := UITheme builder questionWithoutCancel: 'Do you want to clean up previously created maps?'.
	question ifTrue: [self cleanUpAllMaps].
]

{ #category : #'*famix-sql' }
MooseModel >> cleanUpDuplicatedMaps [
	<menuItem: 'Clean up duplicated maps' category: 'JEAs Utilities'>
	
	| maps toRemove |
	
	maps := self allMaps.
	toRemove := OrderedCollection new.
	
	(1 to: maps size)
		do: [ :firstMapIndex | 
			(firstMapIndex + 1 to: maps size)
				do: [ :secondMapIndex | 
					(maps at: firstMapIndex) mapSource = (maps at: secondMapIndex) mapSource
						ifTrue: [ 
							(maps at: firstMapIndex) mapTarget = (maps at: secondMapIndex) mapTarget
								ifTrue: [ toRemove add: (maps at: secondMapIndex) ] ] ] ].
					
	self silentlyRemoveAll: toRemove asSet
]
