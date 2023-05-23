-- ZAD 1 stomatologia
CREATE DATABASE zaklad_stomatologiczny;

USE zaklad_stomatologiczny;

CREATE SCHEMA stomatologia;
	
CREATE TABLE stomatologia.pacjenci (
ID_pacjenta VARCHAR(5) PRIMARY KEY NOT NULL,
imie VARCHAR(30) NOT NULL,
nazwisko VARCHAR(30) NOT NULL
);

CREATE TABLE stomatologia.pracownicy (
ID_pracownika VARCHAR(5) PRIMARY KEY NOT NULL,
imie VARCHAR(30) NOT NULL,
nazwisko VARCHAR(30) NOT NULL
)

CREATE TABLE stomatologia.zabiegi (
ID_zabiegu VARCHAR(5) PRIMARY KEY NOT NULL,
NazwaZabiegu VARCHAR(30) NOT NULL
)

CREATE TABLE stomatologia.wizyty (
DataGodzinaWizyty DATETIME PRIMARY KEY NOT NULL,
ID_zabiegu VARCHAR(5) NOT NULL,
ID_pracownika VARCHAR(5) NOT NULL,
ID_pacjenta VARCHAR(5) NOT NULL
)

ALTER TABLE stomatologia.wizyty
ADD FOREIGN KEY (ID_zabiegu) REFERENCES stomatologia.zabiegi(ID_zabiegu)

ALTER TABLE stomatologia.wizyty
ADD FOREIGN KEY (ID_pacjenta) REFERENCES stomatologia.pacjenci(ID_pacjenta)

ALTER TABLE stomatologia.wizyty
ADD FOREIGN KEY (ID_pracownika) REFERENCES stomatologia.pracownicy(ID_pracownika)

INSERT INTO stomatologia.pacjenci VALUES ('P100', 'Anna', 'Jeleñ')
INSERT INTO stomatologia.pacjenci VALUES ('P105', 'Jaros³aw', 'Nicpoñ')
INSERT INTO stomatologia.pacjenci VALUES ('P108', 'Joanna', 'Nosek')
INSERT INTO stomatologia.pacjenci VALUES ('P120', 'Jan', 'Ka³u¿a')
INSERT INTO stomatologia.pacjenci VALUES ('P130', 'Jerzy', 'Lis')
INSERT INTO stomatologia.pacjenci VALUES ('P123', 'Olga', 'Nowacka')
SELECT * FROM stomatologia.pacjenci

INSERT INTO stomatologia.pracownicy VALUES ('S1011', 'Maria', 'Nowak')
INSERT INTO stomatologia.pracownicy VALUES ('S1024', 'Jan', 'Kowalski')
INSERT INTO stomatologia.pracownicy VALUES ('S1045', 'Anna', 'Jab³oñska')
INSERT INTO stomatologia.pracownicy VALUES ('S1034', 'Marek','Potocki')
SELECT * FROM stomatologia.pracownicy

INSERT INTO stomatologia.zabiegi VALUES ('Z500', 'Borowanie')
INSERT INTO stomatologia.zabiegi VALUES ('Z496', 'Lakowanie')
INSERT INTO stomatologia.zabiegi VALUES ('Z503', 'Usuwanie kamienia')
SELECT * FROM stomatologia.zabiegi

INSERT INTO stomatologia.wizyty VALUES ('2020-03-12 10:00', 'Z500', 'S1011', 'P100')
INSERT INTO stomatologia.wizyty VALUES ('2020-03-12 13:00', 'Z496', 'S1011', 'P105')
INSERT INTO stomatologia.wizyty VALUES ('2020-03-14 10:00', 'Z500', 'S1011', 'P108')
INSERT INTO stomatologia.wizyty VALUES ('2020-03-16 17:00', 'Z503', 'S1024', 'P108')
INSERT INTO stomatologia.wizyty VALUES ('2020-03-18 09:00', 'Z500', 'S1045', 'P120')
INSERT INTO stomatologia.wizyty VALUES ('2020-03-20 08:00', 'Z496', 'S1034', 'P130')
INSERT INTO stomatologia.wizyty VALUES ('2020-03-12 15:00', 'Z503', 'S1034', 'P123')
SELECT * FROM stomatologia.wizyty 

-- wyswietlenie mojej bazy w formie tabeli przed normalizacja
SELECT
p.ID_pracownika,
CONCAT(p.imie, ' ', p.nazwisko) AS NazwaLekarza,
w.ID_pacjenta,
CONCAT(pa.imie, ' ', pa.nazwisko) AS NazwaPacjenta,
w.DataGodzinaWizyty,
w.ID_zabiegu,
z.NazwaZabiegu
FROM
stomatologia.wizyty w
JOIN stomatologia.pracownicy p ON w.ID_pracownika = p.ID_pracownika
JOIN stomatologia.pacjenci pa ON w.ID_pacjenta = pa.ID_pacjenta
JOIN stomatologia.zabiegi z ON w.ID_zabiegu = z.ID_zabiegu;
