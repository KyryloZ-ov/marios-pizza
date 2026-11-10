use nonnas_blog;

-- Übung 08, Aufgabe 1a
SELECT *
FROM rezept;

-- Übung 08, Aufgabe 1b
SELECT titel, dauer_min
FROM rezept
ORDER BY dauer_min DESC;

-- Übung 08, Aufgabe 2a
SELECT titel, dauer_min
FROM rezept
WHERE dauer_min < 45;

-- Übung 08, Aufgabe 2b
SELECT titel, dauer_min
FROM rezept
WHERE kategorie_id = 2
AND schwierigkeit = 'mittel';

-- Übung 08, Aufgabe 3a
SELECT name, einheit
FROM zutat
WHERE name LIKE 'Z%';

-- Übung 08, Aufgabe 3b
SELECT vorname, nachname
FROM leser
WHERE email IS NULL;

-- Übung 08, Aufgabe 3c
SELECT titel
FROM rezept
WHERE veroeffentlicht is NULL;

-- Übung 08, Aufgabe 4

SELECT titel, dauer_min
FROM rezept
ORDER BY dauer_min ASC
LIMIT 3;

-- Übung 08, Zusatzaufgabe 1
SELECT text, sterne
FROM kommentar
WHERE sterne BETWEEN 4 AND 5;

-- Übung 08, Zusatzaufgabe 2
SELECT titel
FROM rezept
WHERE kategorie_id IN (1, 3);

USE nonnas_blog;

-- Übung 09, Aufgabe 1a
SELECT COUNT(*) AS anzahl_rezepte
FROM rezept;

-- Übung 09, Aufgabe 1b
SELECT MIN(dauer_min) AS kuerzeste_dauer,
	   MAX(dauer_min) AS laengste_dauer
FROM rezept;

-- Übung 09, Aufgabe 2a
SELECT ROUND(AVG(sterne), 1) AS durchsnitt_sterne
FROM kommentar;

-- Übung 09, Aufgabe 2b
SELECT SUM(menge) AS parmesan_gramm
FROM rezept_zutat
WHERE zutat_id = 10;

-- Übung 09, Aufgabe 3a
SELECT kategorie_id, COUNT(*) AS anzahl_rezepte
FROM rezept
GROUP BY kategorie_id
ORDER BY kategorie_id;

-- Übung 09, Aufgabe 3b
SELECT l.leser_id, COUNT(k.kommentar_id) AS anzahl_kommentare
FROM leser AS l
LEFT JOIN kommentar AS k ON k.leser_id = l.leser_id
GROUP BY l.leser_id
ORDER BY l.leser_id;

-- Übung 09, Aufgabe 4
SELECT l.leser_id, COUNT(k.kommentar_id) AS anzahl_kommentare
FROM leser AS l
LEFT JOIN kommentar AS k ON k.leser_id = l.leser_id
GROUP BY l.leser_id
HAVING COUNT(k.kommentar_id) > 1
ORDER BY l.leser_id;

-- Übung 09, Zusatzaufgabe
SELECT r.titel, COUNT(*) AS anzahl_zutaten
FROM rezept AS r
JOIN rezept_zutat AS rz ON rz.rezept_id = r.rezept_id
GROUP BY r.rezept_id, r.titel
HAVING COUNT(*) >= 4
ORDER BY r.rezept_id;

-- Übung 10, Aufgabe 1
SELECT r.titel, k.bezeichnung AS kategorie
FROM rezept AS r
INNER JOIN kategorie AS k
	ON r.kategorie_id = k.kategorie_id
ORDER BY r.rezept_id;

-- Übung 10, Aufgabe 2 
SELECT l.vorname, k.text, k.sterne
FROM kommentar AS k
INNER JOIN leser AS l
	ON k.leser_id = l.leser_id
ORDER BY k.kommentar_id;

-- Übung 10, Aufgabe 3 
SELECT z.name, rz.menge, z.einheit
FROM rezept_zutat AS rz
INNER JOIN zutat AS z
	ON rz.zutat_id = z.zutat_id
WHERE rz.rezept_id = 2
ORDER BY z.zutat_id;

-- Übung 10, Aufgabe 4
SELECT k.bezeichnung AS kategorie, COUNT(*) AS anzahl_rezepte
FROM rezept AS r
INNER JOIN kategorie AS k
	ON r.kategorie_id = k.kategorie_id
GROUP BY k.kategorie_id, k.bezeichnung
ORDER BY k.kategorie_id;

-- Übung 10, Aufgabe 5
SELECT l.vorname, l.nachname,
		COUNT(k.kommentar_id) AS anzahl_kommentare
FROM leser AS l
LEFT JOIN kommentar AS k
	ON k.leser_id = l.leser_id
GROUP BY l.leser_id, l.vorname, l.nachname
ORDER BY l.leser_id;

-- Übung 10, Aufgabe 6
SELECT r.titel, rz.menge
FROM rezept AS r
INNER JOIN rezept_zutat AS rz
	ON r.rezept_id = rz.rezept_id
INNER JOIN zutat AS z
	ON rz.zutat_id = z.zutat_id
WHERE z.name = 'Parmesan'
ORDER BY rz.menge DESC;

-- Übung 10, Zusatzaufgabe 1
SELECT r.titel		
FROM rezept AS r
LEFT JOIN kommentar AS k
    ON k.rezept_id = r.rezept_id
WHERE k.kommentar_id IS NULL
ORDER BY r.rezept_id;

-- Übung 10, Zusatzaufgabe 2
SELECT titel, dauer_min
FROM rezept
WHERE dauer_min > (
    SELECT AVG(dauer_min)
    FROM rezept
)
ORDER BY dauer_min DESC;

-- Übung 10, Zusatzaufgabe 3
CREATE VIEW zutatenliste AS
SELECT r.titel, z.name AS zutat, rz.menge, z.einheit
FROM rezept AS r
INNER JOIN rezept_zutat AS rz
    ON r.rezept_id = rz.rezept_id
INNER JOIN zutat AS z
    ON rz.zutat_id = z.zutat_id;

SELECT titel, zutat, menge, einheit
FROM zutatenliste
WHERE titel = 'Panna Cotta'
ORDER BY zutat;

USE nonnas_blog;

-- Übung Z, Aufgabe 1
SELECT r.titel, k.bezeichnung AS kategorie,
       COUNT(c.kommentar_id) AS anzahl_kommentare,
       COALESCE(ROUND(AVG(c.sterne), 1), 0.0) AS bewertung
FROM rezept AS r
INNER JOIN kategorie AS k ON k.kategorie_id = r.kategorie_id
LEFT JOIN kommentar AS c ON c.rezept_id = r.rezept_id
WHERE r.veroeffentlicht IS NOT NULL
GROUP BY r.rezept_id, r.titel, k.bezeichnung
ORDER BY anzahl_kommentare DESC, r.titel ASC;

-- Übung Z, Aufgabe 2
SELECT z.name, z.einheit,
       COUNT(DISTINCT rz.rezept_id) AS anzahl_rezepte,
       SUM(rz.menge) AS gesamtmenge
FROM zutat AS z
INNER JOIN rezept_zutat AS rz ON rz.zutat_id = z.zutat_id
GROUP BY z.zutat_id, z.name, z.einheit
HAVING COUNT(DISTINCT rz.rezept_id) >= 2
ORDER BY anzahl_rezepte DESC, z.name ASC;

-- Übung Z, Aufgabe 3
SELECT CONCAT(l.vorname, ' ', l.nachname) AS lesername,
       COUNT(*) AS anzahl_kommentare,
       AVG(c.sterne) AS durchschnitt
FROM leser AS l
INNER JOIN kommentar AS c ON c.leser_id = l.leser_id
GROUP BY l.leser_id, l.vorname, l.nachname
HAVING COUNT(*) >= 2 AND AVG(c.sterne) >= 4
ORDER BY durchschnitt DESC, anzahl_kommentare DESC, lesername ASC;

-- Übung Z, Aufgabe 4
SELECT r.titel, k.bezeichnung AS kategorie, r.dauer_min,
       COUNT(DISTINCT z.zutat_id) AS anzahl_zutaten,
       GROUP_CONCAT(z.name ORDER BY z.name SEPARATOR ', ') AS zutatenliste
FROM rezept AS r
INNER JOIN kategorie AS k ON k.kategorie_id = r.kategorie_id
INNER JOIN rezept_zutat AS rz ON rz.rezept_id = r.rezept_id
INNER JOIN zutat AS z ON z.zutat_id = rz.zutat_id
WHERE r.dauer_min > 20
GROUP BY r.rezept_id, r.titel, k.bezeichnung, r.dauer_min
HAVING COUNT(DISTINCT z.zutat_id) >= 3
ORDER BY anzahl_zutaten DESC, r.dauer_min ASC;

-- Übung Z, Aufgabe 5
SELECT k.bezeichnung AS kategorie,
       COUNT(c.kommentar_id) AS anzahl_kommentare,
       AVG(c.sterne) AS durchschnitt
FROM kategorie AS k
INNER JOIN rezept AS r ON r.kategorie_id = k.kategorie_id
INNER JOIN kommentar AS c ON c.rezept_id = r.rezept_id
GROUP BY k.kategorie_id, k.bezeichnung
HAVING COUNT(c.kommentar_id) >= 2
ORDER BY durchschnitt DESC
LIMIT 1;

-- Übung Z, Zusatzaufgabe 1
SELECT l.vorname, l.nachname
FROM leser AS l
LEFT JOIN kommentar AS c ON c.leser_id = l.leser_id
WHERE c.kommentar_id IS NULL;

-- Übung Z, Zusatzaufgabe 2
SELECT r.titel, r.dauer_min
FROM rezept AS r
WHERE r.dauer_min > (
    SELECT AVG(r2.dauer_min)
    FROM rezept AS r2
    WHERE r2.kategorie_id = r.kategorie_id
)
ORDER BY r.rezept_id;

CREATE VIEW rezept_statistik AS
SELECT r.titel, k.bezeichnung AS kategorie,
       COUNT(c.kommentar_id) AS anzahl_kommentare,
       COALESCE(ROUND(AVG(c.sterne), 1), 0.0) AS bewertung
FROM rezept AS r
INNER JOIN kategorie AS k ON k.kategorie_id = r.kategorie_id
LEFT JOIN kommentar AS c ON c.rezept_id = r.rezept_id
WHERE r.veroeffentlicht IS NOT NULL
GROUP BY r.rezept_id, r.titel, k.bezeichnung;

SELECT titel, kategorie, anzahl_kommentare, bewertung
FROM rezept_statistik
WHERE bewertung > 4
ORDER BY bewertung DESC, titel ASC;


