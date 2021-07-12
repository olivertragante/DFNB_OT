USE DFNB2;
GO

CREATE VIEW dbo.v_type_transaction_performance
AS 
SELECT
	 td.tran_type_desc
     ,SUM(CAST(f.tran_amt AS decimal(12,2))) AS total_tran_amt
  FROM dbo.tblBranchDim AS b
       JOIN
       dbo.tblTransactionFact AS f ON b.branch_id = f.branch_id
       JOIN
       dbo.tblTransactionTypeDim AS td ON f.tran_type_id = td.tran_type_id
 GROUP BY td.tran_type_desc;
GO