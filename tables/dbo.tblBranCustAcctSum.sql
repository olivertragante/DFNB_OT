USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblBranCustAcctSum]    Script Date: 6/15/2021 11:21:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblBranCustAcctSum](
	[branchcustacctsum_id] [int] IDENTITY(1,1) NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[branch_desc] [varchar](100) NOT NULL,
	[branch_code] [varchar](5) NOT NULL,
	[cust_id] [smallint] NOT NULL,
	[open_date] [date] NOT NULL,
	[close_date] [date] NOT NULL,
	[open_close_code] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tblBranCustAcctSum] PRIMARY KEY CLUSTERED 
(
	[branchcustacctsum_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


