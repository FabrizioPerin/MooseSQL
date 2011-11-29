Class {
	#name : #MooseSQLiteImporterTests,
	#superclass : #TestCase,
	#instVars : [
		'sqlASTParser',
		'targetModel',
		'tables',
		'columns'
	],
	#category : #'Moose-Tests-SQL-Importer'
}

{ #category : #models }
MooseSQLiteImporterTests >> stringWithACoupleOfTables [
	^'CREATE TABLE APPAB (ABFID NUMBER(10, 0) NOT NULL ENABLE, STEP NUMBER(10, 0) NOT NULL ENABLE, DIzID NUMBER(10, 0), START NUMBER(10, 0), STEPNAME VARCHAR2(64), NOID NUMBER(10, 0), AaS NUMBER(10, 0), ENTER NUMBER(10, 0), EXIT NUMBER(10, 0), RKID NUMBER(10, 0), NAME VARCHAR2(64), BEM3 NUMBER(10, 0), CONSTRAINT testName primary key (ABFID));
CREATE TABLE APP_ACCESS (EX_ID NUMBER(10, 0) NOT NULL ENABLE, ESPE NUMBER(10, 0) NOT NULL ENABLE, ESC_PED DATE NOT NULL ENABLE, ATT_CE VARCHAR2(50), ATT_CD DATE, ATT_TED NUMBER(1, 0), ATT_MD DATE, AT_CL VARCHAR2(4000), LNK_CREATOR NUMBER(10, 0), TLNK_CREATOR NUMBER(10, 0), LN_FIER NUMBER(10, 0), TL_FIER NUMBER(10, 0), ROL_OW NUMBER(10, 0))'
]

{ #category : #models }
MooseSQLiteImporterTests >> stringWithATableAndAnAlterTableRename [
	^'CREATE TABLE APPAB (ABFID NUMBER(10, 0) NOT NULL ENABLE, STEP NUMBER(10, 0) NOT NULL ENABLE, DIzID NUMBER(10, 0), START NUMBER(10, 0), STEPNAME VARCHAR2(64), NOID NUMBER(10, 0), AaS NUMBER(10, 0), ENTER NUMBER(10, 0), EXIT NUMBER(10, 0), RKID NUMBER(10, 0), NAME VARCHAR2(64), BEM3 NUMBER(10, 0), CONSTRAINT testName primary key (ABFID)); ALTER TABLE APPAB RENAME TO TESTTABLEname'
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testEnsureAColumn [
	| importer col famixCol |
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: nil.
	
	famixCol := importer ensureAColumn: col.
	
	self assert: (famixCol isMemberOf: FAMIXColumn).
	self assert: (famixCol name = #col1).
	self assert: (famixCol type = 'integer').
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testEnsureAColumnWithConstraints [
	| importer col famixCol const |
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	const := SQLColumnConstraintNode new
					defaultValue: 0;
					isPK: true;
					canBeNull: false;
					isUnique: nil.
					
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: const.
	
	famixCol := importer ensureAColumn: col.
	
	self assert: (famixCol isMemberOf: FAMIXColumn).
	self assert: (famixCol name = #col1).
	self assert: (famixCol type = 'integer').
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testEnsureATable [
	| importer tab famixTab |
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: #();
				constraints: #().
	
	famixTab := importer ensureATable: tab.
	
	self assert: (famixTab isMemberOf: FAMIXTable).
	self assert: (famixTab name = #tab1).

]

{ #category : #accessing }
MooseSQLiteImporterTests >> testEnsureATableWithColumns [
	| importer tab famixTab col |
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: nil.
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: (Array with: col);
				constraints: #().
	
	famixTab := importer ensureATable: tab.
	
	self assert: (famixTab isMemberOf: FAMIXTable).
	self assert: (famixTab name = #tab1).
	self assert: (famixTab columns size = 1).
	self assert: (famixTab columns first name = #col1).
	self assert: (famixTab columns first type = 'integer').
	
	  

]

{ #category : #accessing }
MooseSQLiteImporterTests >> testEnsureATableWithColumnsAndConstraints [
	| importer tab famixTab |
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: #();
				constraints: #().
	
	famixTab := importer ensureATable: tab.
	
	self assert: (famixTab isMemberOf: FAMIXTable).
	self assert: (famixTab name = #tab1).

]

{ #category : #accessing }
MooseSQLiteImporterTests >> testEnsureATableWithColumnsAndConstrant [
	| importer tab famixTab col const |
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: nil.
	
	const := SQLTableConstraintNode new
					isPKConstraint: true;
					addPKColumnName: #col1.
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: (Array with: col);
				constraints: (Array with: const).
	
	famixTab := importer ensureATable: tab.
	
	self assert: (famixTab isMemberOf: FAMIXTable).
	self assert: (famixTab name = #tab1).
	self assert: (famixTab columns size = 1).
	self assert: (famixTab columns first name = #col1).
	self assert: (famixTab columns first type = 'integer').
		
	self assert: (famixTab constraints first isPKConstraint).
	self assert: (famixTab constraints first pkColumnNames size = 1).
	self assert: (famixTab constraints first pkColumnNames first = #col1).
		

]

{ #category : #accessing }
MooseSQLiteImporterTests >> testImportSQLCreateScriptFromAStream [

	| importer populatedModel sqlScriptNodes sqlASTVisitor mm pkCol |
	
	mm := MooseModel new.
	
	importer := MooseSQLiteImporter new targetModel: mm.
	populatedModel := importer importSQLCreateScriptFrom: self stringWithACoupleOfTables.
	
	self assert: (populatedModel = mm).
	self assert: (populatedModel allTables size = 2).
	self assert: (populatedModel allColumns size = 25).
	
	pkCol := populatedModel allTables first columns select: [:each | each isPK isNil not and:[each isPK] ].
	
	self assert: (pkCol size = 1).
	self assert: (pkCol first name = 'ABFID').
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testImportSQLCreateScriptFromAStreamWithAlterTables [

	| importer populatedModel sqlScriptNodes sqlASTVisitor mm pkCol |
	
	mm := MooseModel new.
	
	importer := MooseSQLiteImporter new targetModel: mm.
	populatedModel := importer importSQLCreateScriptFrom: self stringWithATableAndAnAlterTableRename.
	
	self assert: (populatedModel = mm).
	self assert: (populatedModel allTables size = 1).
	self assert: (populatedModel allTables first name = 'TESTTABLEname').
	self assert: (populatedModel allColumns size = 12).
	
	pkCol := populatedModel allTables first columns select: [:each | each isPK isNil not and:[each isPK] ].
	
	self assert: (pkCol size = 1).
	self assert: (pkCol first name = 'ABFID').
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testReifyAnAlterTableStatementFromWithAnAlterTableFK [
	| importer tab col alterTab mm tab2 alterTabFK famixTab1 famixTab2 |
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: nil.	
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: (Array with: col);
				constraints: #().
				
	tab2 := SQLCreateTableStmtNode new 
				name: #tab2;
				columns: (Array with: (SQLColumnDefNode new 
											name: #col2;
											type: 'integer';
											constraints: nil));
				constraints: #().
				
	alterTab := SQLAlterTableStmtNode new
					isAddConstraint: true;
					nameOfTableToAlter: #tab1;
					addConstraint: (SQLTableConstraintNode new 
													isPKConstraint: true;
													addPKColumnName: #col1).
	alterTabFK := SQLAlterTableStmtNode new
					isAddConstraint: true;
					nameOfTableToAlter: #tab2;
					addConstraint: (SQLTableConstraintNode new 
													isFKConstraint: true;
													addPKColumnName: #col1;
													addFKColumnName: #col2;
													referencedTableName: #tab1).
					

	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	mm := importer populateTargetModelFrom: ((Array with: tab with: tab2 with: alterTab with: alterTabFK) collect: [:node | (node isKindOf: SQLASTNode) ifTrue: [ node accept: importer sqlASTVisitor]]).
	
	self assert: (mm allTables size = 2).  
	
	famixTab1 := mm allTables first.
	
	self assert: (famixTab1 isMemberOf: FAMIXTable).
	self assert: (famixTab1 name = #tab1).
	self assert: (famixTab1 columns size = 1).
	self assert: (famixTab1 columns first name = #col1).
	self assert: (famixTab1 columns first type = 'integer').
	self assert: (famixTab1 columns first isPK).
	
	famixTab2 := mm allTables second.
	
	self assert: (famixTab2 isMemberOf: FAMIXTable).
	self assert: (famixTab2 name = #tab2).
	self assert: (famixTab2 columns size = 1).
	self assert: (famixTab2 columns first name = #col2).
	self assert: (famixTab2 columns first type = 'integer').
	self assert: (famixTab2 columns first isFK).
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testReifyAnAlterTableStatementFromWithAnAlterTablePK [
	| importer tab famixTab col alterTab mm |
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	
	col := SQLColumnDefNode new 
				name: #col1;
				type: 'integer';
				constraints: nil.	
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: (Array with: col);
				constraints: #().
				
	alterTab := SQLAlterTableStmtNode new
					isAddConstraint: true;
					nameOfTableToAlter: #tab1;
					addConstraint: (SQLTableConstraintNode new 
													isPKConstraint: true;
													addPKColumnName: #col1).
					

	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	mm := importer populateTargetModelFrom: ((Array with: tab with: alterTab) collect: [:node | (node isKindOf: SQLASTNode) ifTrue: [ node accept: importer sqlASTVisitor]]).
	
	self assert: (mm allTables size = 1).  
	
	famixTab := mm allTables first.
	
	self assert: (famixTab isMemberOf: FAMIXTable).
	self assert: (famixTab name = #tab1).
	self assert: (famixTab columns size = 1).
	self assert: (famixTab columns first name = #col1).
	self assert: (famixTab columns first type = 'integer').
	self assert: (famixTab columns first isPK).
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testReifyAnAlterTableStatementFromWithAnAlterTableRename [
	
	| importer alterTabStmt tab famixTab mm |
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	
	alterTabStmt := SQLAlterTableStmtNode new 
				nameOfTableToAlter: #tab1;
				isRename: true;
				newTableName: #tab2.	
	
	tab := SQLCreateTableStmtNode new 
				name: #tab1;
				columns: #();
				constraints: #().
	
	famixTab := importer ensureATable: tab.
	
	self assert: (famixTab isMemberOf: FAMIXTable).
	self assert: (famixTab name = #tab1).
	
	importer :=  MooseSQLiteImporter new targetModel: MooseModel new.
	mm := importer populateTargetModelFrom: ((Array with: tab with: alterTabStmt) collect: [:node | (node isKindOf: SQLASTNode) ifTrue: [ node accept: importer sqlASTVisitor]]).
	
	self assert: (mm allTables size = 1).
	self assert: (mm allTables first name = #tab2).
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testSqlASTParser [
	
	| importer |
	importer := MooseSQLiteImporter new.

	self assert: (importer sqlASTParser isMemberOf: PetitSQLiteASTNodesParser).
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testSqlASTVisitor [
	
	| importer |
	importer := MooseSQLiteImporter new.

	self assert: (importer sqlASTVisitor isMemberOf: SQLASTConcreteVisitor).
]

{ #category : #accessing }
MooseSQLiteImporterTests >> testTargetModel [
	
	| mm importer |
	
	mm := MooseModel new.
	
	importer := MooseSQLiteImporter new targetModel: mm.
	
	self assert: (importer targetModel = mm).
]
