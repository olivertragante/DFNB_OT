USE DFNB2;
GO

CREATE VIEW dbo.v_account_open_close_year
AS

SELECT  FORMAT(a.open_date,'yyyy') AS year_opened, COUNT(a.open_close_code) AS 'number_open_accounts' FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id
GROUP BY FORMAT(a.open_date,'yyyy');
GO