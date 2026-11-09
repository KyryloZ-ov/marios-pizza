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




