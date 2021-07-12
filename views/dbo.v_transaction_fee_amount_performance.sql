USE DFNB2;
GO

CREATE VIEW dbo.v_transaction_fee_amount_performance
AS 
SELECT
	   FORMAT(f.tran_date,'MM-dd-yyyy') AS tran_year
     , SUM(CAST(f.tran_fee_amt AS decimal(12,2))) AS total_tran_fee_amt
     --, td.tran_type_desc
     --, f.acct_id
     , b.branch_desc
  FROM dbo.tblBranchDim AS b
       JOIN
       dbo.tblTransactionFact AS f ON b.branch_id = f.branch_id
       JOIN
       dbo.tblTransactionTypeDim AS td ON f.tran_type_id = td.tran_type_id
  GROUP BY b.branch_desc, FORMAT(f.tran_date,'MM-dd-yyyy')