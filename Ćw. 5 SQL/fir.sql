--Tworzenie nowej bazy danych "firma"
CREATE DATABASE firma;

USE firma;

--Tworzenie nowego schematu "ksiegowosc"
CREATE SCHEMA ksiegowosc;

--Tworzenie tabel "pracownicy", "godziny", "pensja", "premia", "wynagrodzenie"
CREATE TABLE ksiegowosc.pracownicy (
id_pracownika INT PRIMARY KEY,
imie VARCHAR(30) NOT NULL,
nazwisko VARCHAR(30) NOT NULL,
adres VARCHAR(50),
telefon VARCHAR(13)
);
CREATE TABLE ksiegowosc.godziny (
id_godziny INT PRIMARY KEY,
dataa DATE NOT NULL,
liczba_godzin INT NOT NULL, 
id_pracownika INT NOT NULL
);
CREATE TABLE ksiegowosc.pensja (
id_pensji INT PRIMARY KEY,
stanowisko VARCHAR(50) NOT NULL,
kwota FLOAT NOT NULL
);
CREATE TABLE ksiegowosc.premia (
id_premii INT PRIMARY KEY,
rodzaj VARCHAR(50) NOT NULL,
kwota FLOAT NOT NULL, 
);
CREATE TABLE ksiegowosc.wynagrodzenie (
id_wynagrodzenia INT PRIMARY KEY,
dataa DATE NOT NULL,
id_pracownika INT NOT NULL,
id_godziny INT NOT NULL,
id_pensji INT NOT NULL,
id_premii INT NOT NULL
);

--Tworzenie kluczow obcych
ALTER TABLE ksiegowosc.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);

--Tworzenie opisow/komentarzy dla kazdej z tabeli
EXEC sys.sp_addextendedproperty
@name='Opis tabeli pracownicy - nazwa', 
@value='Opis tabeli pracownicy - wartosc',
@level0type='SCHEMA', 
@level0name='ksiegowosc',
@level1type='TABLE', 
@level1name='pracownicy'
GO
SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.pracownicy')
  AND minor_id = 0
  AND class = 1;

EXEC sys.sp_addextendedproperty
@name='Opis tabeli godziny - nazwa', 
@value='Opis tabeli godziny - wartosc',
@level0type='SCHEMA', 
@level0name='ksiegowosc',
@level1type='TABLE', 
@level1name='godziny'
GO
SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.godziny')
  AND minor_id = 0
  AND class = 1;

EXEC sys.sp_addextendedproperty
@name='Opis tabeli pensja - nazwa', 
@value='Opis tabeli pensja - wartosc',
@level0type='SCHEMA', 
@level0name='ksiegowosc',
@level1type='TABLE', 
@level1name='pensja'
GO
SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.pensja')
  AND minor_id = 0
  AND class = 1;

EXEC sys.sp_addextendedproperty
@name='Opis tabeli premia - nazwa', 
@value='Opis tabeli premia - wartosc',
@level0type='SCHEMA', 
@level0name='ksiegowosc',
@level1type='TABLE', 
@level1name='premia'
GO
SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.premia')
  AND minor_id = 0
  AND class = 1;

EXEC sys.sp_addextendedproperty
@name='Opis tabeli wynagrodzenie - nazwa', 
@value='Opis tabeli wynagrodzenie - wartosc',
@level0type='SCHEMA', 
@level0name='ksiegowosc',
@level1type='TABLE', 
@level1name='wynagrodzenie'
GO
SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.wynagrodzenie')
  AND minor_id = 0
  AND class = 1;

-- Wype³nianie tabel rekordami
INSERT INTO ksiegowosc.pracownicy VALUES (1, 'Adam', 'Pierwszy', 'Kraków ul. Mi³a 1/32', '+48 323432654');
INSERT INTO ksiegowosc.pracownicy VALUES (2, 'Artur', 'Drugi', 'Kraków ul. Drewniana 2/35', '+48 345678654');
INSERT INTO ksiegowosc.pracownicy VALUES (3, 'Agnieszka', 'Trzeci', 'Kraków ul. Olchowa 3/12', '+48 485257090');
INSERT INTO ksiegowosc.pracownicy VALUES (4, 'Aleksandra', 'Czwarty', 'Kraków ul. Wiœlana 4/98', '+48 469700866');
INSERT INTO ksiegowosc.pracownicy VALUES (5, 'Aleksander', 'Pi¹ty', 'Kraków ul. Chrobrego 5/92', '+48 687442908');
INSERT INTO ksiegowosc.pracownicy VALUES (6, 'Albert', 'Szósty', 'Kraków ul. Czarnuszki 6/45', '+48 472940683');
INSERT INTO ksiegowosc.pracownicy VALUES (7, 'Aleksy', 'Siódmy', 'Kraków ul. Kremowa 7/94', '+48 36496025');
INSERT INTO ksiegowosc.pracownicy VALUES (8, 'Anastazja', 'Ósmy', 'Kraków ul. Z³ota 8/76', '+48 748074579');
INSERT INTO ksiegowosc.pracownicy VALUES (9, 'Alojzy', 'Dziewi¹ty', 'Kraków ul. Jagieloñska 78/18', '+48 670907314');
INSERT INTO ksiegowosc.pracownicy VALUES (10, 'Alicja', 'Dziesi¹ty', 'Kraków ul. Grodzka 46/87', '+48 987864687');
		--SELECT * FROM ksiegowosc.pracownicy
INSERT INTO ksiegowosc.godziny VALUES (1, '2023-04-10', 1, 7);
INSERT INTO ksiegowosc.godziny VALUES (2, '2023-04-11', 2, 4);
INSERT INTO ksiegowosc.godziny VALUES (3, '2023-04-12', 3, 2);
INSERT INTO ksiegowosc.godziny VALUES (4, '2023-04-13', 4, 9);
INSERT INTO ksiegowosc.godziny VALUES (5, '2023-04-14', 5, 5);
INSERT INTO ksiegowosc.godziny VALUES (6, '2023-04-15', 6, 1);
INSERT INTO ksiegowosc.godziny VALUES (7, '2023-04-16', 7, 10);
INSERT INTO ksiegowosc.godziny VALUES (8, '2023-04-17', 8, 3);
INSERT INTO ksiegowosc.godziny VALUES (9, '2023-04-18', 9, 6);
INSERT INTO ksiegowosc.godziny VALUES (10, '2023-04-19', 10, 8);
		--SELECT * FROM ksiegowosc.godziny
INSERT INTO ksiegowosc.pensja VALUES(1, 'CEO', 9500.00);
INSERT INTO ksiegowosc.pensja VALUES(2, 'COO', 9000.00);
INSERT INTO ksiegowosc.pensja VALUES(3, 'CFO', 9000.00);
INSERT INTO ksiegowosc.pensja VALUES(4, 'CTO', 8700.00);
INSERT INTO ksiegowosc.pensja VALUES(5, 'CIO', 8200.00);
INSERT INTO ksiegowosc.pensja VALUES(6, 'CMO', 7400.00);
INSERT INTO ksiegowosc.pensja VALUES(7, 'CSO', 7000.00);
INSERT INTO ksiegowosc.pensja VALUES(8, 'CSM', 6600.00);
INSERT INTO ksiegowosc.pensja VALUES(9, 'HRM', 6000.00);
INSERT INTO ksiegowosc.pensja VALUES(10, 'KM', 5800.00);
		--SELECT * FROM ksiegowosc.pensja
INSERT INTO ksiegowosc.premia VALUES(1, 'Noworoczna', 1000.00);
INSERT INTO ksiegowosc.premia VALUES(2, 'Bo¿onarodzeniowa', 100.00);
INSERT INTO ksiegowosc.premia VALUES(3, 'Gwiazdkowa', 100.00);
INSERT INTO ksiegowosc.premia VALUES(4, 'Wielkanocna', 50.00);
INSERT INTO ksiegowosc.premia VALUES(5, 'Wakacjowa', 500.00);
INSERT INTO ksiegowosc.premia VALUES(6, 'Motywacyjna', 200.00);
INSERT INTO ksiegowosc.premia VALUES(7, 'Najlepszy pracownik miesi¹ca', 2000.00);
INSERT INTO ksiegowosc.premia VALUES(8, 'Drugi najlepszy pracownik miesi¹ca', 1000.00);
INSERT INTO ksiegowosc.premia VALUES(9, 'Trzeci najlepszy pracownik miesi¹ca', 500.00);
INSERT INTO ksiegowosc.premia VALUES(10, 'Walentynkowa', 200.00);
		--SELECT * FROM ksiegowosc.premia
INSERT INTO ksiegowosc.wynagrodzenie VALUES(1, '2023-04-27', 1, 2, 3, 4);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(2, '2023-04-10', 2, 3, 4, 5);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(3, '2023-04-10', 3, 4, 5, 6);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(4, '2023-04-10', 4, 5, 6, 7);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(5, '2023-04-10', 5, 6, 7, 8);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(6, '2023-04-10', 6, 7, 8, 9);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(7, '2023-04-10', 7, 8, 9, 10);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(8, '2023-04-10', 8, 9, 10, 1);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(9, '2023-04-10', 9, 10, 1, 2);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(10, '2023-04-10', 10, 1, 2, 3);
		--SELECT * FROM ksiegowosc.wynagrodzenie

-- a) Wyswietl id_pracownika i nazwisko
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

-- b) Wyswietl id_pracownika, tych ktorzy zarabiaja wiecej niz 1000
SELECT wynagrodzenie.id_pracownika, pensja.kwota
FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pensja 
ON wynagrodzenie.id_pensji =pensja.id_pensji
WHERE pensja.kwota>1000

-- c) Wyswietl id_pracownika nieposiadajacego premii, ktorego placa jest wieksza niz 2000
SELECT wynagrodzenie.id_pracownika, pensja.kwota, premia.rodzaj
FROM ksiegowosc.premia 
INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenie ON pensja.id_pensji=wynagrodzenie.id_pensji) 
ON premia.id_premii=wynagrodzenie.id_premii
WHERE pensja.kwota>2000 AND premia.rodzaj LIKE 'brak';

-- d) Wyswietl pracownikow, ktorych pierwsza litera imienia to J
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko
FROM ksiegowosc.pracownicy
WHERE pracownicy.imie LIKE 'J%'

-- e) Wyswietl pracownikow, ktorych nazwisko zawiera litere n, a imie konczy sie litera a
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko
FROM ksiegowosc.pracownicy
WHERE pracownicy.nazwisko LIKE '%a' AND pracownicy.nazwisko LIKE '%n%'

-- f) Wyswietl imie i nazwisko  pracownikow oraz liczbe ich nadgodzin (czyli wiecej niz 160)
SELECT pracownicy.imie, pracownicy.nazwisko, ksiegowosc.godziny.liczba_godzin-160 AS nadgodziny
FROM ksiegowosc.pracownicy 
INNER JOIN (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny=godziny.id_godziny) ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika
WHERE godziny.liczba_godzin-160>0

-- g) Wyswietl imie i nazwisko pracownikow, ktorych pensja wacha sie o 1500 do 3000
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota
FROM (ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji) 
INNER JOIN ksiegowosc.pracownicy 
ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika
WHERE pensja.kwota > 1500 AND pensja.kwota < 3000; --BETWEEN

-- h) Wyswietl imie i nazwisko pracownikow ktorzy pracowali nadgodzinowo i nie otrzymali premii
SELECT pracownicy.imie, pracownicy.nazwisko
FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.wynagrodzenie 
ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika 
INNER JOIN ksiegowosc.godziny 
ON wynagrodzenie.id_godziny=godziny.id_godziny 
INNER JOIN ksiegowosc.premia 
ON wynagrodzenie.id_premii=premia.id_premii 
WHERE godziny.liczba_godzin-160>0 AND premia.rodzaj LIKE 'brak premii'

-- i) Uszereguj pracownikow wedlug pensji
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota
FROM (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika)
INNER JOIN ksiegowosc.pensja 
ON wynagrodzenie.id_pensji=pensja.id_pensji
ORDER BY pensja.kwota;

-- j) Uszereguj pracownikow wedlug pensji i premii malejaco
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota, premia.kwota, zarobek=premia.kwota+pensja.kwota
FROM ((ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika)
	INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji) 
	INNER JOIN ksiegowosc.premia ON wynagrodzenie.id_premii=premia.id_premii
ORDER BY pensja.kwota+premia.kwota DESC

-- k) Zlicz i zgrupuj pracownikow wedlug pola stanowisko
SELECT pensja.stanowisko, COUNT(pensja.stanowisko) AS ilosc_osob
FROM (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika)
	INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji
GROUP BY pensja.stanowisko;

-- l) Policz srednia, minimalna i maksymalna place dla CEO
SELECT pensja.stanowisko, AVG(pensja.kwota) AS srednia, MIN(pensja.kwota) AS mini, MAX(pensja.kwota) AS maks
FROM ksiegowosc.pensja
WHERE pensja.stanowisko LIKE 'CEO'
GROUP BY pensja.stanowisko;

-- m) Policz sume wszystkich wynagrodzen
SELECT SUM(pensja.kwota + premia.kwota) as Pensje_i_Premie, SUM(pensja.kwota) AS Calk_pensje, SUM(premia.kwota) AS Calk_premia
FROM (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji)
	INNER JOIN ksiegowosc.premia ON wynagrodzenie.id_premii=premia.id_premii;

-- n) Policz sume wynagrodzen w ramach danego stanowiska
SELECT pensja.stanowisko, SUM(pensja.kwota) AS wynagrodzenie_na_stanowisku
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensja 
ON wynagrodzenie.id_pensji=pensja.id_pensji
GROUP BY pensja.stanowisko;

--o) Wyznacz liczbe premii przyznanych dla pracownikow danego stanowiska
SELECT pensja.stanowisko, COUNT(premia.kwota) AS Liczba_premii
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji
	INNER JOIN ksiegowosc.premia ON wynagrodzenie.id_premii=premia.id_premii
GROUP BY pensja.stanowisko;

-- p) Usuñ pracownikow majacych pensje mniejsza niz 1200
DELETE ksiegowosc.pracownicy
	FROM ksiegowosc.wynagrodzenie 
	INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika
	INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji
	WHERE pensja.kwota<1200;

