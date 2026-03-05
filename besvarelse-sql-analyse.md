# Besvarelse: SQL-Analyse

## Oppgave 1: Grunnleggende Spørringer
1.  `SELECT * FROM Vare;`
2.  `SELECT VNr, Betegnelse FROM Vare;`
3.  `SELECT DISTINCT KatNr FROM Vare;`
4.  `SELECT Fornavn, Etternavn, Stilling AS Jobbtittel FROM Ansatt;`

1.  **Forklaring:** 
`SELECT * FROM Vare;` 
Velger alle kolonner fra tabellen Vare.

2.  **Forklaring:** 
`SELECT VNr, Betegnelse FROM Vare;`
Velger kolonnene VNr og Betegnelse fra tabellen Vare;
3.  **Forklaring:** ...
`SELECT DISTINCT KatNr FROM Vare;`
Velger kolonnen KatNR fra tabellen Vare, men med DISTINCT-klausen så tar det bort duplikater.
4.  **Forklaring:** ...
`SELECT Fornavn, Etternavn, Stilling AS Jobbtittel FROM Ansatt;`
Velger kolonnene Fornavn, Etternavn, men Stilling-kolonnen blir omgjort til Jobtittel fra tabellen Ansatt.

## Oppgave 2: WHERE-klausulen
1.  `SELECT * FROM Vare WHERE Pris > 500;`
2.  `SELECT * FROM Ansatt WHERE Stilling = 'Salgssjef' AND Årslønn > 600000;`
3.  `SELECT Fornavn, Etternavn FROM Kunde WHERE PostNr = '0001' OR PostNr = '0002';`
4.  `SELECT Betegnelse FROM Vare WHERE NOT KatNr = 1;`

1.  **Forklaring:** 
`SELECT * FROM Vare WHERE Pris > 500;`
Velger alle kolonner fra tabellen Vare hvor prisen er mer enn 500kr.

2.  **Forklaring:** 
`SELECT * FROM Ansatt WHERE Stilling = 'Salgssjef' AND Årslønn > 600000;`
Velger alle kolonner fra tabellen ansatt hvor Stilling-kolonnen er lik 'Salgssjef' og årslønn er mer enn 600000.

3.  **Forklaring:** 
`SELECT Fornavn, Etternavn FROM Kunde WHERE PostNr = '0001' OR PostNr = '0002';`
Velger Fornavn og Etternavn-kolonnene fra tabellen Kunde hvor PostNr er lik '0001' eller hvor PostNr er lik '0002'.

4.  **Forklaring:**
`SELECT Betegnelse FROM Vare WHERE NOT KatNr = 1;`
Velger Betegnelse fra tabellen Vare hvor KatNr ikke er lik 1.

## Oppgave 3: Gruppering og Sortering
1.  `SELECT * FROM Vare ORDER BY Pris DESC;`
2.  `SELECT KatNr, COUNT(*) FROM Vare GROUP BY KatNr;`
3.  `SELECT Stilling, AVG(Årslønn) FROM Ansatt GROUP BY Stilling;`
4.  `SELECT KatNr, SUM(Antall) FROM Vare GROUP BY KatNr HAVING SUM(Antall) > 500;`

1.  **Forklaring:** 
`SELECT * FROM Vare ORDER BY Pris DESC;`
Velger alle kolonner fra tabellen Vare som sorterer Pris fra høyest til lavest.

2.  **Forklaring:** 
`SELECT KatNr, COUNT(*) FROM Vare GROUP BY KatNr;`
Velger kolonnen KatNr, de blir så gruppert av GROUP BY og lager en kolonne av antall rader den inneholder fra tabellen Vare.

3.  **Forklaring:** 
 `SELECT Stilling, AVG(Årslønn) FROM Ansatt GROUP BY Stilling;`
 Velger kolonnen Stilling, de blir så gruppert av GROUP BY og lager en kolonne av gjenomsnittet av Årslønnet til hvert ansatt.

4.  **Forklaring:** 
`SELECT KatNr, SUM(Antall) FROM Vare GROUP BY KatNr HAVING SUM(Antall) > 500;`
Denne gruperer alle KatNr i den først kolonnen, deretter kalkulerer summen av antallet av den varer som bare er over 500 i raden.

## Oppgave 4: Spørringer mot Flere Tabeller
1.  `SELECT V.Betegnelse, K.Navn FROM Vare V JOIN Kategori K ON V.KatNr = K.KatNr;`
2.  `SELECT O.OrdreNr, K.Fornavn, K.Etternavn FROM Ordre O LEFT JOIN Kunde K ON O.KNr = K.KNr;`
3.  `SELECT A1.Fornavn, A2.Fornavn FROM Ansatt A1, Ansatt A2 WHERE A1.PostNr = A2.PostNr AND A1.AnsNr < A2.AnsNr;`
4.  `SELECT V.Betegnelse FROM Vare V WHERE V.VNr NOT IN (SELECT VNr FROM Ordrelinje);`

1.  **Forklaring:** 
`SELECT V.Betegnelse, K.Navn FROM Vare V JOIN Kategori K ON V.KatNr = K.KatNr;`
Joiner tabellen Vare og Kategori, forkorter dem til V og K og velger kolonnene betegnelse fra vare og navn fra kategori. 

2.  **Forklaring:** 
`SELECT O.OrdreNr, K.Fornavn, K.Etternavn FROM Ordre O LEFT JOIN Kunde K ON O.KNr = K.KNr;`
Velger kolonnene Ordenummer fra tabellen Ordre forkortet med O, og kolonnen Fornavn og Etternavn fra tabellen Kunde forkortet med K. Med LEFT JOIN viser den alt fra ordre tabell som finner en match med kundetabellen. Finner den ikke en match, resulterer det til en NULL.

3.  **Forklaring:** 
`SELECT A1.Fornavn, A2.Fornavn FROM Ansatt A1, Ansatt A2 WHERE A1.PostNr = A2.PostNr AND A1.AnsNr < A2.AnsNr;`
Denne bruker en SELF JOIN. Da må den bruke aliaser for å skille tabellene. Og denne velger kolonnen Fornavn fra den første tabellen og en Fornavn til fra den andre tabellen hvor Postnummerene er like og ansattnummerene til den første tabellen er lavere enn den andre tabellen.

4.  **Forklaring:** 

`SELECT V.Betegnelse FROM Vare V WHERE V.VNr NOT IN (SELECT VNr FROM Ordrelinje);`

## Oppgave 5: NULL-verdier og Aggregeringsfunksjoner

Forklar hva følgende SQL-spørringer gjør, og hvorfor resultatene blir som de blir. Vær spesielt oppmerksom på hvordan `NULL` påvirker resultatet.

1.  **Spørring:**
    ```sql
    SELECT COUNT(*), COUNT(Bonus) FROM Ansatt;
    ```
    **Forklaring:**
    *   Denne spørringen lager en kolonne med antall av ansatte(12) og antallet av ansatte som har bonus(5).

2.  **Spørring:**
    ```sql
    SELECT AVG(Bonus) FROM Ansatt;
    ```
    **Forklaring:**
    *   Denne spørringen utgir gjennomsnittet av bonuset av alle ansatte som HAR, så når den deler så deler den bare på 5 fordi resten har NULL.

3.  **Spørring:**
    ```sql
    SELECT Fornavn, Etternavn, COALESCE(Bonus, 0) AS JustertBonus FROM Ansatt;
    ```
    **Forklaring:**
    *   Denne spørringen viser kolonnene fornavn, etternavn og bonuset som nå heter JustertBonus av ansatte, men COALESCESE gjør on de ansatte som ikke har bonus til 0.

4.  **Spørring:**
    ```sql
    SELECT Stilling, SUM(Årslønn + Bonus) FROM Ansatt GROUP BY Stilling;
    ```
    **Forklaring:**
    *   Denne spørringen viser tabellen Ansatt hvor det er en kolonne med Stilling og ved siden av det summen av årslønn og bonus for de stillingene, men fordi noen ansatte IKKE HAR(NULL) bonus selv om andre er i samme stilling, regner ikke databasen med de stillingene.

## Oppgave 6: Tre-verdi Logikk (TRUE, FALSE, UNKNOWN)

SQLs logikk er ikke bare `TRUE` eller `FALSE`. Når `NULL` er involvert, får vi en tredje tilstand: `UNKNOWN`. Denne oppgaven utforsker hvordan dette påvirker `WHERE`-klausuler.

### Del 1: Forklar SQL-spørringene

Forklar resultatet av følgende SQL-spørringer. Hvorfor returnerer de det de gjør?

1.  **Spørring:**
    ```sql
    SELECT COUNT(*) FROM Ordre WHERE ErBetalt = TRUE;
    ```
    **Forklaring:**
    *   Denne spørringen ber om telle alle radene til tabellen ordre som kundene har betalt.

2.  **Spørring:**
    ```sql
    SELECT COUNT(*) FROM Ordre WHERE ErBetalt = FALSE;
    ```
    **Forklaring:**
    *   Denne spørringen ber om telle alle radene til tabellen ordre som kundene ikke har betalt.

3.  **Spørring:**
    ```sql
    SELECT COUNT(*) FROM Ordre WHERE ErBetalt = TRUE OR ErBetalt = FALSE;
    ```
    **Forklaring:**
    *  Denne spørringen ber om telle alle radene til tabellen ordre som kundene har betalt og ikke betalt.

4.  **Spørring:**
    ```sql
    SELECT COUNT(*) FROM Ordre WHERE ErBetalt IS UNKNOWN;
    ```
    **Forklaring:**
    *    Denne spørringen ber om telle alle radene til tabellen ordre som man ikke vet om kundene har betalt eller ikke, funket også med ```IS NULL```.
