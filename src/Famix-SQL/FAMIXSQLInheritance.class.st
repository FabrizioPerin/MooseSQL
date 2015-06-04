"
A FAMIXSQLInheritance corresponds to the inheritance between tables
    Instance Variables
	childTable:		child table
	parentTable:		parent table


"
Class {
	#name : #FAMIXSQLInheritance,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'childTable',
		'parentTable'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #'as yet unclassified' }
FAMIXSQLInheritance class >> annotation [
	<MSEClass: #SQLInheritance super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXSQLInheritance >> childTable [
	<MSEProperty: #childTable type: #FAMIXTable opposite: #parentInheritance>
	<MSEComment: 'Child table linked to in this relationship. from-side of the association'>
	^ childTable
]

{ #category : #accessing }
FAMIXSQLInheritance >> childTable: anObject [
	childTable := anObject
]

{ #category : #accessing }
FAMIXSQLInheritance >> from [
	^ self childTable
]

{ #category : #'as yet unclassified' }
FAMIXSQLInheritance >> initialize [
	super initialize.
	childTable := nil.
	parentTable := nil.
]

{ #category : #accessing }
FAMIXSQLInheritance >> parentTable [
	<MSEProperty: #parentTable type: #FAMIXTable opposite: #childInheritances>
	<MSEComment: 'Parent table linked to in this relationship. to-side of the association'>
	^ parentTable
]

{ #category : #accessing }
FAMIXSQLInheritance >> parentTable: anObject [
	parentTable := anObject
]

{ #category : #accessing }
FAMIXSQLInheritance >> to [
	^ self parentTable
]
