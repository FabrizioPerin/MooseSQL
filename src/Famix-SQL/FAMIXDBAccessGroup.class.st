Class {
	#name : #FAMIXDBAccessGroup,
	#superclass : #MooseGroup,
	#category : #'Famix-SQL-Group'
}

{ #category : #'as yet unclassified' }
FAMIXDBAccessGroup class >> annotation [
	<MSEClass: #DBAccessGroup super: #MooseGroup>
	<package: #FAMIX>
	^ self
]

{ #category : #'as yet unclassified' }
FAMIXDBAccessGroup >> viewAccessesTypesPieChart [
	<menuItem: 'Types pie chart' category: 'JEAs Visualizations'>
	| diag |
	diag := ESDiagramRenderer new.
	self viewAccessesTypesPieChartOn: diag.		
	^ diag open
]

{ #category : #'as yet unclassified' }
FAMIXDBAccessGroup >> viewAccessesTypesPieChart2 [
	<menuItem: 'Types pie chart' category: 'JEAs Visualizations'>
	| diag |
	diag := RTPieBuilder new.
	self viewAccessesTypesPieChart2On: diag.		
	^ diag open
]

{ #category : #'as yet unclassified' }
FAMIXDBAccessGroup >> viewAccessesTypesPieChart2In: composite [
	<moosePresentationOrder: 276>

	composite roassal2
		title: 'Database accessor types'; 
		titleIcon: MooseJEEIcons pieChart;
		initializeView: [ RTPieBuilder new ];
		painting: [ :view | self viewAccessesTypesPieChart2On: view	].
	
]

{ #category : #'as yet unclassified' }
FAMIXDBAccessGroup >> viewAccessesTypesPieChart2On: diag [
	| selects rest deletes updates inserts diagLegend normalizer elements |
	
	selects := Dictionary new
		at: 'Selects' put: (self select: #isSelect);
		yourself.
	deletes := Dictionary new
		at: 'Deletes' put: (self select: #isDelete);
		yourself.
	updates := Dictionary new
		at: 'Updates' put: (self select: #isUpdate);
		yourself.
	inserts := Dictionary new
		at: 'Inserts' put: (self select: #isInsert);
		yourself.
	rest := Dictionary new
		at: 'Unknown' put: ((((self reject: #isSelect) reject: #isDelete) reject: #isUpdate) reject: #isInsert);
		yourself.

	elements := OrderedCollection
		with: selects
		with: deletes
		with: updates
		with: inserts.

	((rest at: 'Unknown') size > 0)
		ifTrue: [ elements add: rest ].	
		
	diag interaction popup.
	diag objects: elements.
	diag slice: [ :aDic | (aDic at: aDic keys first) size ].
	diag normalizer distinctColor.
	elements do: [ :el | diag emphasize: el by: 10. ].
	
	
	diagLegend := RTLegendBuilder new.
	diagLegend view: diag view.
	diagLegend addText: 'Database access types'.
	
	normalizer := RTMultiLinearColorForIdentity new objects: elements.
	
	elements
		do: [ :aDic | 
			diagLegend
				addColor: (normalizer rtValue: aDic)
				text:
					aDic keys first , ' ' , aDic values first size asString , '/' , self size asString , ' ('
						, ((aDic values first size / self size) asFloat * 100 round: 2) asString , '%)' ].
					
	diagLegend build.
	
	diag build.
	
	^ diag view
]

{ #category : #'as yet unclassified' }
FAMIXDBAccessGroup >> viewAccessesTypesPieChartIn: composite [
	<moosePresentationOrder: 275>
	composite eyesee
		title: 'Database accessor types';
		titleIcon: MooseJEEIcons pieChart;
		diagram: [ :view :each | each mooseInterestingEntity viewAccessesTypesPieChartOn: view ];
		when: [ :input | input mooseInterestingEntity isKindOf: FAMIXDBAccessGroup ]
]

{ #category : #'as yet unclassified' }
FAMIXDBAccessGroup >> viewAccessesTypesPieChartOn: diag [

	| selects rest deletes updates inserts |

	selects := Dictionary new at: 'Selects' put: (self select: #isSelect); yourself.
	deletes := Dictionary new at: 'Deletes' put: (self select: #isDelete); yourself.
	updates := Dictionary new at: 'Updates' put: (self select: #isUpdate); yourself.
	inserts := Dictionary new at: 'Inserts' put: (self select: #isInsert); yourself.
	rest := Dictionary new at: 'Unknown' put: ((((self reject: #isSelect) reject: #isDelete) reject: #isUpdate) reject: #isInsert); yourself.
	
	(diag pieDiagram)
		radius: 150;
		models: ( Array with: selects with: deletes with: updates with: inserts with: rest );
		color: #yourself;
		legendWidth: 16;
		displayLegend: true;
		verticalLegend;
		useColors: ESAbstractDiagram lightColors;
		pieValue: [:model | model values first size];
		legendTextBlock: [ :a | 
			a keys first , 
			' ' , 
			a values first size asString , '/' , self size asString,
			' (', (((a values first size / self size) asFloat *100) round: 2) asString , '%)' ];
		sortedAs: [ :a : b | a size < b size].
		
	diag interaction
"		strongHighlightWhenOver;"
		"popupText: [:a | a values first size];"
		menuMorphBlock: [:a | a values first mooseMenuMorph].

]
