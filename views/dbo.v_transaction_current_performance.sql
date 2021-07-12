USE DFNB2;
GO

CREATE VIEW dbo.v_transaction_current_performance
AS 
SELECT f.tran_id
     , FORMAT(f.tran_date,'MM-dd-yyyy') AS tran_date
     , f.tran_amt
     , td.tran_fee_prct
     , f.tran_fee_amt
     , td.tran_type_desc
     , f.acct_id
     , b.branch_desc
  FROM dbo.tblBranchDim AS b
       JOIN
       dbo.tblTransactionFact AS f ON b.branch_id = f.branch_id
       JOIN
       dbo.tblTransactionTypeDim AS td ON f.tran_type_id = td.tran_type_id
GO