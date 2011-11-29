Class {
	#name : #FAMIXSQLTestResources,
	#superclass : #Object,
	#category : #'Famix-Tests-SQL'
}

{ #category : #elements }
FAMIXSQLTestResources >> aTableThatReferencesItselfsThroughAForeignKey [

^'CREATE TABLE A_Asset(
    A_Asset_ID                   NUMBER(10, 0)      NOT NULL,
    AD_Client_ID                 NUMBER(10, 0)      NOT NULL,
    AD_Org_ID                    NUMBER(10, 0)      NOT NULL,
    Created                      DATE               DEFAULT SYSDATE NOT NULL,
    CreatedBy                    NUMBER(10, 0)      NOT NULL,
    Updated                      DATE               DEFAULT SYSDATE NOT NULL,
    UpdatedBy                    NUMBER(10, 0)      NOT NULL,
    Value                        NVARCHAR2(40)      NOT NULL,
    Name                         NVARCHAR2(60)      NOT NULL,
    Description                  NVARCHAR2(255),
    Help                         NVARCHAR2(2000),
    A_Asset_Group_ID             NUMBER(10, 0)      NOT NULL,
    Parent_Asset_ID              NUMBER(10, 0),
    M_Product_ID                 NUMBER(10, 0),
    M_AttributeSetInstance_ID    NUMBER(10, 0),
    C_UOM_ID                     NUMBER(10, 0),
    SerNo                        NVARCHAR2(40),
    Lot                          NVARCHAR2(40),
    VersionNo                    NVARCHAR2(40),
    GuaranteeDate                DATE               NOT NULL,
    AssetServiceDate             DATE               NOT NULL,
    AssetDisposalDate            DATE               NOT NULL,
    LocationComment              NVARCHAR2(255),
    M_Locator_ID                 NUMBER(10, 0),
    C_BPartner_ID                NUMBER(10, 0),
    C_BPartner_Location_ID       NUMBER(10, 0),
    AD_User_ID                   NUMBER(10, 0),
    C_Location_ID                NUMBER(10, 0),
    LastMaintenanceDate          DATE               NOT NULL,
    NextMaintenanceDate          DATE               NOT NULL,
    LastMaintenanceUseUnit       NUMBER             DEFAULT 0 NOT NULL,
    NextMaintenanceUseUnit       NUMBER             DEFAULT 0 NOT NULL,
    Lease_BPartner_ID            NUMBER(10, 0),
    LeaseTerminationDate         DATE               NOT NULL,
    Processing                   CHAR(1),
    CONSTRAINT A_Asset_Key PRIMARY KEY (A_Asset_ID)
);


ALTER TABLE A_Asset ADD CONSTRAINT AAsset_Parent 
    FOREIGN KEY (Parent_Asset_ID)
    REFERENCES A_Asset(A_Asset_ID);'

]

{ #category : #files }
FAMIXSQLTestResources >> fakeSourceText [

	^'import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
/**
 * @author roth_ch
 */

@Entity
@Table(name = "Table1", schema = "ESV")
public class WorkUnitAuthorization extends ActivityBaseBO {

  /**
   * The serialization version. Note that this changes with every version of this class!
   */
  private static final long serialVersionUID = "$Revision: 1.7 $".hashCode();
  /**
   * Excluded fields for equality compare.
   */
  private static final String[] EXCLUDED_FIELDS = { "workUnitAuthId", "version" };
  /**
   * technical primary key.
   */
  @Id
  @SequenceGenerator(name = "seqWothId", sequenceName = "ESV.SEQ_NAME", allocationSize = 1, initialValue = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seqWothId")
  @Column(name = "Column1")
  private Integer workUnitAuthId;

  // workunit operation
  @Column(name = "Column2")
  @Enumerated(EnumType.STRING)
  private WorkUnitAuthOperation Att1;

  // all & any conditions
  @Column(name = "Column3")
  private String allConditions;

  @Column(name = "Column4")
  private String Att2;

  // all & any conditions, operation conditions
  @Column(name = "Column5")
  private String allOperations;

  @Column(name = "Column6")
  private String Att3;

  @Column(name = "Column7")
  private String operationConditions;

  // all & any resources, resource conditions
  @Column(name = "Column8")
  private String allResources;

  @Column(name = "Column9")
  private String anyResources;

  @Column(name = "Column10")
  private String resourceConditions;'
]

{ #category : #files }
FAMIXSQLTestResources >> fakeSourceTextWithLowerCaseNames [

	^'import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
/**
 * @author roth_ch
 */

@Entity
@Table(name = "table1", schema = "ESV")
public class WorkUnitAuthorization extends ActivityBaseBO {

  /**
   * The serialization version. Note that this changes with every version of this class!
   */
  private static final long serialVersionUID = "$Revision: 1.7 $".hashCode();
  /**
   * Excluded fields for equality compare.
   */
  private static final String[] EXCLUDED_FIELDS = { "workUnitAuthId", "version" };
  /**
   * technical primary key.
   */
  @Id
  @SequenceGenerator(name = "seqWothId", sequenceName = "ESV.SEQ_NAME", allocationSize = 1, initialValue = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seqWothId")
  @Column(name = "Column1")
  private Integer workUnitAuthId;

  // workunit operation
  @Column(name = "column2")
  @Enumerated(EnumType.STRING)
  private WorkUnitAuthOperation Att1;

  // all & any conditions
  @Column(name = "Column3")
  private String allConditions;

  @Column(name = "Column4")
  private String Att2;

  // all & any conditions, operation conditions
  @Column(name = "column5")
  private String allOperations;

  @Column(name = "column6")
  private String Att3;

  @Column(name = "Column7")
  private String operationConditions;

  // all & any resources, resource conditions
  @Column(name = "Column8")
  private String allResources;

  @Column(name = "Column9")
  private String anyResources;

  @Column(name = "Column10")
  private String resourceConditions;'
]

{ #category : #files }
FAMIXSQLTestResources >> fakeSourceTextWithTable2 [

	^'import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
/**
 * @author roth_ch
 */

@Entity
@Table(name = "Table2", schema = "ESV")
public class WorkUnitAuthorization extends ActivityBaseBO {

  /**
   * The serialization version. Note that this changes with every version of this class!
   */
  private static final long serialVersionUID = "$Revision: 1.7 $".hashCode();
  /**
   * Excluded fields for equality compare.
   */
  private static final String[] EXCLUDED_FIELDS = { "workUnitAuthId", "version" };
  /**
   * technical primary key.
   */
  @Id
  @SequenceGenerator(name = "seqWothId", sequenceName = "ESV.SEQ_NAME", allocationSize = 1, initialValue = 1)
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seqWothId")
  @Column(name = "Column1")
  private Integer workUnitAuthId;

  // workunit operation
  @Column(name = "Column2")
  @Enumerated(EnumType.STRING)
  private WorkUnitAuthOperation Att1;

  // all & any conditions
  @Column(name = "Column3")
  private String allConditions;

  @Column(name = "Column4")
  private String Att2;

  // all & any conditions, operation conditions
  @Column(name = "Column5")
  private String allOperations;

  @Column(name = "Column6")
  private String Att3;

  @Column(name = "Column7")
  private String operationConditions;

  // all & any resources, resource conditions
  @Column(name = "Column8")
  private String allResources;

  @Column(name = "Column9")
  private String anyResources;

  @Column(name = "Column10")
  private String resourceConditions;'
]

{ #category : #elements }
FAMIXSQLTestResources >> fiveTablesConnectedThroughForeignKey [

^'CREATE TABLE Tab1(
    tab1_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab1_col1 NUMBER(10, 0) ,
   tab1_col2                   NUMBER(10, 0),
    tab1_col3                      DATE ,
    tab1_col4                    NVARCHAR2(255)      NOT NULL,
     tab1_col5                      CHAR(1) DEFAULT N);

CREATE TABLE Tab2(
    tab2_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab2_col1 NUMBER(10, 0)      NOT NULL,
   tab2_col2                   NUMBER(10, 0)      NOT NULL ,
    tab2_col3                      DATE                NOT NULL,
    tab2_col4                    NVARCHAR2(255)      NOT NULL,
     tab2_col5                      CHAR(1) DEFAULT N);

CREATE TABLE Tab3(
    tab3_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab3_col1 NUMBER(10, 0)      NOT NULL ,
   tab3_col2                   NUMBER(10, 0)    NOT NULL ,
    tab3_col3                      DATE           NOT NULL,
    tab3_col4                    NVARCHAR2(255)      NOT NULL,
     tab3_col5                      CHAR(1) DEFAULT N,
	tab3_tab1_FK NUMBER(10),
	tab3_tab2_FK NUMBER(10));

CREATE TABLE Tab4(
    tab4_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab4_col1 NUMBER(10, 0)      NOT NULL ,
   tab4_col2                   NUMBER(10, 0)      NOT NULL ,
    tab4_col3                      DATE                NOT NULL,
    tab4_col4                    NVARCHAR2(255)      NOT NULL,
     tab4_col5                      CHAR(1) DEFAULT N,
	tab4_tab3_FK NUMBER(10,0));

CREATE TABLE Tab5(
    tab5_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    tab5_col1 NUMBER(10, 0)      NOT NULL ,
   tab5_col2                   NUMBER(10, 0)      NOT NULL ,
    tab5_col3                      DATE                NOT NULL,
    tab5_col4                    NVARCHAR2(255)     NOT NULL,
     tab5_col5                      CHAR(1) DEFAULT N,
	tab5_tab3_FK NUMBER(10,0));


ALTER TABLE Tab3 ADD CONSTRAINT tab1_to_tab3
    FOREIGN KEY (tab3_tab1_FK)
    REFERENCES Tab1(tab1_ID);

ALTER TABLE Tab3 ADD CONSTRAINT tab2_to_tab3
    FOREIGN KEY (tab3_tab2_FK)
    REFERENCES Tab2(tab2_ID);

ALTER TABLE Tab4 ADD CONSTRAINT tab3_to_tab4
    FOREIGN KEY (tab4_tab3_FK)
    REFERENCES Tab3(tab3_ID);

ALTER TABLE Tab5 ADD CONSTRAINT tab3_to_tab5
    FOREIGN KEY (tab5_tab3_FK)
    REFERENCES Tab3(tab3_ID)'

]

{ #category : #elements }
FAMIXSQLTestResources >> fiveTablesConnectedThroughForeignKeysMSE [

^'(
	(FAMIX.Table (id: 1)
		(name ''Tab1''))
	(FAMIX.Column (id: 2)
		(name ''tab2_ID'')
		(isPK true)
		(ownerTable (ref: 3)))
	(FAMIX.Column (id: 4)
		(name ''tab5_col2'')
		(ownerTable (ref: 5)))
	(FAMIX.Column (id: 6)
		(name ''tab2_col5'')
		(ownerTable (ref: 3)))
	(FAMIX.Column (id: 7)
		(name ''tab4_col4'')
		(ownerTable (ref: 8)))
	(FAMIX.Column (id: 9)
		(name ''tab5_col5'')
		(ownerTable (ref: 5)))
	(FAMIX.Column (id: 10)
		(name ''tab1_col3'')
		(ownerTable (ref: 1)))
	(FAMIX.Table (id: 8)
		(name ''Tab4''))
	(FAMIX.Column (id: 11)
		(name ''tab3_col2'')
		(ownerTable (ref: 12)))
	(FAMIX.Column (id: 13)
		(name ''tab3_tab2_FK'')
		(isFK true)
		(ownerTable (ref: 12)))
	(FAMIX.Table (id: 5)
		(name ''Tab5''))
	(FAMIX.Column (id: 14)
		(name ''tab5_col1'')
		(ownerTable (ref: 5)))
	(FAMIX.Column (id: 15)
		(name ''tab2_col4'')
		(ownerTable (ref: 3)))
	(FAMIX.Column (id: 16)
		(name ''tab4_col3'')
		(ownerTable (ref: 8)))
	(FAMIX.SQLConstraint (id: 17)
		(belongsTo (ref: 8)))
	(FAMIX.SQLConstraint (id: 18)
		(belongsTo (ref: 5)))
	(FAMIX.Column (id: 19)
		(name ''tab1_col2'')
		(ownerTable (ref: 1)))
	(FAMIX.Table (id: 3)
		(name ''Tab2''))
	(FAMIX.Column (id: 20)
		(name ''tab5_col4'')
		(ownerTable (ref: 5)))
	(FAMIX.Column (id: 21)
		(name ''tab3_col1'')
		(ownerTable (ref: 12)))
	(FAMIX.Column (id: 22)
		(name ''tab3_tab1_FK'')
		(isFK true)
		(ownerTable (ref: 12)))
	(FAMIX.Column (id: 23)
		(name ''tab5_ID'')
		(isPK true)
		(ownerTable (ref: 5)))
	(FAMIX.Column (id: 24)
		(name ''tab2_col3'')
		(ownerTable (ref: 3)))
	(FAMIX.Column (id: 25)
		(name ''tab4_col2'')
		(ownerTable (ref: 8)))
	(FAMIX.Column (id: 26)
		(name ''tab1_col1'')
		(ownerTable (ref: 1)))
	(FAMIX.FKAssociation (id: 27)
		(sourceColumn (ref: 28))
		(targetColumn (ref: 29)))
	(FAMIX.Column (id: 29)
		(name ''tab3_ID'')
		(isPK true)
		(ownerTable (ref: 12)))
	(FAMIX.Column (id: 30)
		(name ''tab3_col5'')
		(ownerTable (ref: 12)))
	(FAMIX.Column (id: 31)
		(name ''tab2_col2'')
		(ownerTable (ref: 3)))
	(FAMIX.Table (id: 12)
		(name ''Tab3''))
	(FAMIX.Column (id: 32)
		(name ''tab4_col1'')
		(ownerTable (ref: 8)))
	(FAMIX.Column (id: 28)
		(name ''tab4_tab3_FK'')
		(isFK true)
		(ownerTable (ref: 8)))
	(FAMIX.FKAssociation (id: 33)
		(sourceColumn (ref: 34))
		(targetColumn (ref: 29)))
	(FAMIX.Column (id: 35)
		(name ''tab1_ID'')
		(isPK true)
		(ownerTable (ref: 1)))
	(FAMIX.Column (id: 36)
		(name ''tab1_col5'')
		(ownerTable (ref: 1)))
	(FAMIX.SQLConstraint (id: 37)
		(belongsTo (ref: 12)))
	(FAMIX.SQLConstraint (id: 38)
		(belongsTo (ref: 12)))
	(FAMIX.Column (id: 39)
		(name ''tab3_col4'')
		(ownerTable (ref: 12)))
	(FAMIX.FKAssociation (id: 40)
		(sourceColumn (ref: 22))
		(targetColumn (ref: 35)))
	(FAMIX.FKAssociation (id: 41)
		(sourceColumn (ref: 13))
		(targetColumn (ref: 2)))
	(FAMIX.Column (id: 42)
		(name ''tab2_col1'')
		(ownerTable (ref: 3)))
	(FAMIX.Column (id: 43)
		(name ''tab5_col3'')
		(ownerTable (ref: 5)))
	(FAMIX.Column (id: 44)
		(name ''tab4_ID'')
		(isPK true)
		(ownerTable (ref: 8)))
	(FAMIX.Column (id: 45)
		(name ''tab4_col5'')
		(ownerTable (ref: 8)))
	(FAMIX.Column (id: 46)
		(name ''tab1_col4'')
		(ownerTable (ref: 1)))
	(FAMIX.Column (id: 34)
		(name ''tab5_tab3_FK'')
		(isFK true)
		(ownerTable (ref: 5)))
	(FAMIX.Column (id: 47)
		(name ''tab3_col3'')
		(ownerTable (ref: 12))))'
]

{ #category : #models }
FAMIXSQLTestResources >> sampleMooseModelContainingABiggerDB [
	
	| mooseModel importer |

	mooseModel := MooseModel new.
	mooseModel name: 'testDataBase'.
	
	mooseModel importFromMSEStream: self fiveTablesConnectedThroughForeignKeysMSE readStream.
	
	"PPParserResource reset.
	importer := MooseSQLiteImporter on: mooseModel.
	mooseModel := importer importSQLCreateScriptFrom: self fiveTablesConnectedThroughForeignKey."

	^mooseModel
]

{ #category : #models }
FAMIXSQLTestResources >> sampleMooseModelContainingJustADB [
	
	| mooseModel importer |

	mooseModel := MooseModel new.
	mooseModel name: 'testDataBase'.
	
	mooseModel importFromMSEStream: self threeTablesConnectedThroughForeignKeysMSE readStream.
	
	"use the following three lines to generate the model with the database from the SQL script"
	"PPParserResource reset.	
	importer := MJSQLImporterFromVisitor on: mooseModel.
	mooseModel := importer importSQLCreateScriptFrom: self threeTablesConnectedThroughForeignKey.
	self halt."
	^mooseModel.
	
	
]

{ #category : #models }
FAMIXSQLTestResources >> sampleMooseModelWithDB [
	
	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean database dbTable1 dbTable2 dbTable3 tableColumn1 tableColumn2 tableColumn3 tableColumn5 tableColumn6 tableColumn4 acmpEntity |
	mooseModel := MooseModel new.
	aPackage := FAMIXNamespace new
			name: #aPackage;
			yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aStatelessSessionBean addMethod: (FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				signature: #aMethod asString;
				yourself
			);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				signature: #anotherMethod asString;
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.
	aStatefulSessionBean
			addMethod: (FAMIXMethod new
				name: #someMethod;
				parentType: aStatefulSessionBean;
				signature: #someMethod asString;
				yourself
			);
			addMethod: (FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				signature: #someOtherMethod asString;
				yourself
			).
	
	acmpEntity := FAMIXClass new
			name: #ACMPEntityBean;
			container: anotherPackage;
			yourself.
	
	acmpEntity 
		addAttribute: (FAMIXAttribute new 
			name: 'Att1';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		);
		addAttribute: (FAMIXAttribute new 
			name: 'Att2';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		);
		addAttribute: (FAMIXAttribute new 
			name: 'Att3';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		);
		addAttribute: (FAMIXAttribute new 
			name: 'Att4';
			parentType: acmpEntity;
			hasClassScope: true;
			yourself
		).

	
	"instanciating relational elements"
	database := FAMIXDataBase new name: #database1.

	dbTable1 := FAMIXTable new
			name: 'Table1';
			ownerDataBase: database.
	
	dbTable2 := FAMIXTable new
			name: 'Table2';
			ownerDataBase: database.

	dbTable3 := FAMIXTable new
			name: 'Table3';
			ownerDataBase: database.

	tableColumn1 := FAMIXColumn new
						name: #Column2;
						isPK: true;
						isFK: false;
						ownerTable:  dbTable1;
						canBeNull: false;
						type: 'integer'.
	
	tableColumn2 := FAMIXColumn new
						name: #Column4;
						isPK: false;
						isFK: false;
						ownerTable:  dbTable1;
						canBeNull: true;
						isUnique: true;
						type: 'string'.
	
	tableColumn3 := FAMIXColumn new
						name: #Column6;
						isPK: false;
						isFK: false;
						ownerTable:  dbTable1;
						canBeNull: false;
						isUnique: false;
						type: 'integer'.
						
	dbTable1 addColumn: tableColumn1.
	dbTable1 addColumn: tableColumn2.
	dbTable1 addColumn: tableColumn3.
	
	
	tableColumn4 := FAMIXColumn new
						name: #Column1;
						isPK: true;
						isFK: false;
						ownerTable:  dbTable2;
						type: 'integer'.
	
	tableColumn5 := FAMIXColumn new
						name: #Column3;
						isPK: false;
						isFK: true;
						ownerTable:  dbTable2;
						type: 'integer'.
	
	dbTable2 addColumn: tableColumn4.
	dbTable2 addColumn: tableColumn5.
						
	tableColumn6 := FAMIXColumn new
						name: #Column5;
						isPK: true;
						isFK: false;
						ownerTable:  dbTable3;
						type: 'integer'.
	
	dbTable3 addColumn: tableColumn6.

	database addTable: dbTable1.
 	database addTable: dbTable2.
	database addTable: dbTable3.
		
	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		add: aPackage;
		add: anotherPackage;
		add: (FAMIXClass new
			name: #AStatelessSessionHome;
			container: aPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AStatelessSession;
			container: aPackage;
			yourself
		);
		add: aStatelessSessionBean;
		add: (FAMIXClass new
			name: #AStatefulSessionHome;
			container: aPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AStatefulSession;
			container: aPackage;
			yourself
		);
		add: aStatefulSessionBean;
		add: (FAMIXClass new
			name: #ACMPEntityHome;
			container: anotherPackage;
			yourself
		);
		add: acmpEntity;
		addAll: acmpEntity attributes; 
		add: (FAMIXClass new
			name: #ACMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntityPK;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntityHome;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntityBean;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AMessageBean;
			container: aPackage;
			yourself
		);
		add: database;
		addAll: database tables;
		addAll: dbTable1 columns;
		addAll: dbTable2 columns;
		addAll: dbTable3 columns.

	^mooseModel
]

{ #category : #models }
FAMIXSQLTestResources >> sampleMooseModelWithTransAndInvocationsAndDBAndQueryComplex [

	| mooseModel aPackage anotherPackage aStatelessSessionBean aStatefulSessionBean invocation someMethod someOtherMethod aMethod class3 class4 method1 method2 method3 method4 invocation2 invocation3 invocation4 invocation5 methodThatExecute method5 method6 method7 method9 method10 method11 method12 method13 method14 method8 invocation6 invocation7 invocation8 invocation9 invocation10 invocation11 invocation12 invocation13 invocation14 invocation15 invocation16 invocation17 invocation18 invocation19 database dbTable1 dbTable2 dbTable3 tableColumn |

	mooseModel := MooseModel new.

	aPackage := FAMIXNamespace new
				name: #aPackage;
				yourself.
	anotherPackage := FAMIXNamespace new
			name: #anotherPackage;
			yourself.

	aStatelessSessionBean := FAMIXClass new
			name: #AStatelessSessionBean;
			container: aPackage;
			yourself.

	aMethod := FAMIXMethod new
				name: #aMethod;
				parentType: aStatelessSessionBean;
				signature: #aMethod asString;	
				yourself.

	aStatelessSessionBean addMethod: (aMethod);
			addMethod: (FAMIXMethod new
				name: #anotherMethod;
				parentType: aStatelessSessionBean;
				signature: #anotherMethod asString;	
				yourself
			).
	aStatefulSessionBean := FAMIXClass new
			name: #AStatefulSessionBean;
			container: aPackage;
			yourself.

	someMethod := FAMIXMethod new
				name: #someMethod;
				parentType: aStatefulSessionBean;
				signature: #someMethod asString;	
				yourself.

	methodThatExecute := FAMIXMethod new
						name: #executeBatch;
						parentType: aStatefulSessionBean;
						signature: #executeBatch asString;	
						yourself.
	
	someOtherMethod := FAMIXMethod new
				name: #someOtherMethod;
				parentType: aStatefulSessionBean;
				signature: #someOtherMethod asString;	
				yourself.

	aStatefulSessionBean
			addMethod: (someMethod);
			addMethod: (someOtherMethod);
			addMethod: (methodThatExecute).

	class3 :=  FAMIXClass new
			name: #Class3;
			container: aPackage;
			yourself.

	method1 := FAMIXMethod new
				name: #method1;
				parentType: class3;
				signature: #method1 asString;	
				yourself.
	
	method2 := FAMIXMethod new
				name: #method2;
				parentType: class3;
				signature: #method2 asString;	
				yourself.

	method3 := FAMIXMethod new
				name: #method3;
				parentType: class3;
				signature: #method3 asString;	
				yourself.
				
	method4 := FAMIXMethod new
				name: #method4;
				parentType: class3;
				signature: #method4 asString;	
				yourself.

	method5 := FAMIXMethod new
				name: #method5;
				parentType: class3;
				signature: #method5 asString;	
				yourself.

	method6 := FAMIXMethod new
				name: #method6;
				parentType: class3;
				signature: #method6 asString;	
				yourself.

	method7 := FAMIXMethod new
				name: #method7;
				parentType: class3;
				signature: #method7 asString;	
				ejbTransactionType: 'Required';
				yourself.

	class3	addMethod: (method1);
			addMethod: (method2);
			addMethod: (method4);
			addMethod: (method5);
			addMethod: (method6);
			addMethod: (method7).


	class4 := FAMIXClass new
			name: #Class4;
			container: aPackage;
			yourself.

	method8 := FAMIXMethod new
				name: #method8;
				parentType: class4;
				signature: #method8 asString;	
				ejbTransactionType: 'Required';
				yourself.
	
	method9 := FAMIXMethod new
				name: #method9;
				parentType: class4;
				signature: #method9 asString;	
				yourself.

	method10 := FAMIXMethod new
				name: #method10;
				parentType: class4;
				signature: #method10 asString;	
				yourself.
	method11 := FAMIXMethod new
				name: #method11;
				parentType: class4;
				signature: #method11 asString;	
				ejbTransactionType: 'Required';
				yourself.

	method12 := FAMIXMethod new
				name: #method12;
				parentType: class4;
				signature: #method12 asString;	
				yourself.

	method13 := FAMIXMethod new
				name: #method13;
				parentType: class4;
				signature: #method13 asString;	
				yourself.

	method14 := FAMIXMethod new
				name: #method14;
				parentType: class4;
				signature: #method14 asString;	
				ejbTransactionType: 'Required';
				yourself.

	class4	addMethod: (method8);
			addMethod: (method3);
			addMethod: (method9);
			addMethod: (method10);
			addMethod: (method11);
			addMethod: (method12);
			addMethod: (method13);
			addMethod: (method14).

	"invocation to method that executes a queryes"
	invocation := FAMIXInvocation new sender: method1; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method1 addOutgoingInvocation: invocation.
	methodThatExecute addIncomingInvocation: invocation.

	invocation2 := FAMIXInvocation new sender: method2; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method2 addOutgoingInvocation: invocation2.
	methodThatExecute addIncomingInvocation: invocation2.

	invocation3 := FAMIXInvocation new sender: method3; addCandidate: methodThatExecute; signature: #executeBatch; yourself.
	method3 addOutgoingInvocation: invocation3.
	methodThatExecute addIncomingInvocation: invocation3.

	"other invocation"
	invocation4 := FAMIXInvocation new sender: method4; addCandidate: method1; signature: #method1; yourself.
	method4 addOutgoingInvocation: invocation4.
	method1 addIncomingInvocation: invocation4.

	invocation5 := FAMIXInvocation new sender: method5; addCandidate: method2 ; signature: #method2; yourself.
	method5 addOutgoingInvocation: invocation5.
	method2 addIncomingInvocation: invocation5.

	invocation6 := FAMIXInvocation new sender: method5; addCandidate: method6 ; signature: #method6; yourself.
	method5 addOutgoingInvocation: invocation6.
	method6 addIncomingInvocation: invocation6.

	invocation7 := FAMIXInvocation new sender: method6; addCandidate: method2 ; signature: #method2; yourself.
	method6 addOutgoingInvocation: invocation7.
	method2 addIncomingInvocation: invocation7.

	invocation8 := FAMIXInvocation new sender: method8; addCandidate: method4 ; signature: #method4; yourself.
	method8 addOutgoingInvocation: invocation8.
	method4 addIncomingInvocation: invocation8.

	invocation9 := FAMIXInvocation new sender: method9; addCandidate: method4 ; signature: #method4; yourself.
	method9 addOutgoingInvocation: invocation9.
	method4 addIncomingInvocation: invocation9.

	invocation10 := FAMIXInvocation new sender: method10; addCandidate: method6 ; signature: #method6; yourself.
	method10 addOutgoingInvocation: invocation10.
	method6 addIncomingInvocation: invocation10.

	invocation11 := FAMIXInvocation new sender: method11; addCandidate: method6 ; signature: #method6; yourself.
	method11 addOutgoingInvocation: invocation11.
	method6 addIncomingInvocation: invocation11.

	invocation12 := FAMIXInvocation new sender: method11; addCandidate: method1 ; signature: #method1; yourself.
	method11 addOutgoingInvocation: invocation12.
	method1 addIncomingInvocation: invocation12.

	invocation13 := FAMIXInvocation new sender: method14; addCandidate: method10 ; signature: #method10; yourself.
	method14 addOutgoingInvocation: invocation13.
	method10 addIncomingInvocation: invocation13.

	invocation14 := FAMIXInvocation new sender: method7; addCandidate: method3 ; signature: #method3 ;yourself.
	method7 addOutgoingInvocation: invocation14.
	method3 addIncomingInvocation: invocation14.

	invocation15 := FAMIXInvocation new sender: method12; addCandidate: method7 ; signature: #method7 ;yourself.
	method12 addOutgoingInvocation: invocation15.
	method7 addIncomingInvocation: invocation15.

	invocation16 := FAMIXInvocation new sender: method13; addCandidate: method7 ; signature: #method7 ;yourself.
	method13 addOutgoingInvocation: invocation16.
	method7 addIncomingInvocation: invocation16.

	"old invocations"
	invocation17 := FAMIXInvocation new sender: aMethod; addCandidate: someMethod ; signature: #someMethod ;yourself.
	aMethod addOutgoingInvocation: invocation17.
	someMethod addIncomingInvocation: invocation17.	

	invocation18 := FAMIXInvocation new sender: method1; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method1 addOutgoingInvocation: invocation18.
	aMethod addIncomingInvocation: invocation18.

	invocation19 := FAMIXInvocation new sender: method2; addCandidate: aMethod ; signature: #aMethod ;yourself.
	method2 addOutgoingInvocation: invocation19.
	aMethod addIncomingInvocation: invocation19.

	"instanciating relational elements"
	database := FAMIXDataBase new name: #database1.

	dbTable1 := FAMIXTable new
			name: 'Table1';
			ownerDataBase: database.
	
	dbTable2 := FAMIXTable new
			name: 'Table2';
			ownerDataBase: database.

	dbTable3 := FAMIXTable new
			name: 'Table3';
			ownerDataBase: database.

	tableColumn := FAMIXColumn new
						name: #Column2;
						isPK: true;
						isFK: false;
						ownerTable:  dbTable1;
						type: 'integer'.
	dbTable1 addColumn: tableColumn.
	
	tableColumn := FAMIXColumn new
						name: #Column4;
						isPK: false;
						isFK: false;
						ownerTable:  dbTable1;
						type: 'string'.
	dbTable1 addColumn: tableColumn.
	
	tableColumn := FAMIXColumn new
						name: #Column6;
						isPK: false;
						isFK: false;
						ownerTable:  dbTable1;
						type: 'integer'.
	dbTable1 addColumn: tableColumn.
						
	
	tableColumn := FAMIXColumn new
						name: #Column1;
						isPK: true;
						isFK: false;
						ownerTable:  dbTable2;
						type: 'integer'.
	dbTable2 addColumn: tableColumn.
	
	tableColumn := FAMIXColumn new
						name: #Column3;
						isPK: false;
						isFK: true;
						ownerTable:  dbTable2;
						type: 'integer'.
	dbTable2 addColumn: tableColumn.
						
	tableColumn := FAMIXColumn new
						name: #Column5;
						isPK: true;
						isFK: false;
						ownerTable:  dbTable3;
						type: 'integer'.
	dbTable3 addColumn: tableColumn.

	database addTable: dbTable1.
 	database addTable: dbTable2.
	database addTable: dbTable3.

	mooseModel
		addAll: aStatelessSessionBean methods;
		addAll: aStatefulSessionBean methods;
		addAll: class3 methods;
		addAll: class4 methods;
		add: aPackage;
		add: anotherPackage;
		add: invocation;
		add: invocation2;
		add: invocation3;
		add: invocation4;
		add: invocation5;
		add: invocation6;
		add: invocation7;
		add: invocation8;
		add: invocation9;
		add: invocation10;
		add: invocation11;
		add: invocation12;
		add: invocation13;
		add: invocation14;
		add: invocation15;
		add: invocation16;
		add: invocation17;
		add: invocation18;
		add: invocation19;
		add: class3;
		add: class4;
		add: (FAMIXClass new
			name: #AStatelessSessionHome;
			container: aPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AStatelessSession;
			container: aPackage;
			yourself
		);
		add: aStatelessSessionBean;
		add: (FAMIXClass new
			name: #AStatefulSessionHome;
			container: aPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AStatefulSession;
			container: aPackage;
			yourself
		);
		add: aStatefulSessionBean;
		add: (FAMIXClass new
			name: #ACMPEntityHome;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntityBean;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ACMPEntityPK;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntityHome;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntityBean;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #ABMPEntity;
			container: anotherPackage;
			yourself
		);
		add: (FAMIXClass new
			name: #AMessageBean;
			container: aPackage;
			yourself
		);
		add: database;
		addAll: database tables;
		addAll: dbTable1 columns;
		addAll: dbTable2 columns;
		addAll: dbTable3 columns.

	^mooseModel
]

{ #category : #elements }
FAMIXSQLTestResources >> threeTablesConnectedThroughForeignKey [

^'CREATE TABLE A_Asset(
    A_Asset_ID                   NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Client_ID                 NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Org_ID                    NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    Created                      DATE               DEFAULT SYSDATE NOT NULL,
    CreatedBy                    NUMBER(10, 0)      NOT NULL,
    Updated                      DATE               DEFAULT SYSDATE NOT NULL,
    UpdatedBy                    NUMBER(10, 0)      NOT NULL,
    Value                        NVARCHAR2(40)      NOT NULL,
    Name                         NVARCHAR2(60)      NOT NULL,
    Description                  NVARCHAR2(255),
    Help                         NVARCHAR2(2000),
    A_Asset_Group_ID             NUMBER(10, 0)      NOT NULL,
    Parent_Asset_ID              NUMBER(10, 0),
    M_Product_ID                 NUMBER(10, 0),
    M_AttributeSetInstance_ID    NUMBER(10, 0),
    C_UOM_ID                     NUMBER(10, 0),
    SerNo                        NVARCHAR2(40),
    Lot                          NVARCHAR2(40),
    VersionNo                    NVARCHAR2(40),
    GuaranteeDate                DATE               NOT NULL,
    AssetServiceDate             DATE               NOT NULL,
    AssetDisposalDate            DATE               NOT NULL,
    LocationComment              NVARCHAR2(255),
    M_Locator_ID                 NUMBER(10, 0),
    C_BPartner_ID                NUMBER(10, 0),
    C_BPartner_Location_ID       NUMBER(10, 0),
    AD_User_ID                   NUMBER(10, 0),
    C_Location_ID                NUMBER(10, 0),
    LastMaintenanceDate          DATE               NOT NULL,
    NextMaintenanceDate          DATE               NOT NULL,
    LastMaintenanceUseUnit       NUMBER             DEFAULT 0 NOT NULL,
    NextMaintenanceUseUnit       NUMBER             DEFAULT 0 NOT NULL,
    Lease_BPartner_ID            NUMBER(10, 0),
    LeaseTerminationDate         DATE               NOT NULL,
    Processing                   CHAR(1)
);

CREATE TABLE A_Asset_Group(
    A_Asset_Group_ID    NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Client_ID        NUMBER(10, 0)      NOT NULL,
    AD_Org_ID           NUMBER(10, 0)      NOT NULL,
    Created             DATE               DEFAULT SYSDATE NOT NULL,
    CreatedBy           NUMBER(10, 0)      NOT NULL,
    Updated             DATE               DEFAULT SYSDATE NOT NULL,
    UpdatedBy           NUMBER(10, 0)      NOT NULL,
    Name                NVARCHAR2(60)      NOT NULL,
    Description         NVARCHAR2(255),
    Help                NVARCHAR2(2000),
    CONSTRAINT A_Asset_Group_Key PRIMARY KEY (A_Asset_Group_ID)
);

CREATE TABLE AD_User(
    AD_User_ID                NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Client_ID              NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    AD_Org_ID                 NUMBER(10, 0)      NOT NULL PRIMARY KEY,
    Created                   DATE               DEFAULT SYSDATE NOT NULL,
    CreatedBy                 NUMBER(10, 0)      NOT NULL,
    Updated                   DATE               DEFAULT SYSDATE NOT NULL,
    UpdatedBy                 NUMBER(10, 0)      NOT NULL,
    Name                      NVARCHAR2(60)      NOT NULL,
    Title                     NVARCHAR2(40)      NOT NULL,
    C_Greeting_ID             NUMBER(10, 0),
    Description               NVARCHAR2(255),
    Comments                  NVARCHAR2(2000),
    C_BPartner_ID             NUMBER(10, 0),
    C_BPartner_Location_ID    NUMBER(10, 0),
    Password                  NVARCHAR2(40)      NOT NULL,
    EMail                     NVARCHAR2(60),
    EMailVerify               NVARCHAR2(40)      NOT NULL,
    Phone                     NVARCHAR2(40)      NOT NULL,
    Phone2                    NVARCHAR2(40)      NOT NULL,
    EMailUser                 NVARCHAR2(20)      NOT NULL,
    EMailUserPW               NVARCHAR2(20)      NOT NULL,
    Fax                       NVARCHAR2(40)      NOT NULL,
    Birthday                  DATE               NOT NULL,
    Supervisor_ID             NUMBER(10, 0),
    AD_OrgTrx_ID              NUMBER(10, 0),
    PA_Goal_ID                NUMBER(10, 0),
    PA_GoalPrivate_ID         NUMBER(10, 0),
    LastContact               DATE               NOT NULL,
    LastResult                NVARCHAR2(255),
    Processing                CHAR(1),
    CONSTRAINT AD_User_Key PRIMARY KEY (AD_User_ID)
);

ALTER TABLE A_Asset ADD CONSTRAINT AAssetGroup_AAsset 
    FOREIGN KEY (A_Asset_Group_ID)
    REFERENCES A_Asset_Group(A_Asset_Group_ID);

ALTER TABLE A_Asset ADD CONSTRAINT ADUser_AAsset 
    FOREIGN KEY (AD_User_ID)
    REFERENCES AD_User(AD_User_ID)'

]

{ #category : #elements }
FAMIXSQLTestResources >> threeTablesConnectedThroughForeignKeysMSE [

^'(
	(FAMIX.Column (id: 1)
		(name ''M_Locator_ID'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 3)
		(name ''C_BPartner_Location_ID'')
		(ownerTable (ref: 4)))
	(FAMIX.FKAssociation (id: 5)
		(sourceColumn (ref: 6))
		(targetColumn (ref: 7)))
	(FAMIX.Column (id: 8)
		(name ''C_BPartner_Location_ID'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 9)
		(name ''EMail'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 10)
		(name ''A_Asset_Group_ID'')
		(isPK true)
		(ownerTable (ref: 11)))
	(FAMIX.Column (id: 12)
		(name ''UpdatedBy'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 13)
		(name ''PA_Goal_ID'')
		(ownerTable (ref: 4)))
	(FAMIX.Table (id: 11)
		(name ''A_Asset_Group''))
	(FAMIX.Column (id: 14)
		(name ''SerNo'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 15)
		(name ''LastContact'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 16)
		(name ''UpdatedBy'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 17)
		(name ''A_Asset_ID'')
		(isPK true)
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 18)
		(name ''VersionNo'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 19)
		(name ''Title'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 20)
		(name ''AD_Client_ID'')
		(ownerTable (ref: 11)))
	(FAMIX.Column (id: 21)
		(name ''AD_Org_ID'')
		(isPK true)
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 22)
		(name ''Value'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 23)
		(name ''Phone2'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 24)
		(name ''LastMaintenanceDate'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 25)
		(name ''Created'')
		(ownerTable (ref: 11)))
	(FAMIX.Column (id: 26)
		(name ''AD_Org_ID'')
		(isPK true)
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 27)
		(name ''Description'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 28)
		(name ''EMailUserPW'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 29)
		(name ''LastMaintenanceUseUnit'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 30)
		(name ''CreatedBy'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 31)
		(name ''C_Greeting_ID'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 32)
		(name ''GuaranteeDate'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 33)
		(name ''Created'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 34)
		(name ''Comments'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 35)
		(name ''AssetDisposalDate'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 36)
		(name ''NextMaintenanceUseUnit'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 37)
		(name ''Fax'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 38)
		(name ''UpdatedBy'')
		(ownerTable (ref: 11)))
	(FAMIX.Column (id: 39)
		(name ''Updated'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 40)
		(name ''Parent_Asset_ID'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 41)
		(name ''LeaseTerminationDate'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 42)
		(name ''Supervisor_ID'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 43)
		(name ''Description'')
		(ownerTable (ref: 11)))
	(FAMIX.Column (id: 44)
		(name ''M_AttributeSetInstance_ID'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 45)
		(name ''C_BPartner_ID'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 46)
		(name ''Password'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 47)
		(name ''Updated'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 6)
		(name ''AD_User_ID'')
		(isFK true)
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 48)
		(name ''EMailVerify'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 7)
		(name ''AD_User_ID'')
		(isPK true)
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 49)
		(name ''Help'')
		(ownerTable (ref: 11)))
	(FAMIX.Column (id: 50)
		(name ''C_UOM_ID'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 51)
		(name ''PA_GoalPrivate_ID'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 52)
		(name ''Lot'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 53)
		(name ''LastResult'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 54)
		(name ''Name'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 55)
		(name ''AD_Client_ID'')
		(isPK true)
		(ownerTable (ref: 2)))
	(FAMIX.Table (id: 4)
		(name ''AD_User''))
	(FAMIX.Column (id: 56)
		(name ''Phone'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 57)
		(name ''C_Location_ID'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 58)
		(name ''AD_Org_ID'')
		(ownerTable (ref: 11)))
	(FAMIX.Column (id: 59)
		(name ''AD_Client_ID'')
		(isPK true)
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 60)
		(name ''Name'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 61)
		(name ''EMailUser'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 62)
		(name ''NextMaintenanceDate'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 63)
		(name ''CreatedBy'')
		(ownerTable (ref: 11)))
	(FAMIX.Column (id: 64)
		(name ''Created'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 65)
		(name ''Help'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 66)
		(name ''Processing'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 67)
		(name ''Description'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 68)
		(name ''AssetServiceDate'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 69)
		(name ''CreatedBy'')
		(ownerTable (ref: 2)))
	(FAMIX.Table (id: 2)
		(name ''A_Asset''))
	(FAMIX.Column (id: 70)
		(name ''C_BPartner_ID'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 71)
		(name ''LocationComment'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 72)
		(name ''Updated'')
		(ownerTable (ref: 11)))
	(FAMIX.Column (id: 73)
		(name ''A_Asset_Group_ID'')
		(isFK true)
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 74)
		(name ''Lease_BPartner_ID'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 75)
		(name ''Birthday'')
		(ownerTable (ref: 4)))
	(FAMIX.Column (id: 76)
		(name ''Name'')
		(ownerTable (ref: 11)))
	(FAMIX.FKAssociation (id: 77)
		(sourceColumn (ref: 73))
		(targetColumn (ref: 10)))
	(FAMIX.Column (id: 78)
		(name ''M_Product_ID'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 79)
		(name ''Processing'')
		(ownerTable (ref: 2)))
	(FAMIX.Column (id: 80)
		(name ''AD_OrgTrx_ID'')
		(ownerTable (ref: 4))))'
]
