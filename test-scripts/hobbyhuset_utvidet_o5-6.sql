
-- Hobbyhuset database script for PostgreSQL (Extended Version)
-- Adds new columns and NULL values to illustrate specific SQL concepts.

-- Først, kjør det originale hobbyhuset.sql skriptet for å opprette og fylle databasen.
-- Deretter, kjør dette skriptet for å utvide modellen.

-- Legg til en 'Bonus'-kolonne i Ansatt-tabellen
ALTER TABLE Ansatt ADD COLUMN Bonus DECIMAL(8,2);

-- Legg til en 'Telefon'-kolonne i Kunde-tabellen
ALTER TABLE Kunde ADD COLUMN Telefon VARCHAR(20);

-- Legg til en 'ErBetalt' BOOLEAN-kolonne i Ordre-tabellen for å illustrere tre-verdi logikk
ALTER TABLE Ordre ADD COLUMN ErBetalt BOOLEAN;

-- Oppdater noen rader for å inkludere NULL og non-NULL verdier
UPDATE Ansatt SET Bonus = 10000.00 WHERE AnsNr IN (1, 3, 7);
UPDATE Ansatt SET Bonus = 5000.00 WHERE AnsNr IN (2, 8);

UPDATE Kunde SET Telefon = '91234567' WHERE KNr IN (5009, 5082, 5122);
UPDATE Kunde SET Telefon = '41234567' WHERE KNr IN (5129, 5042);

-- Oppdater ErBetalt-kolonnen for å illustrere tre-verdi logikk
UPDATE Ordre SET ErBetalt = TRUE WHERE BetaltDato IS NOT NULL;
UPDATE Ordre SET ErBetalt = FALSE WHERE BetaltDato IS NULL AND SendtDato IS NOT NULL;
UPDATE Ordre SET ErBetalt = NULL WHERE OrdreNr % 10 = 0;

-- Del 2 spørringer
-- 1.  Finn alle data om alle kunder. Vis kun de 20 siste fra resultatrelasjonen (tips: bruke delspørring).
SELECT * FROM (
    SELECT * FROM Kunde ORDER BY KNr DESC LIMIT 20
) AS Subquery;

-- 2.  Finn fornavn og etternavn til alle ansatte. Vis kun de 10 første radene fra resultatrelasjonen.
SELECT Fornavn, Etternavn FROM Ansatt ORDER BY AnsNr ASC LIMIT 10;

-- 3.  Finn alle unike stillinger som finnes i `Ansatt`-tabellen.
SELECT DISTINCT Stilling FROM Ansatt;

-- 4.  Finn varenummer, betegnelse og pris for alle varer.
SELECT VNr, Betegnelese, Pris FROM Vare;

-- 5.  Finn navn og kategori-nummer for alle kategorier, men døp om kolonnene til `Kategorinavn` og `KategoriID`.
SELECT navn AS 'Kategorinavn', KatNr AS 'KategoriID' FROM Kategori;

-- 6.  Finn ut hvor mange rader vil en kryssprodukt mellom kunder og ordrer ha. 
SELECT * from kunde LEFT JOIN ordre ON kunde.knr = ordre.knr;