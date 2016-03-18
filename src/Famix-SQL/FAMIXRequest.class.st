"
FAMIXRequest is an abstract class representing a request.

    Instance Variables
	fromClause:		<Object>
	groupByClause:		<Object>
	havingClause:		<Object>
	orderByClause:		<Object>
	selectClause:		<Object>
	whereClause:		<Object>


    Implementation Points
"
Class {
	#name : #FAMIXRequest,
	#superclass : #FAMIXEntity,
	#instVars : [
		'whereClause',
		'fromClause',
		'usedInExpressions'
	],
	#category : #'Famix-SQL-Core'
}
