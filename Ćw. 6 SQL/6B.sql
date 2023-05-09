--Tworzenie nowej bazy danych "firma"
CREATE DATABASE firma2;

USE firma2;

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

-- Wypelnianie tabel rekordami
INSERT INTO ksiegowosc.pracownicy VALUES (1, 'Adam', 'Pierwszy', 'Krakow ul. Mila 1/32', '323432654');
INSERT INTO ksiegowosc.pracownicy VALUES (2, 'Artur', 'Drugi', 'Krakow ul. Drewniana 2/35', '345678654');
INSERT INTO ksiegowosc.pracownicy VALUES (3, 'Agnieszka', 'Trzeci', 'Krakow ul. Olchowa 3/12', '485257090');
INSERT INTO ksiegowosc.pracownicy VALUES (4, 'Aleksandra', 'Czwarty', 'Krakow ul. Wislana 4/98', '469700866');
INSERT INTO ksiegowosc.pracownicy VALUES (5, 'Aleksander', 'Piaty', 'Krakow ul. Chrobrego 5/92', '687442908');
INSERT INTO ksiegowosc.pracownicy VALUES (6, 'Albert', 'Szosty', 'Krakow ul. Czarnuszki 6/45', '472940683');
INSERT INTO ksiegowosc.pracownicy VALUES (7, 'Aleksy', 'Siodmy', 'Krakow ul. Kremowa 7/94', '36496025');
INSERT INTO ksiegowosc.pracownicy VALUES (8, 'Anastazja', 'osmy', 'Krakow ul. Zolta 8/76', '748074579');
INSERT INTO ksiegowosc.pracownicy VALUES (9, 'Alojzy', 'Dziewiaty', 'Krakow ul. Jagielonska 78/18', '670907314');
INSERT INTO ksiegowosc.pracownicy VALUES (10, 'Alicja', 'Dziesiaty', 'Krakow ul. Grodzka 46/87', '987864687');
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
INSERT INTO ksiegowosc.premia VALUES(2, 'Bozonarodzeniowa', 100.00);
INSERT INTO ksiegowosc.premia VALUES(3, 'Gwiazdkowa', 100.00);
INSERT INTO ksiegowosc.premia VALUES(4, 'Wielkanocna', 50.00);
INSERT INTO ksiegowosc.premia VALUES(5, 'Wakacjowa', 500.00);
INSERT INTO ksiegowosc.premia VALUES(6, 'Motywacyjna', 200.00);
INSERT INTO ksiegowosc.premia VALUES(7, 'Najlepszy pracownik miesiaca', 2000.00);
INSERT INTO ksiegowosc.premia VALUES(8, 'Drugi najlepszy pracownik miesiaca', 1000.00);
INSERT INTO ksiegowosc.premia VALUES(9, 'Trzeci najlepszy pracownik miesiaca', 500.00);
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

--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj¹c do niego kierunkowy dla Polski w nawiasie (+48)
UPDATE ksiegowosc.pracownicy SET telefon = CONCAT('+48', telefon);
		--UPDATE ksiegowosc.pracownicy SET telefon = SUBSTRING(telefon, 4, 100);
		--SELECT * FROM ksiegowosc.pracownicy

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by³ myœlnikami wg wzoru: ‘555-222-333’ 
UPDATE ksiegowosc.pracownicy
SET telefon = STUFF(STUFF(SUBSTRING(telefon, 1, 9), 4, 0, '-'), 8, 0, '-');
		--SELECT * FROM ksiegowosc.pracownicy

--c) Wyœwietl dane pracownika, którego nazwisko jest najd³u¿sze, u¿ywaj¹c du¿ych liter
SELECT ksiegowosc.pracownicy.id_pracownika, UPPER(ksiegowosc.pracownicy.imie) AS imie, UPPER(ksiegowosc.pracownicy.nazwisko) AS nazwisko
FROM ksiegowosc.pracownicy
WHERE LEN(ksiegowosc.pracownicy.nazwisko) = (SELECT MAX(LEN(ksiegowosc.pracownicy.nazwisko)) FROM ksiegowosc.pracownicy)

--d) Wyœwietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5
SELECT HASHBYTES('md5', imie) AS imie, HASHBYTES('md5', nazwisko) AS nazwisko, HASHBYTES('md5', CAST(ksiegowosc.pensja.kwota AS VARCHAR(20))) AS pensja
FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji

--f) Wyœwietl pracowników, ich pensje oraz premie. Wykorzystaj z³¹czenie lewostronne.
SELECT ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.kwota AS pensja, ksiegowosc.premia.kwota AS premia, 
ksiegowosc.premia.kwota+ksiegowosc.pensja.kwota AS calkowite_wynagrodzenie
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premia.id_premii

-- g) Wygeneruj raport (zapytanie), które zwróci w wyniku treœæ wg poni¿szego szablonu:
--	  Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma³ pensjê ca³kowit¹ na kwotê 7540 z³, 
--	  gdzie wynagrodzenie zasadnicze wynosi³o: 5000 z³, premia: 2000 z³, nadgodziny: 540 z³

SELECT 'Pracownik ' + ksiegowosc.pracownicy.imie + ' ' +ksiegowosc.pracownicy.nazwisko
	+ ', w dniu ' + CAST(ksiegowosc.wynagrodzenie.dataa AS VARCHAR(20)) 
	+ ' otrzymal pensje calkowita, na kwote ' + CAST(ksiegowosc.pensja.kwota+ksiegowosc.premia.kwota+ksiegowosc.godziny.liczba_godzin*50 AS VARCHAR(20)) + ' zl, '
	+ 'gdzie wynagrodzenie zasadnicze wynosilo: ' + CAST(ksiegowosc.pensja.kwota AS VARCHAR(20)) + ' zl, '
	+ 'premia: ' + CAST(ksiegowosc.premia.kwota AS VARCHAR(20)) + ' zl, '
	+ 'nadgodziny: ' + CAST(ksiegowosc.godziny.liczba_godzin*50 AS VARCHAR(20)) + ' zl'
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premia.id_premii
LEFT JOIN ksiegowosc.godziny ON ksiegowosc.wynagrodzenie.id_godziny=ksiegowosc.godziny.id_godziny


