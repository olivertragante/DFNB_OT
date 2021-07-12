USE [EXM]
GO

/****** Object:  View [dbo].[v_team_detail_dim]    Script Date: 8/3/2019 12:18:28 AM ******/
DROP VIEW [dbo].[v_team_detail_dim]
GO

/****** Object:  View [dbo].[v_team_detail_dim]    Script Date: 8/3/2019 12:18:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************************************************
NAME:    dbo.v_team_detail_dim
PURPOSE: Create the dbo.v_team_detail_dim view

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     08/02/2019   JJAUSSI       1. Built this table for LDS BC IT240


RUNTIME: 
Approx. 1 min

NOTES:
These are the varioius Extract, Transform, and Load steps needed for the Example Data

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

CREATE VIEW [dbo].[v_team_detail_dim]
AS
SELECT t.t_id
     , t.t_code
     , p.p_id
     , p.p_code
     , p.p_name
     , pl.pl_id
     , pl.pl_name
     , pl.pl_num
  FROM dbo.tblTeamDim AS t
 INNER JOIN dbo.tblPlayerDim AS pl 
    ON t.t_id = pl.t_id 
 INNER JOIN dbo.tblPositionDim AS p
   ON pl.p_id = p.p_id;

GO

