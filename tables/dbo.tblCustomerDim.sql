	/*****************************************************************************************************************
NAME:    dbo.stg_p1
PURPOSE: Create the tables for dimentional tables and implement views

SUPPORT: Oliver Tragante
         olivertragante@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       06/15/2021   Oliver Tragante     1. Create tables to implement a dimentional model in MSSQL server.



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

USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblCustomerDim]    Script Date: 6/15/2021 2:20:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblCustomerDim](
	[cust_id] [smallint] NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[birth_date] [date] NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[cust_lat] [decimal](16, 12) NOT NULL,
	[cust_lon] [decimal](16, 12) NOT NULL,
 CONSTRAINT [PK_tblCustomerDim] PRIMARY KEY CLUSTERED 
(
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


