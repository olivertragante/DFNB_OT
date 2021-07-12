USE DFNB2;
GO
CREATE VIEW dbo.v_branch_cust_acct_summary
AS 
SELECT bd.branch_id
     , bd.branch_desc
     , bd.branch_code
     , cd.cust_id
     , ad.open_date
     , ad.close_date
     , ad.open_close_code
  FROM dbo.tblBranchDim AS bd
       JOIN
       dbo.tblCustomerBranchDim AS cbd ON bd.branch_id = cbd.branch_id
       JOIN
       dbo.tblCustomerDim AS cd ON cbd.cust_id = cd.cust_id
       JOIN
       dbo.tblCustomerAccountDim AS cad ON cd.cust_id = cad.cust_id
       JOIN
       dbo.tblAccountDim AS ad ON cad.acct_id = ad.acct_id;
GO


