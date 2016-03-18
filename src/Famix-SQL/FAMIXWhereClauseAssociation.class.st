Class {
	#name : #FAMIXWhereClauseAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'sourceRequest',
		'targetExpression'
	],
	#category : #'Famix-SQL-Associations'
}

{ #category : #accessing }
FAMIXWhereClauseAssociation >> from [

<MSEProperty: #sourceRequest type: #FAMIXRequest opposite: #whereClause>
	<MSEComment: 'Expression used in the where clause of the request'>
	^ sourceRequest 
]

{ #category : #accessing }
FAMIXWhereClauseAssociation >> sourceRequest [
<MSEProperty: #sourceRequest type: #FAMIXRequest opposite: #whereClause>
	<MSEComment: 'Expression used in the where clause of the request'>
	^ sourceRequest 
]

{ #category : #accessing }
FAMIXWhereClauseAssociation >> sourceRequest: aRelationalEntity [
	sourceRequest := FMMultivalueLink
		on: self
		update: #whereClause
		from: self sourceRequest
		to: aRelationalEntity
]

{ #category : #accessing }
FAMIXWhereClauseAssociation >> targetExpression [
	<MSEProperty: #targetExpression type: #FAMIXSQLExpression opposite: #appearingInWhereClause>
	<MSEComment: 'Expression referenced in a where clause.'>
	^ targetExpression
]

{ #category : #accessing }
FAMIXWhereClauseAssociation >> targetExpression: anObject [
	targetExpression := anObject
]
