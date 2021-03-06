/*****************************************************************************************************************
NAME:    dbo.stg_p1
PURPOSE: Create the tables for dimentional tables and implement views

SUPPORT: Oliver Tragante
         olivertragante@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       07/04/2021   Oliver Tragant      1. Create tables to implement a dimentional model in MSSQL server.



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
/****** Object:  Table [dbo].[tblAccountDim]    Script Date: 6/14/2021 4:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountDim](
	[acct_id] [int] NOT NULL,
	[open_date] [date] NOT NULL,
	[close_date] [date] NOT NULL,
	[open_close_code] [varchar](1) NOT NULL,
	[prod_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblAccountDim] PRIMARY KEY CLUSTERED 
(
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAccountFact]    Script Date: 6/14/2021 4:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountFact](
	[accountfact_id] [int] IDENTITY(1,1) NOT NULL,
	[as_of_date] [date] NOT NULL,
	[acct_id] [int] NOT NULL,
	[cur_bal] [decimal](20, 4) NOT NULL,
 CONSTRAINT [PK_tblAccountFact] PRIMARY KEY CLUSTERED 
(
	[accountfact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAccountRoleDim]    Script Date: 6/14/2021 4:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountRoleDim](
	[acct_cust_role_id] [smallint] NOT NULL,
	[acct_cust_role_desc] [varchar](25) NULL,
 CONSTRAINT [PK_tblAccountRoleDim] PRIMARY KEY CLUSTERED 
(
	[acct_cust_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAreaDim]    Script Date: 6/14/2021 4:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAreaDim](
	[acct_area_id] [int] NOT NULL,
	[area_code] [char](2) NULL,
	[area_desc] [varchar](45) NULL,
 CONSTRAINT [PK_tblAreaDim] PRIMARY KEY CLUSTERED 
(
	[acct_area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblBranchDim]    Script Date: 6/14/2021 4:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBranchDim](
	[branch_id] [smallint] NOT NULL,
	[branch_code] [varchar](5) NOT NULL,
	[branch_desc] [varchar](100) NOT NULL,
	[branch_lat] [decimal](16, 12) NOT NULL,
	[branch_lon] [decimal](16, 12) NOT NULL,
	[region_id] [int] NOT NULL,
	[area_id] [int] NOT NULL,
 CONSTRAINT [PK_tblBranchDim] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomerAccountDim]    Script Date: 6/14/2021 4:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomerAccountDim](
	[cust_id] [smallint] NOT NULL,
	[acct_id] [int] NOT NULL,
	[acct_cust_role_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblCustomerAccountDim] PRIMARY KEY CLUSTERED 
(
	[cust_id] ASC,
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomerBranchDim]    Script Date: 6/14/2021 4:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomerBranchDim](
	[branch_id] [smallint] NOT NULL,
	[cust_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblCustomerBranchDim] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC,
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomerDim]    Script Date: 6/14/2021 4:07:49 PM ******/
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
/****** Object:  Table [dbo].[tblProductDim]    Script Date: 6/14/2021 4:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductDim](
	[prod_id] [smallint] NOT NULL,
	[prod_code] [char](2) NULL,
	[prod_desc] [varchar](45) NULL,
 CONSTRAINT [PK_tblProductDim] PRIMARY KEY CLUSTERED 
(
	[prod_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRegionDim]    Script Date: 6/14/2021 4:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRegionDim](
	[region_id] [int] NOT NULL,
	[region_code] [char](2) NULL,
	[region_desc] [varchar](45) NULL,
 CONSTRAINT [PK_tblRegionDim] PRIMARY KEY CLUSTERED 
(
	[region_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountDim_tblProductDim] FOREIGN KEY([prod_id])
REFERENCES [dbo].[tblProductDim] ([prod_id])
GO
ALTER TABLE [dbo].[tblAccountDim] CHECK CONSTRAINT [FK_tblAccountDim_tblProductDim]
GO
ALTER TABLE [dbo].[tblAccountFact]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountFact_tblAccountDim] FOREIGN KEY([acct_id])
REFERENCES [dbo].[tblAccountDim] ([acct_id])
GO
ALTER TABLE [dbo].[tblAccountFact] CHECK CONSTRAINT [FK_tblAccountFact_tblAccountDim]
GO
ALTER TABLE [dbo].[tblBranchDim]  WITH CHECK ADD  CONSTRAINT [FK_tblBranchDim_tblAreaDim] FOREIGN KEY([area_id])
REFERENCES [dbo].[tblAreaDim] ([acct_area_id])
GO
ALTER TABLE [dbo].[tblBranchDim] CHECK CONSTRAINT [FK_tblBranchDim_tblAreaDim]
GO
ALTER TABLE [dbo].[tblBranchDim]  WITH CHECK ADD  CONSTRAINT [FK_tblBranchDim_tblRegionDim] FOREIGN KEY([region_id])
REFERENCES [dbo].[tblRegionDim] ([region_id])
GO
ALTER TABLE [dbo].[tblBranchDim] CHECK CONSTRAINT [FK_tblBranchDim_tblRegionDim]
GO
ALTER TABLE [dbo].[tblCustomerAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerAccountDim_tblAccountDim] FOREIGN KEY([acct_id])
REFERENCES [dbo].[tblAccountDim] ([acct_id])
GO
ALTER TABLE [dbo].[tblCustomerAccountDim] CHECK CONSTRAINT [FK_tblCustomerAccountDim_tblAccountDim]
GO
ALTER TABLE [dbo].[tblCustomerAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerAccountDim_tblAccountRoleDim] FOREIGN KEY([acct_cust_role_id])
REFERENCES [dbo].[tblAccountRoleDim] ([acct_cust_role_id])
GO
ALTER TABLE [dbo].[tblCustomerAccountDim] CHECK CONSTRAINT [FK_tblCustomerAccountDim_tblAccountRoleDim]
GO
ALTER TABLE [dbo].[tblCustomerAccountDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerAccountDim_tblCustomerDim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tblCustomerDim] ([cust_id])
GO
ALTER TABLE [dbo].[tblCustomerAccountDim] CHECK CONSTRAINT [FK_tblCustomerAccountDim_tblCustomerDim]
GO
ALTER TABLE [dbo].[tblCustomerBranchDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerBranchDim_tblBranchDim] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tblBranchDim] ([branch_id])
GO
ALTER TABLE [dbo].[tblCustomerBranchDim] CHECK CONSTRAINT [FK_tblCustomerBranchDim_tblBranchDim]
GO
ALTER TABLE [dbo].[tblCustomerBranchDim]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerBranchDim_tblCustomerDim] FOREIGN KEY([cust_id])
REFERENCES [dbo].[tblCustomerDim] ([cust_id])
GO
ALTER TABLE [dbo].[tblCustomerBranchDim] CHECK CONSTRAINT [FK_tblCustomerBranchDim_tblCustomerDim]
GO
