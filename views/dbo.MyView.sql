/*****************************************************************************************************************
NAME:    dbo.stg_p1
PURPOSE: Create the tables for dimentional tables and implement views

SUPPORT: Oliver Tragante
         olivertragante@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       06/15/2021   Oliver Tragante      1. Create tables to implement a dimentional model in MSSQL server.



RUNTIME: 
1 min

NOTES: 
The idea is that tables is created using the dbo.stg_p1 table to create tables to implement a
dimentional table to create views the answer the question of the CEO about the performance of
Desseret  First National Bank (DFNB)

LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
******************************************************************************************************************/

--VIEW

SELECT * FROM dbo.tblAccountFact;
SELECT * FROM dbo.tblAccountDim;
SELECT * FROM dbo.tblCustomerAccountDim;
SELECT * FROM dbo.tblCustomerBranchDim;
SELECT * FROM dbo.tblCustomerDim;
SELECT * FROM dbo.tblBranchDim;

SELECT * FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id;

--account_customer_branch
SELECT b.branch_code,c.cust_id,c.gender,a.acct_id,a.open_close_code,FORMAT(a.open_date,'yyyy') AS year_opened,FORMAT(a.close_date,'yyyy') AS year_closed FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id;



-- Number of customer by branch
SELECT b.branch_code,c.cust_id,c.gender FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id;

--Best account by branches
SELECT b.branch_code,a.acct_id FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id;


--Number of opened account by branches
SELECT b.branch_code, a.open_close_code FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id;

--Number of accounts opened by year

SELECT  FORMAT(a.open_date,'yyyy') AS year_opened, a.open_close_code FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id
ORDER BY year_opened ASC;

SELECT  FORMAT(a.open_date,'yyyy') AS [year_opened], COUNT(a.open_close_code) AS 'number_open_accounts' FROM
dbo.tblBranchDim b JOIN dbo.tblCustomerBranchDim cb
ON b.branch_id = cb.branch_id
JOIN dbo.tblCustomerDim c 
ON c.cust_id = cb.cust_id
JOIN dbo.tblAccountDim a 
ON a.acct_id=cb.cust_id
JOIN dbo.tblAccountFact acf 
ON acf.acct_id=a.acct_id
--WHERE a.open_close_code='C'
GROUP BY FORMAT(a.open_date,'yyyy')
ORDER BY year_opened ASC;

