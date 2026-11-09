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

