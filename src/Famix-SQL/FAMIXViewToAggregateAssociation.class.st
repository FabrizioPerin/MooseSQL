"
A FAMIXViewToAggregateAssociation is the association representing a view using an aggregate.
"
Class {
	#name : #FAMIXViewToAggregateAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'view',
		'aggregate'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #meta }
FAMIXViewToAggregateAssociation class >> annotation [
	<MSEClass: #ViewToAggregateAssociation super: #FAMIXAssociation>
	<package: #SQL>
	^self
]

{ #category : #accessing }
FAMIXViewToAggregateAssociation >> aggregate [
	<MSEProperty: #aggregate type: #FAMIXAggregate opposite: #referencedByViews> 
	<MSEComment: 'Table on which the view is defined on'>
	^ aggregate
]

{ #category : #accessing }
FAMIXViewToAggregateAssociation >> aggregate: aFAMIXAggregate [
	aggregate := FMMultivalueLink 
						on: self
						update: #referencedByViews
						from: self aggregate
						to: aFAMIXAggregate
]

{ #category : #accessing }
FAMIXViewToAggregateAssociation >> from [
	<MSEProperty: #view type: #FAMIXView opposite: #usedAggregates>
	<MSEComment: 'View defined using the aggregate.'>
	^ view
]

{ #category : #accessing }
FAMIXViewToAggregateAssociation >> from: aView [
	self view: aView
]

{ #category : #printing }
FAMIXViewToAggregateAssociation >> printOnType [
	^' (View to Aggregate association)'
]

{ #category : #accessing }
FAMIXViewToAggregateAssociation >> to [
	<MSEProperty: #aggregate type: #FAMIXAggregate opposite: #referencedByViews> 
	<MSEComment: 'Table on which the view is defined on'>
	^ aggregate
]

{ #category : #accessing }
FAMIXViewToAggregateAssociation >> to: anAggregate [
	self aggregate: anAggregate
]

{ #category : #accessing }
FAMIXViewToAggregateAssociation >> view [
	<MSEProperty: #view type: #FAMIXView opposite: #usedAggregates>
	<MSEComment: 'View defined using the aggregate.'>
	^ view
]

{ #category : #accessing }
FAMIXViewToAggregateAssociation >> view: aFAMIXView [
	view := FMMultivalueLink 
					on: self
					update: #usedAggregates
					from: self view  
					to: aFAMIXView
]
