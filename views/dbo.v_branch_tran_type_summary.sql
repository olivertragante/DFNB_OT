USE DFNB2;
GO
CREATE VIEW dbo.v_branch_tran_type_summary
AS 
SELECT bd.branch_code
     , bd.branch_desc
     , tf.tran_date
     , tf.tran_id
     , ttd.tran_type_id
     , ttd.tran_type_code
     , tran_type_desc
  FROM dbo.tblBranchDim AS bd
       JOIN
       dbo.tblTransactionFact AS tf ON bd.branch_id = tf.branch_id
       JOIN
       dbo.tblTransactionTypeDim AS ttd ON tf.tran_type_id = ttd.tran_type_id;
GO