USE AdventureWorks2019;

--ZAD 1 Napisz procedure wypisuj¹ca do konsoli ciag Fibonacciego. 
--		Procedura musi przyjmowac jako argument wejsciowy liczbê n. 
--		Generowanie ciagu Fibonacciego musi zostac zaimplementowane jako osobna funkcja, wywolywana przez procedure.


-- Jesli istnieje procedura wypisywanie_fibonacci to ja usuwa. (nie wyszukuje funkcji REPLACE i podobnych)
IF OBJECT_ID('wypisywanie_fibonacci', 'P') IS NOT NULL
    DROP PROCEDURE wypisywanie_fibonacci;
-- Jesli istnieje funkcja tworzenie_fibonacci to ja usuwa.
IF OBJECT_ID('tworzenie_fibonacci', 'FN') IS NOT NULL
    DROP FUNCTION tworzenie_fibonacci;

-- Procedura tworzaca ciag fibonacciego z n elementow
CREATE PROCEDURE wypisywanie_fibonacci (@n INT)
AS
BEGIN
	DECLARE @pierwszy INT;
	DECLARE @drugi INT;
	DECLARE @suma INT;
	DECLARE @iterator INT;
	SET @pierwszy = 0;
	SET @drugi = 1;
	SET @iterator = 3;	-- bo 1 i 2 wyraz sa znane
	PRINT @pierwszy;
	PRINT @drugi;
	WHILE ( @iterator <= @n )
	BEGIN
		SET @suma = (SELECT dbo.tworzenie_fibonacci(@pierwszy, @drugi));
		PRINT @suma;
		SET @pierwszy = @drugi;
		SET @drugi = @suma;
		SET @iterator = @iterator + 1;
	END;
END;


EXEC wypisywanie_fibonacci @n = 20;

-- funkcja generujaca wyrazy
CREATE FUNCTION tworzenie_fibonacci(@pierwsza INT, @druga INT)
RETURNS INT
AS
BEGIN
	RETURN @pierwsza + @druga;
END;



-- ZAD 2 Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons, zmodyfikuje nazwisko tak, aby bylo napisane duzymi literami. 

CREATE TRIGGER upp
ON Person.Person
AFTER INSERT,
UPDATE
AS
BEGIN
	UPDATE Person.Person SET LastName = UPPER(LastName) FROM Person.Person
END;

INSERT INTO Person.BusinessEntity(rowguid)
VALUES(NEWID());

INSERT INTO Person.Person (BusinessEntityID, PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, 
	EmailPromotion, AdditionalContactInfo, ModifiedDate)
VALUES (20779, 'EM', 0, 'Mr.', 'filip', 'filip', 'filippp', NULL, 2, NULL, 2008-01-24);

SELECT * FROM Person.Person WHERE BusinessEntityID = 20779;

INSERT INTO Person.Person (BusinessEntityID, PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, 
	EmailPromotion, AdditionalContactInfo, ModifiedDate)
VALUES (20780, 'EM', 0, 'Mr.', 'filip', 'filip', 'filcerf', NULL, 2, NULL, 2008-01-24);

SELECT * FROM Person.Person WHERE BusinessEntityID = 20780;

-- ZAD 3 Przygotuj trigger ‘taxRateMonitoring’, który wywwietli komunikat o bledzie, 
--		 jezeli nastapi zmiana wartosci w polu ‘TaxRate’o wiecej niz 30%.

CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER INSERT, DELETE,
UPDATE
AS
BEGIN
	DECLARE @new FLOAT;
	DECLARE @old FLOAT;
	SELECT @new = TaxRate FROM INSERTED;
	SELECT @old =TaxRate FROM DELETED;
	IF (@new > 1.3 * @old OR @new < 0.7 * @old)
		PRINT 'ERRRORRR'
END;

UPDATE Sales.SalesTaxRate
SET TaxRate = 100
WHERE SalesTaxRateID = 1;

SELECT * FROM Sales.SalesTaxRate