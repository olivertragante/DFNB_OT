USE DFNB2;
GO

CREATE VIEW dbo.v_account_customer_branch
AS 

SELECT b.branch_code,c.cust_id,c.gender,a.acct_id,a.open_close_code,FORMAT(a.open_date,'yyyy') AS year_opened,FORMAT(a.close_date,'yyyy') AS year_closed FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id;
GO