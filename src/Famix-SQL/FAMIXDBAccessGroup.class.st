Class {
	#name : #FAMIXDBAccessGroup,
	#superclass : #MooseGroup,
	#category : #'Famix-SQL'
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
FAMIXDBAccessGroup >> viewAccessesTypesPieChartOn: diag [

	| selects rest deletes updates inserts |

	selects := Dictionary new at: 'Selects' put: (self select: #isSelect); yourself.
	deletes := Dictionary new at: 'Deletes' put: (self select: #isDelete); yourself.
	updates := Dictionary new at: 'Updates' put: (self select: #isUpdate); yourself.
	inserts := Dictionary new at: 'Inserts' put: (self select: #isInsert); yourself.
	rest := Dictionary new at: 'Unknown' put: ((((self reject: #isSelect) reject: #isDelete) reject: #isUpdate) reject: #isInsert); yourself.
	
	(diag pieDiagram)
		radius: 200;
		models: ( Array with: selects with: deletes with: updates with: inserts with: rest );
		pieValue: [:model | model values first size];
		color: #yourself;
		displayLegend: true;
		legendTextBlock: [ :a | a keys first ];
		"verticalLegend;"
		useColors: ESAbstractDiagram lightColors;
		sortedAs: [ :a : b | a size < b size].
		
	diag interaction
"		strongHighlightWhenOver;"
		popupText: [:a | a values first size];
		menuMorphBlock: [:a | a values first mooseMenuMorph].

]
