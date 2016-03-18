"
FAMIXSelectRequest corresponds to a select request.

    Instance Variables
	groupByClause:		<Object>
	havingClause:		<Object>
	orderByClause:		<Object>
	selectClause:		<Object>


    Implementation Points
"
Class {
	#name : #FAMIXSelectRequest,
	#superclass : #FAMIXRequest,
	#instVars : [
		'selectClause',
		'groupByClause',
		'havingClause',
		'orderByClause'
	],
	#category : #'Famix-SQL-Core'
}
