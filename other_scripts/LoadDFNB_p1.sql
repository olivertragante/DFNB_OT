/*****************************************************************************************************************
NAME:    dbo.stg_p1
PURPOSE: Create the tables for dimentional tables and implement views

SUPPORT: Oliver Tragante
         olivertragante@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       07/05/2021   Oliver Tragante      1. Create tables to implement a dimentional model in MSSQL server.
1.1       07/05/2021   Oliver Tragante      2. Create tables dbo.tblTransactionFact and dbo.tblTransactionType.



RUNTIME: 
1 min

NOTES: 
The idea is that tables is created using the dbo.stg_p1 table to create tables to implement a
dimentional table to create views the answer the question of the CEO about the performance of
Desseret  First National Bank (DFNB)

LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.

******************************************************************************************************************/

-- 1) Drop contraints

/*REMOVE CONSTRAINTS*/
--Removing Foreign keys

--dbo.tblAccountDim
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountDim_tblProductDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountDim DROP CONSTRAINT FK_tblAccountDim_tblProductDim;

END;

--dbo.tblAccountFact
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountFact_tblAccountDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountFact')
)
    BEGIN

        ALTER TABLE dbo.tblAccountFact DROP CONSTRAINT FK_tblAccountFact_tblAccountDim;

END;
--dbo.tblAccountRoleDim
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'PK_tblAccountRoleDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountRoleDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountRoleDim DROP CONSTRAINT PK_tblAccountRoleDim;

END;

--dbo.tblBranchDim
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblBranchDim_tblAreaDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblBranchDim DROP CONSTRAINT FK_tblBranchDim_tblAreaDim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblBranchDim_tblRegionDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblBranchDim DROP CONSTRAINT FK_tblBranchDim_tblRegionDim;

END;

--dbo.tblCustomerAccountDim
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblCustomerAccountDim_tblAccountDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblCustomerAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblCustomerAccountDim DROP CONSTRAINT FK_tblCustomerAccountDim_tblAccountDim;

END;
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblCustomerAccountDim_tblAccountRoleDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblCustomerAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblCustomerAccountDim DROP CONSTRAINT FK_tblCustomerAccountDim_tblAccountRoleDim;

END;
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblCustomerAccountDim_tblCustomerDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblCustomerAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblCustomerAccountDim DROP CONSTRAINT FK_tblCustomerAccountDim_tblCustomerDim;

END;

--dbo.tblCustomerBranchDim
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblCustomerBranchDim_tblBranchDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblCustomerBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblCustomerBranchDim DROP CONSTRAINT FK_tblCustomerBranchDim_tblBranchDim;

END;
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblCustomerBranchDim_tblCustomerDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblCustomerBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblCustomerBranchDim DROP CONSTRAINT FK_tblCustomerBranchDim_tblCustomerDim;

END;

--END REMOVING CONSTRAINT FK
--REMOVING CONSTRAINT Project 2
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblTransactionFact_tblBranchDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblTransactionFact')
)
    BEGIN

        ALTER TABLE dbo.tblTransactionFact DROP CONSTRAINT FK_tblTransactionFact_tblBranchDim;

END;
IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblTransactionFact_tblTransactionType'
           AND parent_object_id = OBJECT_ID(N'dbo.tblTransactionFact')
)
    BEGIN

        ALTER TABLE dbo.tblTransactionFact DROP CONSTRAINT FK_tblTransactionFact_tblTransactionType;

END;

--END REMOVING CONSTRAINT Project 2


--2) Creating Dimension Tables

-- tblAccountDim
DROP TABLE dbo.tblAccountDim;
SELECT DISTINCT
	s.acct_id,
	s.open_date,
	s.close_date,
	s.open_close_code,
	s.loan_amt,
	s.prod_id
INTO dbo.tblAccountDim
FROM dbo.stg_p1 AS s
WHERE 1=2;

-- Load AccountDim Load
TRUNCATE TABLE dbo.tblAccountDim;
INSERT INTO dbo.tblAccountDim
SELECT DISTINCT
	s.acct_id,
	s.open_date,
	s.close_date,
	s.open_close_code,
	s.loan_amt,
	s.prod_id
FROM dbo.stg_p1 s
ORDER BY s.acct_id ASC;

--SELECT 
SELECT * FROM dbo.tblAccountDim
ORDER BY acct_id;
-- END tblAccountDim

--dbo.tblProductDim
DROP TABLE dbo.tblProductDim
SELECT DISTINCT s.prod_id
INTO tblProductDim
FROM dbo.stg_p1 AS s
WHERE 1=2

ALTER TABLE dbo.tblProductDim ADD prod_code CHAR(2), prod_desc VARCHAR(45);

-- Load dbo.tblProductDim
TRUNCATE TABLE dbo.tblProductDim
INSERT INTO dbo.tblProductDim (prod_id)
SELECT DISTINCT
	s.prod_id
FROM dbo.stg_p1 AS s
ORDER BY s.prod_id ASC;

--SELECT tblProductDim
SELECT * FROM dbo.tblProductDim;
--END dbo.tblProductDim



-- tblCustomerAccountDim
--DROP TABLE
DROP TABLE tblCustomerAccountDim
SELECT DISTINCT
	s.cust_id,
	s.acct_id,
	s.acct_cust_role_id
INTO tblCustomerAccountDim
FROM dbo.stg_p1 AS s
WHERE 1=2;

-- Load tblCustomerAccountDim
INSERT INTO dbo.tblCustomerAccountDim
SELECT DISTINCT
	s.cust_id,
	s.acct_id,
	s.acct_cust_role_id
FROM dbo.stg_p1 AS s
ORDER BY s.cust_id ASC;

-- SELECT tblCustomerAccountDim
SELECT * FROM dbo.tblCustomerAccountDim;
-- WHERE cust_id=117 AND acct_id=34540;

-- END tblCustomerAccountDim




-- tblCustomerDim
--DROP TABLE
DROP TABLE tblCustomerDim;
-- Create tblCustomerDim
SELECT DISTINCT
	s.cust_id,
	s.first_name,
	s.last_name,
	s.birth_date,
	s.gender,
	s.cust_lat,
	s.cust_lon
INTO dbo.tblCustomerDim
FROM dbo.stg_p1 AS s
WHERE 1=2;

--Load tblCustomerDim Data
TRUNCATE TABLE dbo.tblCustomerDim
INSERT INTO dbo.tblCustomerDim
SELECT DISTINCT 
	s.cust_id,
	s.first_name,
	s.last_name,
	s.birth_date,
	s.gender,
	s.cust_lat,
	s.cust_lon
FROM dbo.stg_p1 AS s
ORDER BY s.cust_id ASC;

--SELECT dbo.tblCustomerDim
SELECT * FROM dbo.tblCustomerDim  ORDER BY cust_id ASC;

-- END tblCustomerDim

--tblCustomerBranchDim
DROP TABLE tblCustomerBranchDim
--Create table tblCustomerBranchDim
SELECT s.branch_id,s.cust_id
INTO dbo.tblCustomerBranchDim
FROM dbo.stg_p1 AS s
WHERE 1=2;
--Load tblCustomerBranchDim
TRUNCATE TABLE dbo.tblCustomerBranchDim;
INSERT INTO dbo.tblCustomerBranchDim
SELECT DISTINCT s.branch_id,s.cust_id
FROM dbo.stg_p1 AS s;


--SELECT tblCustomerBranchDim
SELECT * FROM tblCustomerBranchDim;

-- END --tblCustomerBranchDim

--tblBranchDim
DROP TABLE tblBranchDim;
SELECT DISTINCT
	s.branch_id,
	s.acct_branch_code AS branch_code,
	s.acct_branch_desc AS branch_desc,
	s.acct_branch_lat AS branch_lat,
	s.acct_branch_lon AS branch_lon,
	s.acct_region_id AS region_id,
	s.acct_area_id AS area_id
INTO dbo.tblBranchDim
FROM dbo.stg_p1 AS s
WHERE 1=2;

TRUNCATE TABLE dbo.tblBranchDim;
INSERT INTO dbo.tblBranchDim
SELECT DISTINCT
	s.branch_id,
	s.acct_branch_code AS branch_code,
	s.acct_branch_desc AS branch_desc,
	s.acct_branch_lat AS branch_lat,
	s.acct_branch_lon AS branch_lon,
	s.acct_region_id AS region_id,
	s.acct_area_id AS area_id
FROM dbo.stg_p1 AS s
ORDER BY s.branch_id ASC;

--SELECT
SELECT * FROM dbo.tblBranchDim;

-- END tblBranchDim



-- tblAccountRoleDim
SELECT DISTINCT
	s.acct_cust_role_id
INTO dbo.tblAccountRoleDim
FROM dbo.stg_p1 AS s
WHERE 1=2;

ALTER TABLE dbo.tblAccountRoleDim ADD acct_cust_role_desc VARCHAR(25);

INSERT INTO dbo.tblAccountRoleDim (acct_cust_role_id)
SELECT DISTINCT
	s.acct_cust_role_id
FROM dbo.stg_p1 AS s
ORDER BY s.acct_cust_role_id ASC;

--SELECT tblAccountRoleDim
SELECT * FROM dbo.tblAccountRoleDim;
-- END tblAccountRoleDim


-- tblAreaDim
DROP TABLE dbo.tblAreaDim;
SELECT DISTINCT
	s.acct_area_id
INTO dbo.tblAreaDim
FROM dbo.stg_p1 AS s
WHERE 1=2;
--ALTER TABLE
ALTER TABLE dbo.tblAreaDim ADD area_code CHAR(2), area_desc VARCHAR(45);

--INSERT INTO
TRUNCATE TABLE dbo.tblAreaDim;
INSERT INTO dbo.tblAreaDim (s.acct_area_id)
SELECT DISTINCT
	s.acct_area_id
FROM dbo.stg_p1 AS s
ORDER BY  s.acct_area_id ASC;
--SELECT dbo.tblAreaDim
SELECT * FROM dbo.tblAreaDim;
-- END tblAreaDim


--tblRegionDim
DROP TABLE dbo.tblRegionDim;
SELECT DISTINCT
	s.acct_region_id AS region_id
INTO dbo.tblRegionDim
FROM dbo.stg_p1 AS s
WHERE 1=2;
--ALTER TABLE
ALTER TABLE dbo.tblRegionDim ADD region_code CHAR(2), region_desc VARCHAR(45);
--INSERT INTO
TRUNCATE TABLE dbo.tblRegionDim;
INSERT INTO dbo.tblRegionDim (s.region_id)
SELECT DISTINCT
	s.acct_region_id
FROM dbo.stg_p1 AS s
ORDER BY s.acct_region_id ASC;
--SELECT
SELECT * FROM dbo.tblRegionDim;
-- END tblRegionDim

--dbo.tblAccountFact
DROP TABLE dbo.tblAccountFact;
SELECT s.as_of_date,s.acct_id,s.cur_bal 
INTO dbo.tblAccountFact
FROM dbo.stg_p1 AS s
WHERE 1=2
--ALTER TABLE 
ALTER TABLE dbo.tblAccountFact ADD accountfact_id INT IDENTITY(1,1);
--WHERE s.acct_id IN (1,3);
--INSERT INTO
TRUNCATE TABLE dbo.tblAccountFact;
INSERT INTO dbo.tblAccountFact
SELECT s.as_of_date,s.acct_id,s.cur_bal 
FROM dbo.stg_p1 AS s
ORDER BY s.acct_id ASC;

--SELECT 
SELECT * FROM dbo.tblAccountFact
ORDER BY accountfact_id;

--END Creating Dimension Tables

/******PROJECT 2 **************/
-- 2.1) CREATING TABLES from dbo.stg_p2

--dbo.tblTransactionType
--create
DROP TABLE dbo.tblTransactionTypeDim;
SELECT DISTINCT 
       s.tran_type_id
     , s.tran_type_code
     , s.tran_type_desc
     , s.tran_fee_prct
INTO dbo.tblTransactionTypeDim
  FROM dbo.stg_p2 s
WHERE 1=2
ORDER BY tran_type_id;

--Load Data
TRUNCATE TABLE dbo.tblTransactionTypeDim;
INSERT INTO dbo.tblTransactionTypeDim
SELECT DISTINCT 
       s.tran_type_id
     , s.tran_type_code
     , s.tran_type_desc
     , s.tran_fee_prct
FROM dbo.stg_p2 s
ORDER BY tran_type_id ASC;
----END dbo.tblTransactionType

--dbo.tblTransactionFact
DROP TABLE dbo.tblTransactionFact;
SELECT s.tran_date
     , s.tran_time
     , s.cur_cust_req_ind
     , s.tran_amt
     , s.tran_fee_amt
	 , s.tran_type_id
	 , s.acct_id
	 ,s.branch_id
INTO dbo.tblTransactionFact
FROM dbo.stg_p2 AS s
WHERE 1=2;

ALTER TABLE dbo.tblTransactionFact ADD tran_id INT IDENTITY(1,1);

--Load Data
TRUNCATE TABLE dbo.tblTransactionFact;

INSERT INTO dbo.tblTransactionFact
SELECT s.tran_date
     , s.tran_time
     , s.cur_cust_req_ind
     , s.tran_amt
     , s.tran_fee_amt
	 , s.tran_type_id
	 , s.acct_id
	 ,s.branch_id
FROM dbo.stg_p2 AS s
WHERE s.acct_id <> -1;
--END dbo.tblTransactionFact

/**END PROJECT 2*/

/*****PROJECT 3**********************/
-- Summary table dbo.tblBranchTranTypeSum

--Create table
SELECT bd.branch_code
     , bd.branch_desc
     , tf.tran_date
     , tf.tran_id
     , ttd.tran_type_id
     , ttd.tran_type_code
     , tran_type_desc
  INTO dbo.tblBranchTranTypeSum
  FROM dbo.tblBranchDim AS bd
       JOIN
       dbo.tblTransactionFact AS tf ON bd.branch_id = tf.branch_id
       JOIN
       dbo.tblTransactionTypeDim AS ttd ON tf.tran_type_id = ttd.tran_type_id
  WHERE 1=2;

  ALTER TABLE dbo.tblBranchTranTypeSum
  ADD branchtrantypesum_id INT IDENTITY(1,1);

--Load Data
  INSERT INTO dbo.tblBranchTranTypeSum
  SELECT bd.branch_code
     , bd.branch_desc
     , tf.tran_date
     , tf.tran_id
     , ttd.tran_type_id
     , ttd.tran_type_code
     , tran_type_desc
  FROM dbo.tblBranchDim AS bd
       JOIN
       dbo.tblTransactionFact AS tf ON bd.branch_id = tf.branch_id
       JOIN
       dbo.tblTransactionTypeDim AS ttd ON tf.tran_type_id = ttd.tran_type_id;



--Summary table dbo.tblBranCustAcctSum

--Create Table
SELECT bd.branch_id
     , bd.branch_desc
     , bd.branch_code
     , cd.cust_id
     , ad.open_date
     , ad.close_date
     , ad.open_close_code
  INTO dbo.tblBranCustAcctSum
  FROM dbo.tblBranchDim AS bd
       JOIN
       dbo.tblCustomerBranchDim AS cbd ON bd.branch_id = cbd.branch_id
       JOIN
       dbo.tblCustomerDim AS cd ON cbd.cust_id = cd.cust_id
       JOIN
       dbo.tblCustomerAccountDim AS cad ON cd.cust_id = cad.cust_id
       JOIN
       dbo.tblAccountDim AS ad ON cad.acct_id = ad.acct_id
  WHERE 1=2;

  ALTER TABLE dbo.tblBranCustAcctSum
  ADD branchcustacctsum_id INT IDENTITY(1,1);

-- Load Data
  INSERT INTO dbo.tblBranCustAcctSum
  SELECT bd.branch_id
     , bd.branch_desc
     , bd.branch_code
     , cd.cust_id
     , ad.open_date
     , ad.close_date
     , ad.open_close_code
  FROM dbo.tblBranchDim AS bd
       JOIN
       dbo.tblCustomerBranchDim AS cbd ON bd.branch_id = cbd.branch_id
       JOIN
       dbo.tblCustomerDim AS cd ON cbd.cust_id = cd.cust_id
       JOIN
       dbo.tblCustomerAccountDim AS cad ON cd.cust_id = cad.cust_id
       JOIN
       dbo.tblAccountDim AS ad ON cad.acct_id = ad.acct_id;
/*******END PROJECT 3****************/

--3) Add contraints

/* ADD CONTRAINTS Project 1*/

-- tblBranchDim FK
-- area_id
ALTER TABLE dbo.tblBranchDim 
ADD CONSTRAINT FK_tblBranchDim_tblAreaDim FOREIGN KEY (area_id) REFERENCES dbo.tblAreaDim(acct_area_id);
-- region_id
ALTER TABLE dbo.tblBranchDim 
ADD CONSTRAINT FK_tblBranchDim_tblRegionDim FOREIGN KEY (region_id) REFERENCES dbo.tblRegionDim(region_id);

--tblCustomerBranchDim
--dbo.tblCustomerBranchDim -> tblCustomerDim 
ALTER TABLE dbo.tblCustomerBranchDim 
ADD CONSTRAINT FK_tblCustomerBranchDim_tblCustomerDim FOREIGN KEY (cust_id) REFERENCES dbo.tblCustomerDim(cust_id);
--dbo.tblCustomerBranchDim -> tblBranchDim
ALTER TABLE dbo.tblCustomerBranchDim 
ADD CONSTRAINT FK_tblCustomerBranchDim_tblBranchDim FOREIGN KEY (branch_id) REFERENCES dbo.tblBranchDim(branch_id);

--tblCustomerAccountDim
--tblCustomerAccountDim -> tblCustomerDim
ALTER TABLE dbo.tblCustomerAccountDim
ADD CONSTRAINT FK_tblCustomerAccountDim_tblCustomerDim FOREIGN KEY (cust_id) REFERENCES dbo.tblCustomerDim(cust_id);

--tblCustomerAccountDim -> tblAccountDim
ALTER TABLE dbo.tblCustomerAccountDim
ADD CONSTRAINT FK_tblCustomerAccountDim_tblAccountDim FOREIGN KEY (acct_id) REFERENCES dbo.tblAccountDim(acct_id);

--tblCustomerAccountDim ->tblAccountRoleDim
ALTER TABLE dbo.tblCustomerAccountDim
ADD CONSTRAINT FK_tblCustomerAccountDim_tblAccountRoleDim FOREIGN KEY (acct_cust_role_id) REFERENCES dbo.tblAccountRoleDim (acct_cust_role_id);

--tblAccountDim
--tblAccountDim -> tblProductDim
ALTER TABLE dbo.tblAccountDim
ADD CONSTRAINT FK_tblAccountDim_tblProductDim FOREIGN KEY (prod_id) REFERENCES dbo.tblProductDim (prod_id);

--tblAccountFact
--tlbAccountFact -> tblAccountDim
ALTER TABLE dbo.tblAccountFact
ADD CONSTRAINT FK_tblAccountFact_tblAccountDim FOREIGN KEY (acct_id) REFERENCES dbo.tblAccountDim (acct_id);

--END ADD CONSTRAINTS

/***********ADD CONTRAINT PROJECT 2**********/
--dbo.tblTransactionFact->dbo.tblTransactionType
ALTER TABLE dbo.tblTransactionFact	
ADD CONSTRAINT FK_tblTransactionFact_tblTransactionType FOREIGN KEY (tran_type_id) REFERENCES dbo.tblTransactionTypeDim (tran_type_id);

--dbo.tblTransactionFact->dbo.tblBranchDim
ALTER TABLE dbo.tblTransactionFact 
ADD CONSTRAINT FK_tblTransactionFact_tblBranchDim FOREIGN KEY (branch_id) REFERENCES dbo.tblBranchDim (branch_id);

--dbo.tblTransactionFact-> dbo.tblAccountDim
ALTER TABLE dbo.tblTransactionFact  
ADD CONSTRAINT FK_tblTransactionFact_tblAccountDim FOREIGN KEY (acct_id) REFERENCES dbo.tblAccountDim (acct_id);