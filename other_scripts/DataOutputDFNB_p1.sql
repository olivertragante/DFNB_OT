/*****************************************************************************************************************
NAME:    dbo.stg_p1
PURPOSE: Create the tables for dimentional tables and implement views

SUPPORT: Oliver Tragante
         olivertragante@gmail.com

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       07/03/2021   Oliver Tragante      1. Create tables to implement a dimentional model in MSSQL server.
1.1       07/03/2021   Oliver Tragante      2. Create two views for transaction tables.



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

-- 1) account_customer_branch
SELECT v.branch_code AS 'Branch Code'
	 , v.branch_desc AS 'Branch Name'
     , v.cust_id AS 'Customer ID'
     , v.gender AS 'Gender'
     , v.acct_id AS 'Account ID'
	 , v.loan_amt AS 'Loan Amount'
     , v.open_close_code AS 'Status Account'
     , v.year_opened AS 'Account Year Opened'
     , v.year_closed AS 'Account Year Closed'
  FROM dbo.v_account_customer_branch AS v;

-- 2) Account Branches
SELECT v.branch_code AS 'Branch Code'
     , v.acct_id AS 'Account ID'
  FROM dbo.v_account_branches AS v;

-- 3) Account Open Close by Year
SELECT v.year_opened AS 'Year'  
     , v.number_open_accounts AS 'Opened Accounts'
  FROM dbo.v_account_open_close_year AS v;

-- 4) Open Close Account Branches
SELECT v.branch_code AS 'Branch Code'
     , v.open_close_code AS 'Open Close Accounts'
  FROM dbo.v_open_close_account_branches AS v;

  /***** Project 2*/

--5) Transaction Current Performance
SELECT v.tran_id AS 'Transaction ID'
     , tran_date AS 'Transaction Date'
     , tran_amt AS 'Transaction Amount'
     , tran_fee_prct AS 'Transaction Fee Percentage'
     , tran_fee_amt AS 'Transaction Fee Amount'
     , tran_type_desc AS 'Transaction Type Description'
     , acct_id AS 'Account ID'
     , branch_desc AS 'Branch ID'
  FROM dbo.v_transaction_current_performance AS v;

--6)  Transaction Fee Amount Performance
SELECT tran_year AS 'Transaction Year'
     , total_tran_fee_amt AS 'Total Transactions Fee Amount'
     , branch_desc AS 'Branch Description'
  FROM dbo.v_transaction_fee_amount_performance;

--7)  Type transaction Performance
SELECT tran_type_desc AS 'Transaction Type Description'
     , total_tran_amt AS 'Total Transaction Amount'
  FROM dbo.v_type_transaction_performance;

/*******Project 3**********/
--8)  Customer Account Branch Summary
SELECT v.branch_id AS 'Branch ID'
     , v.branch_desc AS 'Branch Description'
     , v.branch_code AS 'Branch Code'
     , v.cust_id AS 'Customer ID'
     , v.open_date AS 'Open Date'
     , v.close_date AS 'Close Date'
     , v.open_close_code AS 'Open Close Code'
  FROM dbo.v_branch_cust_acct_summary AS v;

--9) Branch Transaction Type Summary
SELECT v.branch_code AS 'Branch Code'
     , v.branch_desc AS 'Branch Description'
     , v.tran_date AS 'Transaction Date'
     , v.tran_id AS 'Transaction ID'
     , v.tran_type_id AS 'Transaction Type ID'
     , v.tran_type_code AS 'Transaction Type Code'
     , v.tran_type_desc AS 'Transaction Type Description'
  FROM dbo.v_branch_tran_type_summary AS v;
