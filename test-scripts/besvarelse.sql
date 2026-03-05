-- Oppgave 1 spørringer
-- 1.  Finn alle data om alle kunder. Vis kun de 20 siste fra resultatrelasjonen (tips: bruke delspørring).
SELECT * FROM (
    SELECT * FROM Kunde ORDER BY KNr DESC LIMIT 20
) AS Subquery;

-- 2.  Finn fornavn og etternavn til alle ansatte. Vis kun de 10 første radene fra resultatrelasjonen.
SELECT Fornavn, Etternavn FROM Ansatt ORDER BY AnsNr ASC LIMIT 10;

-- 3.  Finn alle unike stillinger som finnes i `Ansatt`-tabellen.
SELECT DISTINCT Stilling FROM Ansatt;

-- 4.  Finn varenummer, betegnelse og pris for alle varer.
SELECT VNr, Betegnelse, Pris FROM Vare;

-- 5.  Finn navn og kategori-nummer for alle kategorier, men døp om kolonnene til `Kategorinavn` og `KategoriID`.
SELECT Navn AS Kategorinavn, KatNr AS KategoriID FROM Kategori;

-- 6.  Finn ut hvor mange rader vil en kryssprodukt mellom kunder og ordrer ha. 
SELECT COUNT(*) FROM Kunde, Ordre;

-- Oppgave 2 spørringer
-- 1.  Finn alle varer som koster mellom 200 og 500 (inkludert).
SELECT * FROM Vare WHERE Pris > 199 AND Pris < 501;

-- 2.  Finn alle ansatte som er 'Lagermedarbeider' eller 'Innkjøper'.
SELECT * FROM Ansatt WHERE Stilling = 'Lagermedarbeider' OR Stilling = 'Innkjøper';

-- 3.  Finn alle kunder som bor i postnummer '3199' eller '1711' og hvis fornavn starter med 'A'.
SELECT * FROM Kunde WHERE (PostNr = '3199' OR PostNr = '1711') AND Fornavn LIKE 'A%';

-- 4.  Finn alle varer som ikke er i kategori 1 og som har mer enn 600 på lager.
SELECT * FROM Vare WHERE KatNr > 1 AND Antall > 599;

-- 5.  Finn alle ordrer som ble sendt, men ikke betalt.
SELECT * FROM Ordre WHERE SendtDato IS NOT NULL AND ErBetalt IS NULL;

-- 6.  Finn alle ansatte hvis etternavn inneholder 'sen' (ikke case-sensitivt).
 SELECT * FROM Ansatt WHERE Etternavn ILIKE '%sen%';

-- Oppgave 3 spørringer
-- 1.  Finn antall kunder per postnummer.
SELECT PostNr, COUNT(*) FROM kunde GROUP BY PostNr;

-- 2.  Finn gjennomsnittlig pris for hver kategori.
SELECT KatNr, AVG(Pris) FROM Vare GROUP BY KatNr;

-- 3.  Finn den dyreste varen i hver kategori.
SELECT MAX(Pris) FROM Vare;

-- 4.  List opp alle stillinger og antall ansatte i hver stilling, sortert synkende etter antall.
SELECT Stilling, COUNT(Ansatt) AS Antall ansatte i stillingen FROM Ansatt GROUP BY Stilling ORDER BY COUNT(Ansatt) DESC;

-- 5.  Finn totalt antall varer på lager for hver kategori, men vis kun kategorier med mer enn 1000 varer totalt.
SELECT KatNr, SUM(Antall) FROM Vare WHERE Antall > 1000 GROUP BY KatNr;

-- 6.  Finn den eldste og yngste ansatte.
SELECT * FROM Ansatt 
WHERE fødselsdato = (SELECT MIN(fødselsdato) FROM Ansatt) 
OR fødselsdato = (SELECT MAX(fødselsdato) FROM ansatt);


-- Oppgave 4 spørringer
-- 1.  Finn navn på alle kunder og poststedet de bor i. Vis kun de første 20 rader fra resultatrelasjon.
SELECT * FROM (
    SELECT Fornavn, Etternavn, PostNr FROM Kunde LIMIT 20
) AS Subquery;

-- 2.  Finn navn på alle varer og navnet på kategorien de tilhører. Vis kun de første 20 rader fra resultatrelasjon. 
SELECT * FROM (
    SELECT v.betegnelse, k.navn 
    FROM Vare v 
    JOIN Kategori k ON v.KatNr = k.KatNr LIMIT 20)
AS Subquery;

-- 3.  Finn alle ordrer med kundenavn og ordredato. Vis kun de første 20 rader fra resultatrelasjon. 
SELECT * FROM (
    SELECT k.fornavn, o.ordredato 
    FROM ordre o JOIN kunde k ON o.knr = k.knr LIMIT 20
) AS Subquery;

-- 4.  Finn alle varer som aldri har blitt solgt (dvs. ikke finnes i `Ordrelinje`).
SELECT * FROM Vare v 
JOIN Ordrelinje ol ON v.vnr = ol.vnr 
WHERE ordrenr IS NULL; 

-- 5.  Finn totalt antall solgte enheter for hver vare (bruk `Ordrelinje`).
SELECT vnr, antall FROM Ordrelinje GROUP BY vnr;

-- 6.  Finn navnet på alle ansatte som bor i Bø i Telemark.
SELECT Fornavn FROM Ansatt WHERE PostNr = '3800';

-- Del 5 spørringer
-- 1.  Finn antall ansatte som **ikke** har fått bonus.
SELECT COUNT(*) FROM ansatt WHERE IS NULL;

-- 2.  Beregn gjennomsnittlig bonus for alle ansatte, men behandle de som ikke har fått bonus som om de har 0 i bonus.
SELECT AVG(COALESCE(bonus,0)) AS Gjennomsnitt FROM ansatt; 

-- 3.  List opp alle kunder som **ikke** har registrert et telefonnummer.
SELECT * FROM kunde WHERE telefon IS NULL;

-- 4.  Finn den totale lønnskostnaden (Årslønn + Bonus) for alle ansatte. Pass på at ansatte uten bonus også blir med i den totale summen.
SELECT SUM(Årslønn + COALESCE(bonus,0)) AS Total_lønnskostnad FROM ansatt;

-- 5.  List opp alle stillinger og antall ansatte i hver stilling som har en bonus registrert.
SELECT stilling, COUNT(Ansatt) AS Antall_Ansatt FROM Ansatt WHERE bonus IS NOT NULL GROUP BY stilling;

-- 6.  Finn den laveste bonusen som er gitt ut (ignorer de som ikke har fått bonus).
SELECT MIN(bonus) FROM Ansatt;

-- Del 6 spørringer
-- 1.  Finn alle ordrer som **verken** er bekreftet betalt eller bekreftet ikke-betalt (dvs. de hvor logikken er `UNKNOWN`).
SELECT COUNT(*) FROM ordre WHERE ErBetalt IS UNKNOWN;

-- 2.  List opp alle ansatte som har en bonus som er enten `NULL` eller mindre enn 6000.
SELECT * FROM Ansatt WHERE bonus IS NULL OR bonus < 6000;

-- 3.  Finn antall kunder som **ikke** har telefonnummer `41234567` (pass på å inkludere de med `NULL` telefonnummer i tellingen).
SELECT COUNT(*) FROM kunde WHERE telefon NOT LIKE '41234567' AND telefon IS NULL;

-- 4.  List opp alle ordrer som er betalt (`ErBetalt = TRUE`), men hvor `SendtDato` er `NULL`.
SELECT * FROM ordre WHERE ErBetalt = TRUE AND SendtDato IS NULL;
