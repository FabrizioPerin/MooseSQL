"
A FAMIXSQLFunction corresponds to an integrated function. 

    Instance Variables
	referencedBy:		Entities referencing the given function
	referencedColumns:		columns referenced by the function
	referencedFunctions:		functions referenced by the function
	referencedTables:		Tables referenced by the function
	calledFromColumns: columns calling the function in their definition 
	calledFromFunctions: functions calling the function (self) in their definition
	calledFromTriggers: triggers calling the function
	sqlParameters:		formal parameters declared by this behaviour

"
Class {
	#name : #FAMIXSQLFunction,
	#superclass : #FAMIXBehaviouralEntity,
	#instVars : [
		'sqlParameters',
		'referencedBy',
		'referencedColumns',
		'referencedTables',
		'referencedFunctions',
		'calledFromColumns',
		'calledFromFunctions',
		'calledFromTriggers',
		'default'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'initialize-release' }
FAMIXSQLFunction class >> annotation [
	<MSEClass: #SQLFunction super: #FAMIXBehaviouralEntity>
	<package: #FAMIX>
	^self
]

{ #category : #'as yet unclassified' }
FAMIXSQLFunction >> addDependencyIfNotExistFromColumn: aFAMIXColumn [ 
	aFAMIXColumn addDependencyIfNotExistToFunction: self
]

{ #category : #'as yet unclassified' }
FAMIXSQLFunction >> addDependencyIfNotExistFromFunction: aFAMIXSQLFunction [ 
	aFAMIXSQLFunction addDependencyIfNotExistToFunction: self
]

{ #category : #'as yet unclassified' }
FAMIXSQLFunction >> addDependencyIfNotExistTo: aFAMIXSQLFunctionOrTableOrColumn [
	aFAMIXSQLFunctionOrTableOrColumn addDependencyIfNotExistFromFunction: self
]

{ #category : #'as yet unclassified' }
FAMIXSQLFunction >> addDependencyIfNotExistToColumn: aFAMIXColumn [ 
	FAMIXColumnReference new targetColumn: aFAMIXColumn ; sourceFunction: self; mooseModel: self mooseModel
]

{ #category : #'as yet unclassified' }
FAMIXSQLFunction >> addDependencyIfNotExistToFunction: aFAMIXSQLFunction [ 
	FAMIXFunctionCallFromFunctionAssociation new sourceFunction: self; targetFunction: aFAMIXSQLFunction; mooseModel: self mooseModel; yourself
]

{ #category : #'as yet unclassified' }
FAMIXSQLFunction >> addDependencyIfNotExistToTable: aFAMIXTable [ 
	FAMIXTableAssociation new table: aFAMIXTable ; function: self; mooseModel: self mooseModel
]

{ #category : #accessing }
FAMIXSQLFunction >> belongsTo [
	<MSEProperty: #ownerDataBase type: #FAMIXDataBase> <derived>
	<MSEComment: 'Database containing the table'>
	

	^self ownerDataBase
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromColumns [
	<MSEProperty: #calledFromColumns type: #FAMIXFunctionCallFromColumnAssociation  opposite: #targetFunction>
	<MSEComment: 'Column referencing the function.'>
	^ calledFromColumns
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromColumns: anObject [
	calledFromColumns := anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromFunctions [
	<MSEProperty: #calledFromFunctions type: #FAMIXFunctionCallFromFunctionAssociation  opposite: #targetFunction>
	<MSEComment: 'Functions referencing the function.'>
	^ calledFromFunctions
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromFunctions: anObject [
	calledFromFunctions := anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromTriggers [
	<MSEProperty: #calledFromTriggers type: #FAMIXTrigger opposite: #invokedFunction> <multivalued> 
	<MSEComment: 'Trigger calling the function.'>
	^ calledFromTriggers
]

{ #category : #accessing }
FAMIXSQLFunction >> calledFromTriggers: anObject [
	calledFromTriggers := anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> default [
	<MSEProperty: #default type: #FAMIXDefaultValueConstraint opposite: #function> 
	<MSEComment: 'Default constraint calling the SQL or pgpsql function'>
	^ default
]

{ #category : #accessing }
FAMIXSQLFunction >> default: anObject [
	default := anObject
]

{ #category : #'as yet unclassified' }
FAMIXSQLFunction >> initialize [
	super initialize.
	sqlParameters := FMMultivalueLink on: self opposite: #parentBehaviouralEntity:.
	referencedBy := FMMultivalueLink on: self opposite: #targetFunction:.
	referencedColumns := FMMultivalueLink on: self opposite: #sourceFunction:.
	referencedFunctions := FMMultivalueLink on: self opposite: #sourceFunction:.
	referencedTables := FMMultivalueLink on: self opposite: #function:.
	calledFromColumns := FMMultivalueLink on: self opposite: #targetFunction:.
	calledFromFunctions := FMMultivalueLink on: self opposite: #targetFunction:.
	calledFromTriggers := FMMultivalueLink on: self opposite: #invokedFunction:
]

{ #category : #accessing }
FAMIXSQLFunction >> isSQLFunction [
	^true
]

{ #category : #accessing }
FAMIXSQLFunction >> numberOfSQLParameters [
	<MSEProperty: #numberOfSQLParameters type: #Number>
	<MSEComment: 'The number of parameters in a function'>
	
	^self
		lookUpPropertyNamed: #numberOfSQLParameters
		computedAs: [self sqlParameters size]
]

{ #category : #accessing }
FAMIXSQLFunction >> ownerDataBase [
	<MSEProperty: #ownerDataBase type: #FAMIXDataBase> <derived>
	<MSEComment: 'Database containing the table'>
	

	^ownerDataBase
]

{ #category : #accessing }
FAMIXSQLFunction >> ownerDataBase: aDataBase [
	ownerDataBase:= aDataBase 
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedColumns [
	<MSEProperty: #referencedColumns type: #FAMIXColumnReference opposite: #sourceFunction> <multivalued> 
	<MSEComment: 'List of columns referenced by the function.'>
	^ referencedColumns
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedColumns: anObject [
	referencedColumns value: anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedFunctions [
	<MSEProperty: #referencedFunctions type: #FAMIXFunctionCallFromFunctionAssociation opposite: #sourceFunction> <multivalued> 
	<MSEComment: 'List of functions referenced by the function.'>
	^ referencedFunctions
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedFunctions: anObject [
	referencedFunctions value: anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedTables [
	<MSEProperty: #referencedTables type: #FAMIXTableAssociation opposite: #function > <multivalued> 
	<MSEComment: 'List of Tables referenced by the function.'>
	^ referencedTables
]

{ #category : #accessing }
FAMIXSQLFunction >> referencedTables: anObject [
	referencedTables value: anObject
]

{ #category : #accessing }
FAMIXSQLFunction >> sqlParameters [
	<MSEProperty: #sqlParameters type: #FAMIXEntity opposite: #parentBehaviouralEntity> <multivalued> 
	<MSEComment: 'List of formal parameters declared by this behaviour.'>
	
	^sqlParameters
]

{ #category : #accessing }
FAMIXSQLFunction >> sqlParameters: aCollOfSQLParameters [
	sqlParameters value: aCollOfSQLParameters 
]
