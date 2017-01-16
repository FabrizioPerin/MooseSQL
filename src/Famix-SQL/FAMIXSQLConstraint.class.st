"
AFAMIXSQLConstraint corresponds to an sql constraint

    Instance Variables
	belongsTo:		Relational entity that owns this constraint.
	constraintName:		Name of the constraint
	expressionString:		<Object>
	fkColumns:		columns constituing to the foreign key
	fkReferencedTableName:		<Object>
	isCheckConstraint:		<Object>
	isFKConstraint:		<Object>
	isPKConstraint:		<Object>
	isUnique:		<Object>
	pkColumns:		<Object>
	uniqueColumns:		<Object>


    Implementation Points
"
Class {
	#name : #FAMIXSQLConstraint,
	#superclass : #FAMIXBehaviouralEntity,
	#instVars : [
		'isPKConstraint',
		'isFKConstraint',
		'fkReferencedTableName',
		'fkColumns',
		'pkColumns',
		'isUnique',
		'uniqueColumns',
		'isCheckConstraint',
		'expressionString',
		'constraintName',
		'belongsTo',
		'usedColumns',
		'usedFunctions',
		'expression'
	],
	#category : #'Famix-SQL-Core'
}

{ #category : #'as yet unclassified' }
FAMIXSQLConstraint class >> annotation [
	<MSEClass: #SQLConstraint super: #FAMIXEntity>
	<package: #FAMIX>
	^self
]

{ #category : #initialization }
FAMIXSQLConstraint >> addFKColumnName: aString [
	fkColumns ifNil: [ fkColumns := OrderedCollection new].
	fkColumns addLast: aString.
]

{ #category : #initialization }
FAMIXSQLConstraint >> addPKColumnName: aString [
	pkColumns ifNil: [ pkColumns := OrderedCollection new].
	pkColumns addLast: aString.
]

{ #category : #initialization }
FAMIXSQLConstraint >> addUniqueColumnName: aString [
	uniqueColumns ifNil: [ uniqueColumns := OrderedCollection new].
	uniqueColumns addLast: aString.
]

{ #category : #initialization }
FAMIXSQLConstraint >> belongsTo [
	<MSEProperty: #belongsTo type: #FAMIXRelationalEntity opposite: #constraints>
	<MSEComment: 'Relational entity that owns this constraint.'>
	
	^belongsTo
]

{ #category : #initialization }
FAMIXSQLConstraint >> belongsTo: aFAMIXRelationalEntityOrNil [
	belongsTo  := FMMultivalueLink 
		on: self
		update: #constraints
		from: self belongsTo
		to: aFAMIXRelationalEntityOrNil
]

{ #category : #accessing }
FAMIXSQLConstraint >> expression [
	<MSEProperty: #expression type: #FAMIXSQLExpression opposite: #calledByConstraint> 
	<MSEComment: 'Expression used by the constraint.'>
	^ expression
]

{ #category : #accessing }
FAMIXSQLConstraint >> expression: anObject [
	| old |
    old := expression.
    (old = anObject) ifFalse: [

        old ifNotNil: [
            expression := nil. "temporarily, to avoid infinite recursion"
            old calledByConstraint: nil ].
        expression := anObject.
        anObject ifNotNil: [anObject calledByConstraint: self]
    ]
]

{ #category : #accessing }
FAMIXSQLConstraint >> expressionString [
	^ expressionString
]

{ #category : #accessing }
FAMIXSQLConstraint >> expressionString: aString [
	expressionString := aString
]

{ #category : #initialization }
FAMIXSQLConstraint >> fkColumnNames [
	^fkColumns
]

{ #category : #accessing }
FAMIXSQLConstraint >> fkColumns: anObject [
	fkColumns := anObject
]

{ #category : #initialization }
FAMIXSQLConstraint >> initialize [
	super initialize.
	usedColumns := FMMultivalueLink on: self opposite: #constraint:.
	usedFunctions := FMMultivalueLink on: self opposite: #constraint:
	
]

{ #category : #accessing }
FAMIXSQLConstraint >> isCheck [
	<property: #isCheck>
	^ isCheckConstraint
]

{ #category : #accessing }
FAMIXSQLConstraint >> isCheck: aBoolean [
	isCheckConstraint := aBoolean
]

{ #category : #initialization }
FAMIXSQLConstraint >> isFKConstraint [
	<property: #isFKConstraint>
	^isFKConstraint
	
]

{ #category : #initialization }
FAMIXSQLConstraint >> isFKConstraint: aBoolean [
	isFKConstraint := aBoolean
	
]

{ #category : #initialization }
FAMIXSQLConstraint >> isPKConstraint [
	<property: #isPKConstraint>
	^isPKConstraint
	
]

{ #category : #initialization }
FAMIXSQLConstraint >> isPKConstraint: aBoolean [
	isPKConstraint := aBoolean
	
]

{ #category : #testing }
FAMIXSQLConstraint >> isSQLConstraint [
	^ true
]

{ #category : #accessing }
FAMIXSQLConstraint >> isUnique [
	<property: #isUnique>
	^ isUnique
]

{ #category : #accessing }
FAMIXSQLConstraint >> isUnique: anObject [
	isUnique := anObject
]

{ #category : #accessing }
FAMIXSQLConstraint >> name [
	^ constraintName
]

{ #category : #accessing }
FAMIXSQLConstraint >> name: aString [
	constraintName := aString
]

{ #category : #initialization }
FAMIXSQLConstraint >> parentSQLEntity [
	
	^belongsTo
]

{ #category : #initialization }
FAMIXSQLConstraint >> pkColumnNames [
	^pkColumns
]

{ #category : #initialization }
FAMIXSQLConstraint >> referencedTableName [
	^fkReferencedTableName
]

{ #category : #initialization }
FAMIXSQLConstraint >> referencedTableName: aString [
	fkReferencedTableName := aString.
]

{ #category : #initialization }
FAMIXSQLConstraint >> uniqueColumnNames [
	^uniqueColumns
]
