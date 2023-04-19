--Tworzenie nowej bazy danych "firma"
CREATE DATABASE firma;

USE firma;

--Tworzenie nowego schematu "rozliczenia"
CREATE SCHEMA rozliczenia;

--Tworzenie tabel "rozliczenia", "godziny", "pensje", "premie"
CREATE TABLE rozliczenia.pracownicy (
id_pracownika INT PRIMARY KEY,
imie VARCHAR(30) NOT NULL,
nazwisko VARCHAR(30) NOT NULL,
adres VARCHAR(50) NOT NULL,
telefon VARCHAR(13) NOT NULL
);
CREATE TABLE rozliczenia.godziny (
id_godziny INT PRIMARY KEY,
dataa DATE NOT NULL,
liczba_godzin INT NOT NULL, 
id_pracownika INT NOT NULL
);
CREATE TABLE rozliczenia.pensje (
id_pensji INT PRIMARY KEY,
stanowisko VARCHAR(20) NOT NULL,
kwota FLOAT NOT NULL, 
id_premii INT
);
CREATE TABLE rozliczenia.premie (
id_premii INT PRIMARY KEY,
rodzaj VARCHAR(50) NOT NULL,
kwota FLOAT NOT NULL, 
);

--Tworzenie kluczów obcych
ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

-- Wype³nianie tabel rekordami
INSERT INTO rozliczenia.pracownicy VALUES (1, 'Adam', 'Pierwszy', 'Kraków ul. Mi³a 1/32', '+48 323432654');
INSERT INTO rozliczenia.pracownicy VALUES (2, 'Artur', 'Drugi', 'Kraków ul. Drewniana 2/35', '+48 345678654');
INSERT INTO rozliczenia.pracownicy VALUES (3, 'Agnieszka', 'Trzeci', 'Kraków ul. Olchowa 3/12', '+48 485257090');
INSERT INTO rozliczenia.pracownicy VALUES (4, 'Aleksandra', 'Czwarty', 'Kraków ul. Wiœlana 4/98', '+48 469700866');
INSERT INTO rozliczenia.pracownicy VALUES (5, 'Aleksander', 'Pi¹ty', 'Kraków ul. Chrobrego 5/92', '+48 687442908');
INSERT INTO rozliczenia.pracownicy VALUES (6, 'Albert', 'Szósty', 'Kraków ul. Czarnuszki 6/45', '+48 472940683');
INSERT INTO rozliczenia.pracownicy VALUES (7, 'Aleksy', 'Siódmy', 'Kraków ul. Kremowa 7/94', '+48 36496025');
INSERT INTO rozliczenia.pracownicy VALUES (8, 'Anastazja', 'Ósmy', 'Kraków ul. Z³ota 8/76', '+48 748074579');
INSERT INTO rozliczenia.pracownicy VALUES (9, 'Alojzy', 'Dziewi¹ty', 'Kraków ul. Jagieloñska 78/18', '+48 670907314');
INSERT INTO rozliczenia.pracownicy VALUES (10, 'Alicja', 'Dziesi¹ty', 'Kraków ul. Grodzka 46/87', '+48 987864687');
		--SELECT * FROM rozliczenia.pracownicy 
INSERT INTO rozliczenia.godziny VALUES (1, '2023-04-10', 1, 7);
INSERT INTO rozliczenia.godziny VALUES (2, '2023-04-11', 2, 4);
INSERT INTO rozliczenia.godziny VALUES (3, '2023-04-12', 3, 2);
INSERT INTO rozliczenia.godziny VALUES (4, '2023-04-13', 4, 9);
INSERT INTO rozliczenia.godziny VALUES (5, '2023-04-14', 5, 5);
INSERT INTO rozliczenia.godziny VALUES (6, '2023-04-15', 6, 1);
INSERT INTO rozliczenia.godziny VALUES (7, '2023-04-16', 7, 10);
INSERT INTO rozliczenia.godziny VALUES (8, '2023-04-17', 8, 3);
INSERT INTO rozliczenia.godziny VALUES (9, '2023-04-18', 9, 6);
INSERT INTO rozliczenia.godziny VALUES (10, '2023-04-19', 10, 8);
		--SELECT * FROM rozliczenia.godziny
INSERT INTO rozliczenia.pensje VALUES(1, 'CEO', 9500.00, 1);
INSERT INTO rozliczenia.pensje VALUES(2, 'COO', 9000.00, 8);
INSERT INTO rozliczenia.pensje VALUES(3, 'CFO', 9000.00, 4);
INSERT INTO rozliczenia.pensje VALUES(4, 'CTO', 8700.00, 10);
INSERT INTO rozliczenia.pensje VALUES(5, 'CIO', 8200.00, 7);
INSERT INTO rozliczenia.pensje VALUES(6, 'CMO', 7400.00, 6);
INSERT INTO rozliczenia.pensje VALUES(7, 'CSO', 7000.00, 3);
INSERT INTO rozliczenia.pensje VALUES(8, 'CSM', 6600.00, 2);
INSERT INTO rozliczenia.pensje VALUES(9, 'HRM', 6000.00, 5);
INSERT INTO rozliczenia.pensje VALUES(10, 'KM', 5800.00, 9);
		--SELECT * FROM rozliczenia.pensje
INSERT INTO rozliczenia.premie VALUES(1, 'Noworoczna', 1000.00);
INSERT INTO rozliczenia.premie VALUES(2, 'Bo¿onarodzeniowa', 100.00);
INSERT INTO rozliczenia.premie VALUES(3, 'Gwiazdkowa', 100.00);
INSERT INTO rozliczenia.premie VALUES(4, 'Wielkanocna', 50.00);
INSERT INTO rozliczenia.premie VALUES(5, 'Wakacjowa', 500.00);
INSERT INTO rozliczenia.premie VALUES(6, 'Motywacyjna', 200.00);
INSERT INTO rozliczenia.premie VALUES(7, 'Najlepszy pracownik miesi¹ca', 2000.00);
INSERT INTO rozliczenia.premie VALUES(8, 'Drugi najlepszy pracownik miesi¹ca', 1000.00);
INSERT INTO rozliczenia.premie VALUES(9, 'Trzeci najlepszy pracownik miesi¹ca', 500.00);
INSERT INTO rozliczenia.premie VALUES(10, 'Walentynkowa', 200.00);
		--SELECT * FROM rozliczenia.premie

--Wyœwietlanie nazwisk i adresów pracowników
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--Konwersja daty w tabeli godziny, aby wyœwietlana by³a informacja o dniu tygodnia i miesi¹cu
SELECT DATEPART (WEEKDAY, dataa) AS 'dzieñ tygodnia', DATEPART (MONTH, dataa) AS 'miesi¹c' FROM rozliczenia.godziny;

--Zmiana: kwota -> kwota brutto, oraz dodanie i obliczenie kwota_netto
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwotabrutto', 'COLUMN'; --Zmiana nazwy: kwota -> kwota brutto
ALTER TABLE rozliczenia.pensje ADD kwotanetto FLOAT; --Dodanie kolumny kwota netto
UPDATE rozliczenia.pensje SET kwotanetto=kwotabrutto*0.81;

