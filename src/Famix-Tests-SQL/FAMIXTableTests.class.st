Class {
	#name : #FAMIXTableTests,
	#superclass : #FAMIXRelationalEntityTests,
	#category : #'Famix-Tests-SQL'
}

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testAddColumn [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Table1']) first.

	self assert: (table3 isMemberOf: FAMIXTable).
	self assert: (table3 columns size = 3).
	
	table3 addColumn: (FAMIXColumn new name: #Column2).
					
	self assert: (table3 columns size = 4).
]

{ #category : #tests }
FAMIXTableTests >> testAnnotation [
	self assert: FAMIXTable annotation == FAMIXTable.
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testColumns [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Table1']) first.

	self assert: (table3 isMemberOf: FAMIXTable).
	self assert: (table3 columns size = 3).
	

]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testCreation [
	| tab |

	tab := FAMIXTable new name: 'Table1'.
	
	self assert: (tab isMemberOf: FAMIXTable).     
	self assert: (tab name = 'Table1').  
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testFKColumns [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.

	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	self assert: (assetGroup isMemberOf: FAMIXTable).
	self assert: (assetGroup fkColumns size = 0).
	
	self assert: (asset isMemberOf: FAMIXTable).
	self assert: (asset fkColumns size = 2).
	self assert: (asset fkColumns allSatisfy: [:col | col name = 'A_Asset_Group_ID' or: [col name = 'AD_User_ID']]).
	
	self assert: (user isMemberOf: FAMIXTable).
	self assert: (user fkColumns size = 0).
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testHasComposePK [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.

	self assert: (mooseModel allTables select: #hasComposePK) size = 2.
	
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	self assert: (asset isMemberOf: FAMIXTable).
	self assert: asset hasComposePK.
	
	self assert: (user isMemberOf: FAMIXTable).
	self assert: user hasComposePK.
	
	self assert: (assetGroup isMemberOf: FAMIXTable).
	self deny: assetGroup hasComposePK.
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testInUse [
	| mm table mapping maps class att1 att2 col1 col2 mapatt1 mapatt2 |
	
	mm := MooseModel new.
	table := FAMIXTable new name: #Table1.
	class := FAMIXClass new.
	att1 := FAMIXAttribute new.
	att2 := FAMIXAttribute new.
	col1 := FAMIXColumn new name: #col1.
	col2 := FAMIXColumn new name: #col2.
	
	mapping := FAMIXMapping new
		mapTarget: table;
		mapSource: class.
	
	mapatt1 := FAMIXMapping new
		mapTarget: col1;
		mapSource: att1.
		
	mapatt2 := FAMIXMapping new
		mapTarget: col2;
		mapSource: att2.
	
	class addMaps: mapping.
	table addMappedBy: mapping.
	
	mm add: class.
	mm add: table.
	mm add: att1.
	mm add: att2.
	mm add: col1.
	mm add: col2.
	mm add: mapping.
	mm add: mapatt1.
	mm add: mapatt2.

	self assert: (mm allColumns size = 2).
	
	maps := (mm allMaps select: [:each | each mapTarget isKindOf: FAMIXTable]).

	self assert: (maps size = 1).

	self assert: (maps anySatisfy: [:map | map mapTarget name = #Table1 and: [map mapTarget inUse]]).
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testNameAsRegex [
	| table |

	table := FAMIXTable new name: #col1.
	
	self assert: (table nameAsRegex isMemberOf: RxMatcher).
	self assert: (table nameAsRegex matches: #col1).
	self assert: (table nameAsRegex matches: 'asfdcol1asdf').
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testNameAsRegexIgnoringCase [
	| col |
	
	col := FAMIXTable new name: #col1.
	
	self assert: (col nameAsRegexIgnoringCase isMemberOf: RxMatcher).
	self assert: (col nameAsRegexIgnoringCase matches: #col1).
	self assert: (col nameAsRegexIgnoringCase matches: 'asfdcol1asdf').
	self assert: (col nameAsRegexIgnoringCase matches: 'asfdCOL1asdf').
	self assert: (col nameAsRegexIgnoringCase matches: #COL1).
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testNameWithAnnotationAsRegex [
	| jEETestModel mooseModel table1 |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.

	self assert: (mooseModel allTables size = 3).
	self assert: (table1 nameWithAnnotationAsRegex matches: jEETestModel fakeSourceText).
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testNumberOfColumns [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
		
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	self assert: (asset isMemberOf: FAMIXTable).
	self assert: asset numberOfColumns = 35.
	
	self assert: (user isMemberOf: FAMIXTable).
	self assert: user numberOfColumns = 30.
	
	self assert: (assetGroup isMemberOf: FAMIXTable).
	self assert: assetGroup numberOfColumns = 10.
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testNumberOfForeignKeys [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
		
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	self assert: (asset isMemberOf: FAMIXTable).
	self assert: asset numberOfForeignKeys = 2.
	
	self assert: (user isMemberOf: FAMIXTable).
	self assert: user numberOfForeignKeys = 0.
	
	self assert: (assetGroup isMemberOf: FAMIXTable).
	self assert: assetGroup numberOfForeignKeys = 0.
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testNumberOfPrimaryKeys [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
		
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	self assert: (asset isMemberOf: FAMIXTable).
	self assert: asset numberOfPrimaryKeys = 3.
	
	self assert: (user isMemberOf: FAMIXTable).
	self assert: user numberOfPrimaryKeys = 3.
	
	self assert: (assetGroup isMemberOf: FAMIXTable).
	self assert: assetGroup numberOfPrimaryKeys = 1.
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testOwnerDataBase [
	| database dbTable1 |

	dbTable1 := FAMIXTable new
			name: 'Table1'.
			
	self assert: (dbTable1 ownerDataBase = nil).
	
	database := (FAMIXDataBase new name: #database1).
	dbTable1 ownerDataBase: database.

	self assert: (dbTable1 ownerDataBase = database)
	

]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testPKColumns [
	| jEETestModel mooseModel asset user assetGroup |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingJustADB.
		
	asset := (mooseModel allTables select: [ :each | each name = 'A_Asset' ]) first.
	user := (mooseModel allTables select: [ :each | each name = 'AD_User' ]) first.
	assetGroup := (mooseModel allTables select: [ :each | each name = 'A_Asset_Group' ]) first.
	
	
	self assert: (assetGroup isMemberOf: FAMIXTable).
	self assert: (assetGroup pkColumns size = 1).
	
	self assert: (asset isMemberOf: FAMIXTable).
	self assert: (asset pkColumns size = 3).
	
	self assert: (user isMemberOf: FAMIXTable).
	self assert: (user pkColumns size = 3).
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testPrintOn [
	| tab stream |

	tab := FAMIXTable new name: 'Table1'.
	
	stream := ReadWriteStream on: ''.
	tab printOn: stream.
	
	self assert: (stream contents = (tab name asString , ' (Table)')).
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testSetColumns [
	| jEETestModel mooseModel table3 |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: FAMIXTable).
	self assert: (table3 columns size = 8).
	
	table3 columns: (Array with: (FAMIXColumn new name: #Column2) with: (FAMIXColumn new name: #Column1)) .
					
	self assert: (table3 columns size = 2).
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testViews [
	| table view assoc |

	table := FAMIXTable new.
	
	self assert: (table views isMemberOf: FMMultivalueLink).
	self assert: table views size equals: 0.
	
	view := FAMIXView new.
	
	self assert: (view ofTables isMemberOf: FMMultivalueLink).
	self assert: view ofTables size equals: 0.
	
	assoc := FAMIXViewToTableAssociation new
		table: table;
		view: view;
		yourself.
		
	self assert: assoc view equals: view.
	self assert: assoc table  equals: table.
	self assert: table views size equals: 1.
	self assert: table views first view equals: view.
	self assert: view ofTables size equals: 1.
	self assert: view ofTables first table equals: table.
	
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testViewsMoreViews [
	| table view assoc view2 assoc2 |

	table := FAMIXTable new.
	
	self assert: (table views isMemberOf: FMMultivalueLink).
	self assert: table views size equals: 0.
	
	view := FAMIXView new.
	
	self assert: (view ofTables isMemberOf: FMMultivalueLink).
	self assert: view ofTables size equals: 0.
	
	view2 := FAMIXView new.
	
	self assert: (view2 ofTables isMemberOf: FMMultivalueLink).
	self assert: view2 ofTables size equals: 0.
	
	assoc := FAMIXViewToTableAssociation new
		table: table;
		view: view;
		yourself.
	
	self assert: assoc view equals: view.
	self assert: assoc table  equals: table.
	
	assoc2 := FAMIXViewToTableAssociation new
		table: table;
		view: view2;
		yourself.
		
	self assert: assoc2 view equals: view2.
	self assert: assoc2 table  equals: table.
	
	self assert: table views size equals: 2.
	self assert: table views first view equals: view.
	self assert: table views second view equals: view2.
	
	self assert: view ofTables size equals: 1.
	self assert: view ofTables first table equals: table.
	
	self assert: view2 ofTables size equals: 1.
	self assert: view2 ofTables first table equals: table.
	
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testWithDeepReferencedByTables [	
	| jEETestModel mooseModel table3 tablesReferenceingTable3 |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: FAMIXTable).
	
	tablesReferenceingTable3 := table3 withDeepReferencedByTables.
	
	self assert: (tablesReferenceingTable3 size = 3).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab4']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab5']) first)]).
	    
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testWithDeepReferencedByTablesOnTwoLevels [	
	| jEETestModel mooseModel table1 tablesReferenceingTable3 |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table1 := (mooseModel allTables select: [:each | each name = 'Tab1']) first.

	self assert: (table1 isMemberOf: FAMIXTable).
	
	tablesReferenceingTable3 := table1 withDeepReferencedByTables.
	
	self assert: (tablesReferenceingTable3 size = 4).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab4']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab5']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab3']) first)]).
	self assert: (tablesReferenceingTable3 anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab1']) first)]).
	    
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testWithDeepReferencesTables [	
	| jEETestModel mooseModel table3 referencedTables |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table3 := (mooseModel allTables select: [:each | each name = 'Tab3']) first.

	self assert: (table3 isMemberOf: FAMIXTable).
	
	referencedTables := table3 withDeepReferencesTables.
	
	self assert: (referencedTables size = 3).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab1']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab2']) first)]).
	    
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testWithDeepReferencesTablesFromTablesWithoutReferencedTables [
	| jEETestModel mooseModel table1 referencedTables |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table1 := (mooseModel allTables select: [:each | each name = 'Tab1']) first.

	self assert: (table1 isMemberOf: FAMIXTable).
	
	referencedTables := table1 withDeepReferencesTables.
	
	self assert: (referencedTables size = 1).
	self assert: (referencedTables first = table1).
	    
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testWithDeepReferencesTablesFromTablesWithoutReferenceingTables [
	| jEETestModel mooseModel table5 referencedTables |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table5 := (mooseModel allTables select: [:each | each name = 'Tab5']) first.

	self assert: (table5 isMemberOf: FAMIXTable).
	
	referencedTables := table5 withDeepReferencedByTables.
	
	self assert: (referencedTables size = 1).
	self assert: (referencedTables first = table5).
	    
]

{ #category : #'as yet unclassified' }
FAMIXTableTests >> testWithDeepReferencesTablesOnTwoLevels [
	| jEETestModel mooseModel table5 referencedTables |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelContainingABiggerDB.

	table5 := (mooseModel allTables select: [:each | each name = 'Tab5']) first.

	self assert: (table5 isMemberOf: FAMIXTable).
	
	referencedTables := table5 withDeepReferencesTables.
	
	self assert: (referencedTables size = 4).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab1']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab2']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab3']) first)]).
	self assert: (referencedTables anySatisfy: [:table | table = ((mooseModel allTables select: [:each | each name = 'Tab5']) first)]).
	    
]
