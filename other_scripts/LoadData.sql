/*****************************************************************************************************************
NAME:    LoadData
PURPOSE: ETL process for Example data

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     08/02/2019   JJAUSSI       1. Built this table for LDS BC IT240
1.1     10/27/2019   JJAUSSI       1. Added fact table load for LDS BC IT243
1.2     05/06/2020   JJAUSSI       1. Added Team Name
1.3     05/11/2020   JJAUSSI       1. Added dynamic column for Team Name


RUNTIME: 
Approx. 1 min

NOTES:
These are the varioius Extract, Transform, and Load steps needed for the Example Data

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/


-- 1) Drop contraints

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblPlayerDim_tblPositionDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblPlayerDim')
)
    BEGIN

        ALTER TABLE dbo.tblPlayerDim DROP CONSTRAINT FK_tblPlayerDim_tblPositionDim;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblPlayerDim_tblTeamDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblPlayerDim')
)
    BEGIN

        ALTER TABLE dbo.tblPlayerDim DROP CONSTRAINT FK_tblPlayerDim_tblTeamDim;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblPlayerFact_tblPlayerDim'
           AND parent_object_id = OBJECT_ID(N'dbo.tblPlayerFact')
)
    BEGIN

        ALTER TABLE dbo.tblPlayerFact DROP CONSTRAINT FK_tblPlayerFact_tblPlayerDim;

END;



-- 2) Create the Player Dimension table

--SELECT DISTINCT
--       d.pl_id
--     , d.l_name
--     , d.f_name
--     , d.pl_name
--     , d.t_id
--     , d.p_id
--     , d.pl_num
--  INTO dbo.tblPlayerDim
--  FROM dbo.tblData d
-- ORDER BY pl_id;

-- dbo.tblPlayerDim.sql

TRUNCATE TABLE dbo.tblPlayerDim;

INSERT INTO dbo.tblPlayerDim
SELECT DISTINCT
       d.pl_id
     , d.l_name
     , d.f_name
     , d.pl_name
     , d.t_id
     , d.p_id
     , d.pl_num
  FROM dbo.tblData d
 ORDER BY d.pl_id;



-- 3) Create the Position Dimension table

--SELECT DISTINCT
--       d.p_id
--     , d.p_code
--     , d.p_name
--     , d.p_target
--  INTO dbo.tblPositionDim
--  FROM dbo.tblData d
-- ORDER BY d.p_id;

-- dbo.tblPositionDim.sql

TRUNCATE TABLE dbo.tblPositionDim;

INSERT INTO dbo.tblPositionDim
SELECT DISTINCT
       d.p_id
     , d.p_code
     , d.p_name
     , d.p_target
  FROM dbo.tblData d
 ORDER BY d.p_id;



-- 4) Create the Team Dimension table

--SELECT DISTINCT
--       d.t_id
--     , d.t_code
--  INTO dbo.tblTeamDim
--  FROM dbo.tblData d
-- ORDER BY d.t_id;

-- dbo.tblTeamDim.sql

TRUNCATE TABLE dbo.tblTeamDim;

IF NOT EXISTS
(
    SELECT c.*
      FROM INFORMATION_SCHEMA.COLUMNS AS c
     WHERE c.COLUMN_NAME = 't_name'
           AND c.TABLE_NAME = 'tblTeamDim'
		   AND c.TABLE_SCHEMA = 'dbo'
)
    BEGIN

        ALTER TABLE dbo.tblTeamDim ADD t_name varchar(50) NULL;

END;

INSERT INTO dbo.tblTeamDim
SELECT DISTINCT
       d.t_id
     , d.t_code
	  , CASE WHEN LEFT(d.t_code, 1) = 'U'
	        THEN 'Barcelona - Under ' + CAST(
	        								CAST(
	        									RIGHT(d.t_code, 2) 
	        									as int) 
	        								as varchar(2)) + ' Squad'
			ELSE 'Barcelona - Senior Squad'
			END as t_name
  FROM dbo.tblData d
 ORDER BY d.t_id;
 


-- 5) Load the Player Fact table

TRUNCATE TABLE dbo.tblPlayerFact;

SELECT p.pl_id 
     , FLOOR(RAND(CHECKSUM(NEWID()))*(200000-10000+1)+10000) as mtd_salary
	 INTO #TempTable
  FROM dbo.tblPlayerDim AS p;

WITH s1
AS
(
SELECT '2019-12-31' as as_of_date UNION
SELECT '2019-11-30' as as_of_date UNION
SELECT '2019-10-31' as as_of_date UNION
SELECT '2019-09-30' as as_of_date UNION
SELECT '2019-08-31' as as_of_date UNION
SELECT '2019-07-31' as as_of_date UNION
SELECT '2019-06-30' as as_of_date UNION
SELECT '2019-05-31' as as_of_date UNION
SELECT '2019-04-30' as as_of_date UNION
SELECT '2019-03-31' as as_of_date UNION
SELECT '2019-02-28' as as_of_date UNION
SELECT '2019-01-31' as as_of_date
)
INSERT INTO dbo.tblPlayerFact
SELECT s1.as_of_date
     , t.pl_id
	 , t.mtd_salary
  FROM s1 CROSS JOIN #TempTable AS t
 ORDER BY 1, 2;

DROP TABLE #TempTable;



-- 6) Add contraints

ALTER TABLE dbo.tblPlayerDim
ADD CONSTRAINT FK_tblPlayerDim_tblPositionDim FOREIGN KEY(p_id) REFERENCES dbo.tblPositionDim(p_id);

ALTER TABLE dbo.tblPlayerDim
ADD CONSTRAINT FK_tblPlayerDim_tblTeamDim FOREIGN KEY(t_id) REFERENCES dbo.tblTeamDim(t_id);

ALTER TABLE dbo.tblPlayerFact
ADD CONSTRAINT FK_tblPlayerFact_tblPlayerDim FOREIGN KEY(pl_id) REFERENCES dbo.tblPlayerDim(pl_id);
