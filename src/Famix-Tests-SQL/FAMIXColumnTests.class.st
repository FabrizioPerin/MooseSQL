Class {
	#name : #FAMIXColumnTests,
	#superclass : #FAMIXRelationalEntityTests,
	#category : #'Famix-Tests-SQL'
}

{ #category : #tests }
FAMIXColumnTests >> testAnnotation [
	self assert: FAMIXColumn annotation == FAMIXColumn.
]

{ #category : #tests }
FAMIXColumnTests >> testCanBeNull [
	| col |

	col := FAMIXColumn new
					name: #Column2;
					canBeNull: true.
	
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
	self assert: col canBeNull.  
	
	col canBeNull: false.
	
	self deny: col canBeNull.
	
]

{ #category : #tests }
FAMIXColumnTests >> testCanBeNullFromAModel [
	| jEETestModel mooseModel table1 |

	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.
	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 3).
	
	self deny: ((table1 columns select: [:each | each name = #Column2 ]) first canBeNull).
	self deny: ((table1 columns select: [:each | each name = #Column2 ]) first canBeNull).
	self assert: ((table1 columns select: [:each | each name = #Column4 ]) first canBeNull).
	self deny: ((table1 columns select: [:each | each name = #Column6 ]) first canBeNull).
]

{ #category : #tests }
FAMIXColumnTests >> testCreation [
	| col |
	
	col := FAMIXColumn new
					name: #Column2..
					
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
]

{ #category : #tests }
FAMIXColumnTests >> testDefaultValue [
	| col |

	col := FAMIXColumn new
					name: #Column2.
	
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
	self assert: (col defaultValueConstraint isNil).  
	
	col defaultValueConstraint: (FAMIXDefaultValueConstraint new value:'isAString').
	
	self assert: col defaultValueConstraint value ='isAString'.
]

{ #category : #tests }
FAMIXColumnTests >> testInUse [
	| mm table mapping maps class att1 att2 col1 col2 mapatt1 mapatt2 |
	
	mm := MooseModel new.
	table := FAMIXTable new.
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
	mm add: mapatt1.
	mm add: mapatt2.


	
	self assert: mm allColumns size = 2.
	
	maps := mm allMaps select: [ :each | each mapTarget isKindOf: FAMIXColumn ].
	
	self assert: maps size = 2.
	
	self assert: (maps anySatisfy: [ :map | map mapTarget name = #col1 and: [ map mapTarget inUse ] ]).
	self assert: (maps anySatisfy: [ :map | map mapTarget name = #col2 and: [ map mapTarget inUse ] ]).
]

{ #category : #tests }
FAMIXColumnTests >> testIsFK [
	| col |

	col := FAMIXColumn new
					name: #Column2.
	
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
	self deny: (col isFK ).  
	
	col isFK: true.
	
	self assert: (col isFK).
]

{ #category : #tests }
FAMIXColumnTests >> testIsPK [
	| col |

	col := FAMIXColumn new
					name: #Column2.
	
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
	self deny: (col isPK).  
	
	col isPK: true.
	
	self assert: (col isPK).
]

{ #category : #tests }
FAMIXColumnTests >> testIsUnique [
	| col |

	col := FAMIXColumn new
					name: #Column2.
	
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
	self deny: (col isUnique).  
	
	col isUnique: true.
	
	self assert: (col isUnique).
]

{ #category : #tests }
FAMIXColumnTests >> testMJFAMIXColumnCreateAll [
	| col |

	col := FAMIXColumn new
					name: #Column2;
					isPK: true;
					isFK: false;
					ownerTable:  (FAMIXTable new name: #tab1);
					canBeNull: false;
					type: 'integer'.
	
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
	self assert: col isPK.
	self deny: col isFK.
	self deny: col canBeNull.
	self assert: (col type = 'integer').            
]

{ #category : #tests }
FAMIXColumnTests >> testMJFAMIXColumnCreation [
	| col |

	col := FAMIXColumn new name: #Column2.  
	
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
]

{ #category : #tests }
FAMIXColumnTests >> testOwnerTable [
	| jEETestModel mooseModel table1 |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 3).
	self assert: (table1 columns allSatisfy: [:column | column ownerTable = table1]).
]

{ #category : #tests }
FAMIXColumnTests >> testOwnerTableSetter [
	| jEETestModel mooseModel table1 |
	
	jEETestModel := FAMIXSQLTestResources new.
	mooseModel := jEETestModel sampleMooseModelWithDB.

	table1 := (mooseModel allTables select: [:each | each name = 'Table1']) first.
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 3).
	self assert: (table1 columns allSatisfy: [:column | column ownerTable = table1]).

	"Clean up the references with the table"
	(mooseModel allColumns select: [:column | column ownerTable = table1]) do: [:column | column ownerTable: nil].
	
	self assert: (mooseModel allColumns size = 6).
	self assert: (table1 columns size = 0).
	self assert: (mooseModel allColumns noneSatisfy: [:column | column ownerTable = table1]).
]

{ #category : #tests }
FAMIXColumnTests >> testPrintOn [
	| col stream |
	
	col := FAMIXColumn new
					name: #Column2..
					
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
	
	stream := ReadWriteStream on: ''.
	col printOn: stream.
	
	self assert: (stream contents = (col name asString , ' (Column)')).

]

{ #category : #tests }
FAMIXColumnTests >> testPrintOnWithTable [
	| col stream tab |
	
	col := FAMIXColumn new
					name: #Column2.
					
	tab := FAMIXTable new name: 'Table1'.
	
	col ownerTable: tab.
					
	self assert: (col isMemberOf: FAMIXColumn).
	self assert: (col name = #Column2).
	self assert: (col ownerTable = tab).

	stream := ReadWriteStream on: ''.
	col printOn: stream.
	
	self assert: (stream contents = (col ownerTable name asString , '>>>' , col name asString , ' (Column)')).

]
