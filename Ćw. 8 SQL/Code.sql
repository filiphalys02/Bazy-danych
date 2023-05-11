--ZAD 1
--Wykorzystujac wyrazenie CTE zbuduj zapytanie, ktore znajdzie informacje na temat stawki pracownika oraz jego danych, 
--a nastepnie zapisze je do tabeli tymczasowej TempEmployeeInfo. Rozwi¹¿ w oparciu o AdventureWorks.

USE AdventureWorks2019

SELECT * FROM AdventureWorks2019.Person.Person
SELECT * FROM AdventureWorks2019.HumanResources.EmployeePayHistory

WITH moja (id, imie, nazwisko, zarobek) 
AS
(
	SELECT p.BusinessEntityID, FirstName, LastName, Rate
	FROM AdventureWorks2019.Person.Person p
	INNER JOIN AdventureWorks2019.HumanResources.EmployeePayHistory e
	ON p.BusinessEntityID=e.BusinessEntityID
)
SELECT * INTO TempEmployeeInfo FROM moja;
SELECT * FROM TempEmployeeInfo;

SELECT * FROM AdventureWorks2019.HumanResources.EmployeePayHistory


--ZAD 2
--Uzyskaj informacje na temat przychodow ze sprzedazy wedlug firmy i kontaktu (za pomoc¹ CTE i bazy AdventureWorksL).

SELECT *FROM SalesLT.SalesOrderHeader;
SELECT *FROM SalesLT.Customer;

USE AdventureWorksLT2019

WITH moja2 (CompanyContact, Revenue)
AS 
(
	SELECT CONCAT( CompanyName, ' (', FirstName, ' ', LastName, ')' ), TotalDue
	FROM SalesLT.Customer c
	INNER JOIN SalesLT.SalesOrderHeader s
	ON c.CustomerID=s.CustomerID
)
SELECT * FROM moja2

--ZAD 3
--Napisz zapytanie, które zwroci wartosc sprzedazy dla poszczegolnych kategorii produktow. Wykorzystaj CTE i baze AdventureWorksLT.

USE AdventureWorksLT2019

SELECT * FROM SalesLT.ProductCategory
SELECT * FROM SalesLT.Product
SELECT * FROM SalesLT.SalesOrderDetail

WITH moja3 (Category, SalesValue)
AS
(
	SELECT c.Name, UnitPrice
	FROM SalesLT.Product p
	INNER JOIN SalesLT.ProductCategory c
	ON p.ProductCategoryID=c.ProductCategoryID
	INNER JOIN SalesLT.SalesOrderDetail o
	ON p.ProductID=o.ProductID
)
--SELECT * FROM moja3
SELECT Category, SUM(SalesValue) AS SalesValue
FROM moja3 
GROUP BY Category
--ORDER BY Category
