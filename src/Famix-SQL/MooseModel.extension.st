Extension { #name : #MooseModel }

{ #category : #'*famix-sql' }
MooseModel >> allColumns [
	<navigation: 'Table Columns'>
	
	| group |
	
	
	group := self allWithType: FAMIXColumn ofGroupClass: FAMIXColumnGroup.
	group description: 'Table Columns'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allConstraints [
	<navigation: 'Default Constraints'>
	
	| group |
	
	
	group := self allWithType: FAMIXDefaultValueConstraint ofGroupClass: FAMIXSQLDefaultConstraintGroup.
	group description: 'Default Constraints'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allDBAccesses [
	<navigation: 'DB accesses'>

	| group |
	
	group :=  self allWithType: FAMIXDBAccess.
	group description: 'DB accesses'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allDatabases [

	^self allWithType: FAMIXDataBase "asMetaDescription"
]

{ #category : #'*famix-sql' }
MooseModel >> allFKAssociations [
	<navigation: 'FK associations'>

	| group |
	
	group :=  self allWithType: FAMIXFKAssociation ofGroupClass: FAMIXFKAssociationGroup.
	group description: 'FK associations'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allIndexes [
	<navigation: 'Data Base Indexes'>
	
	| group |
		
	group := self allWithType: FAMIXSQLIndex ofGroupClass: FAMIXSQLIndexGroup.
	group description: 'Data Base Indexes'.
	^group
]

{ #category : #'*famix-sql' }
MooseModel >> allMaps [
	<navigation: 'OR Maps'>

	| group |
	
	group :=  self allWithType: FAMIXMapping ofGroupClass: FAMIXMappingGroup.
	group description: 'OR Maps'.
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
