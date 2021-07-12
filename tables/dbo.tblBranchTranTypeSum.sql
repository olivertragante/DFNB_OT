USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblBranchTranTypeSum]    Script Date: 7/8/2021 11:20:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblBranchTranTypeSum](
	[branchtrantypesum_id] [int] IDENTITY(1,1) NOT NULL,
	[branch_code] [varchar](5) NOT NULL,
	[branch_desc] [varchar](100) NOT NULL,
	[tran_date] [date] NOT NULL,
	[tran_id] [int] NOT NULL,
	[tran_type_id] [smallint] NOT NULL,
	[tran_type_code] [varchar](5) NOT NULL,
	[tran_type_desc] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tblBranchTranTypeSum] PRIMARY KEY CLUSTERED 
(
	[branchtrantypesum_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


