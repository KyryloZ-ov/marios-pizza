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
WHERE emails IS NULL;

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

