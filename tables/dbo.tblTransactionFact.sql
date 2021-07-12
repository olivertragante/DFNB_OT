USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 6/23/2021 2:15:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblTransactionFact](
	[tran_id] [int] IDENTITY(1,1) NOT NULL,
	[tran_date] [date] NOT NULL,
	[tran_time] [time](7) NOT NULL,
	[cur_cust_req_ind] [varchar](1) NOT NULL,
	[tran_amt] [int] NOT NULL,
	[tran_fee_amt] [decimal](15, 3) NOT NULL,
	[tran_type_id] [smallint] NOT NULL,
	[acct_id] [int] NOT NULL,
	[branch_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblTransactionFact] PRIMARY KEY CLUSTERED 
(
	[tran_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblTransactionFact]  WITH CHECK ADD  CONSTRAINT [FK_tblTransactionFact_tblAccountDim] FOREIGN KEY([acct_id])
REFERENCES [dbo].[tblAccountDim] ([acct_id])
GO

ALTER TABLE [dbo].[tblTransactionFact] CHECK CONSTRAINT [FK_tblTransactionFact_tblAccountDim]
GO

ALTER TABLE [dbo].[tblTransactionFact]  WITH CHECK ADD  CONSTRAINT [FK_tblTransactionFact_tblBranchDim] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tblBranchDim] ([branch_id])
GO

ALTER TABLE [dbo].[tblTransactionFact] CHECK CONSTRAINT [FK_tblTransactionFact_tblBranchDim]
GO

ALTER TABLE [dbo].[tblTransactionFact]  WITH CHECK ADD  CONSTRAINT [FK_tblTransactionFact_tblTransactionType] FOREIGN KEY([tran_type_id])
REFERENCES [dbo].[tblTransactionTypeDim] ([tran_type_id])
GO

ALTER TABLE [dbo].[tblTransactionFact] CHECK CONSTRAINT [FK_tblTransactionFact_tblTransactionType]
GO


