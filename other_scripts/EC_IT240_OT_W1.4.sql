USE AdventureWorks2017;

--SELECT * FROM Sales.SalesOrderHeader;
--SELECT * FROM Sales.SalesOrderDetail;
--SELECT * FROM Production.Product;

SELECT * FROM Sales.SalesOrderHeader;
SELECT * FROM Sales.SalesOrderDetail;
SELECT * FROM Production.Product;



--Q1: By Order Quantity, what were the five most popular products sold in 2014?
-- A1 The are listed as:
--2014	782	Mountain-200 Black, 38	BK-M68B-38	Black	326	619	1045214.639668
--2014	779	Mountain-200 Silver, 38	BK-M68S-38	Silver	301	508	912463.202952
--2014	783	Mountain-200 Black, 42	BK-M68B-42	Black	303	513	909303.495876
--2014	780	Mountain-200 Silver, 42	BK-M68S-42	Silver	267	441	797855.696952
--2014	781	Mountain-200 Silver, 46	BK-M68S-46	Silver	273	432	792630.151476

SELECT TOP (5) FORMAT(soh.OrderDate, 'yyyy') AS Order_Date_Year, 
               sod.ProductID, 
               p.Name, 
               p.ProductNumber, 
               p.Color, 
               COUNT(sod.SalesOrderID) AS Sales_Order_Count, 
               SUM(sod.OrderQty) AS Order_Quantity, 
               SUM(sod.LineTotal) AS Sales_Order_Line_Total
FROM Production.Product p
     INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
     INNER JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE FORMAT(soh.OrderDate, 'yyyy') = '2014'
GROUP BY sod.ProductID, 
         p.Name, 
         p.ProductNumber, 
         p.Color, 
         FORMAT(soh.OrderDate, 'yyyy')
ORDER BY Sales_Order_Line_Total DESC;

--Q2: How long are the 7 longest Person names and to whom do they belong? Rank by 
-- Full Name length, Last Name Length, First Name Length
--Janaina Barreiro Gambaro  Bueno	31	Janaina Barreiro Gambaro	24	NULL	Bueno	5
--Osarumwense Uwaifiokun Agbonile	31	Osarumwense	11	Uwaifiokun	Agbonile	8
--Alvaro  De Matos Miranda Filho	30	Alvaro	6	NULL	De Matos Miranda Filho	22
--Janaina Barreiro Gambaro Bueno	30	Janaina	7	Barreiro Gambaro	Bueno	5
--Ranjit Rudra Varkey Chudukatil	30	Ranjit	6	Rudra	Varkey Chudukatil	17
--Francisco  Javier Castrejón	27	Francisco	9	NULL	Javier Castrejón	16
--Paulo Sergio Da Silva Pinto	27	Paulo	5	Sergio Da Silva	Pinto	5

SELECT 
	   --TOP(7) p.BusinessEntityID,
	   DISTINCT TOP(7) CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName) AS Full_Name, 
       LEN(CONCAT(p.FirstName, ' ', p.MiddleName, ' ', p.LastName)) AS Full_Name_Length,
	   p.FirstName,
	   LEN(p.FirstName) AS First_Name_Length,
	   p.MiddleName,
	   p.LastName,
	   LEN(p.LastName) AS Last_Name_Length
FROM Person.Person p
ORDER BY Full_Name_Length DESC

--Q3: Which Department pays its female workers on average the most per year?
--16	Executive	F	283610.688	3	94536.896


SELECT d.DepartmentID, 
       d.Name, 
       e.Gender, 
       SUM(eph.Rate * 8 * 20 * 12) AS Total_Yearly_Pay, 
       COUNT(eph.BusinessEntityID) AS Business_Entity_ID_Count, 
       AVG(eph.Rate * 8 * 20 * 12) AS Average_Yearly_Pay
FROM HumanResources.Employee e
     INNER JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
     INNER JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
     INNER JOIN HumanResources.EmployeePayHistory eph ON e.BusinessEntityID = eph.BusinessEntityID
WHERE e.Gender = 'F'
GROUP BY d.DepartmentID, 
         d.Name, 
         e.Gender
ORDER BY Average_Yearly_Pay DESC;