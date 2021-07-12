USE DFNB2;
GO

CREATE VIEW dbo.v_open_close_account_branches
AS
SELECT b.branch_code, a.open_close_code FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id
GO