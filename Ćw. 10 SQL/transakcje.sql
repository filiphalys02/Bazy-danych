USE AdventureWorks2019;

-- ZAD 1 - Napisz zapytanie, ktore wykorzystuje transakcje (zaczyna ja),
--		   a nastepnie aktualizuje cene produktu o ProductID równym 680 w tabeli Production.Product o 10%
--		   i nastepnie zatwierdza transakcje.

SELECT * FROM Production.Product WHERE ProductID = 680;

BEGIN TRAN trans1;
UPDATE Production.Product SET ListPrice=ListPrice*1.1
WHERE ProductID = 680
COMMIT TRAN trans1;

-- ZAD 2 - Napisz zapytanie, ktore zaczyna transakcje, 
--		   usuwa produkt o ProductID rownym 707 z tabeli Production.Product,
--		   ale nastepnie wycofuje transakcje.

-- usuwa klucze zeby moc usunac wiersz
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";

BEGIN TRAN trans2;
DELETE FROM Production.Product
WHERE ProductID=707
PRINT 'usunieto'
ROLLBACK TRAN trans2;

SELECT * FROM Production.Product WHERE ProductID=707;

-- ZAD 3 - Napisz zapytanie, ktore zaczyna transakcje, 
--		   dodaje nowy produkt do tabeli Production.Product, a nastepnie zatwierdza transakcje.

-- wlacza reczne modyfikowanie tabeli
SET IDENTITY_INSERT Production.Product ON;

BEGIN TRANSACTION;
INSERT INTO Production.Product(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,DaysToManufacture,SellStartDate,ModifiedDate)
VALUES(5, 'Moj', 'AA-9998', 0, 0, NULL, 1000, 375, 0.00, 0.00, 1, '2013-06-01 00:00:00.000', '2014-06-01 10:00:50.000');
COMMIT TRANSACTION;

SELECT * FROM Production.Product
ORDER BY ProductID

-- ZAD 4 - Napisz zapytanie, ktore zaczyna transakcje 
--		   i aktualizuje StandardCost wszystkich produktow w tabeli Production.Product o 10%,
--		   jezeli suma wszystkich StandardCost po aktualizacji nie przekracza 50000.
--	       W przeciwnym razie zapytanie powinno wycofac transakcje.

BEGIN TRANSACTION;
UPDATE Production.Product
SET StandardCost=StandardCost*1.1
IF (SELECT SUM(StandardCost) FROM Production.Product) <= 50000
	BEGIN
		COMMIT TRANSACTION
	END;
ELSE
	BEGIN
		ROLLBACK TRANSACTION
	END;

SELECT SUM(StandardCost) FROM Production.Product;

-- ZAD 5 - Napisz zapytanie SQL, ktore zaczyna transakcje i próbuje dodac nowy produkt do tabeli Production.Product.
--		   Jesli ProductNumber juz istnieje w tabeli, zapytanie powinno wycofac transakcje.

SET IDENTITY_INSERT Production.Product ON

BEGIN TRANSACTION;
IF EXISTS (SELECT * FROM Production.Product WHERE ProductID=6)
	BEGIN
		PRINT 'NIE MOZNA DODAC'
		ROLLBACK TRANSACTION
	END;
ELSE
	BEGIN
		INSERT INTO Production.Product(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,DaysToManufacture,SellStartDate,ModifiedDate)
		VALUES(6, 'Moj2', 'AA-9997', 0, 0, NULL, 1000, 375, 0.00, 0.00, 1, '2013-06-02 00:00:00.000', '2014-06-02 10:00:50.000');
		COMMIT TRANSACTION
	END;

SELECT * FROM Production.Product;

-- ZAD 6 - Napisz zapytanie SQL, ktore zaczyna transakcje i aktualizuje wartosc OrderQty dla kazdego zamowienia w tabeli Sales.SalesOrderDetail.
--		   Jezeli ktorykolwiek z zamowien ma OrderQty rowna 0, zapytanie powinno wycofac transakcje.

SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty=0;

BEGIN TRANSACTION;
IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
	BEGIN
		PRINT 'TRANSAKCJA WYCOFANA'
		ROLLBACK TRANSACTION
	END;
ELSE
	BEGIN
		UPDATE Sales.SalesOrderDetail
		SET OrderQty = OrderQty + 1
		PRINT 'WSZYSTKO W PORZADKU'
		COMMIT TRANSACTION
	END;

-- ZAD 7 - Napisz zapytanie SQL, ktore zaczyna transakcje i usuwa wszystkie produkty, 
--		   ktorych StandardCost jest wyzszy niz sredni koszt wszystkich produktow w tabeli Production.Product. 
--		   Jezeli liczba produktow do usuniecia przekracza 10, zapytanie powinno wycofac transakcje

SELECT AVG(StandardCost) AS srednia FROM Production.Product
SELECT StandardCost FROM Production.Product WHERE StandardCost > (SELECT AVG(StandardCost) FROM Production.Product);

BEGIN TRANSACTION;
DELETE FROM Production.Product
WHERE StandardCost > (SELECT AVG(StandardCost) FROM Production.Product);
IF @@ROWCOUNT > 10
	BEGIN
		PRINT 'TRANSAKCJA WYCOFANA';
		ROLLBACK TRANSACTION;
	END;
ELSE
	BEGIN
		PRINT 'WSZYSTKO W PORZADKU';
		COMMIT TRANSACTION;
	END;
