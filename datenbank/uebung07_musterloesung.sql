-- SQL-Musterlösung: Übung 07
-- Für einen frisch geladenen Bestand aus marios_pizza_start.sql.
-- Abschnitte der Reihe nach und jeweils nur einmal ausführen.
-- Aufgabe 6 und der Test mit 7 Sternen erzeugen absichtlich Fehler.
-- Diese Datei ist eine Referenz; die laufende abfragen.sql bleibt separat.

-- Übung 07, Aufgabe 1: Startbestand prüfen
USE marios_pizza;
SELECT COUNT(*) AS anzahl_artikel FROM artikel;
SELECT COUNT(*) AS anzahl_kunden FROM kunde;
SELECT COUNT(*) AS anzahl_bestellungen FROM bestellung;
SELECT artikel_id, name FROM artikel WHERE name = 'Cola';

-- Übung 07, Aufgabe 2: Struktur ändern
ALTER TABLE kunde ADD COLUMN email VARCHAR(80);

CREATE TABLE bewertung (
    bewertung_id INT PRIMARY KEY AUTO_INCREMENT,
    kunde_id INT NOT NULL,
    artikel_id INT NOT NULL,
    sterne INT,
    kommentar VARCHAR(200),
    FOREIGN KEY (kunde_id) REFERENCES kunde(kunde_id),
    FOREIGN KEY (artikel_id) REFERENCES artikel(artikel_id)
) ENGINE=InnoDB;

DESCRIBE kunde;
DESCRIBE bewertung;

-- Übung 07, Aufgabe 3: Daten einfügen
INSERT INTO kunde
    (vorname, nachname, telefon, strasse, plz, ort)
VALUES ('Jin', 'Park', '+1 718 555 0105',
        'Henry Street 21', '11201', 'Brooklyn');

INSERT INTO artikel
    (name, beschreibung, preis, kategorie_id)
VALUES
    ('Panna Cotta', 'Mit Beerensauce', 5.50, 3),
    ('Limonade', '0,33 l, hausgemacht', 3.80, 2);

-- Übung 07, Aufgabe 4: Aishas Bestellung in drei Schritten
INSERT INTO bestellung (kunde_id, bestelldatum, lieferart)
VALUES (4, '2026-09-29 13:00:00', 'Abholung');

SET @aisha_bestell_id = LAST_INSERT_ID();
SELECT @aisha_bestell_id AS neue_bestell_id;
SELECT artikel_id, name FROM artikel WHERE name = 'Limonade';

INSERT INTO bestellposition (bestell_id, artikel_id, menge)
VALUES (@aisha_bestell_id, 1, 1),
       (@aisha_bestell_id, 11, 1);

-- Übung 07, Aufgabe 5: Ändern und löschen
SELECT artikel_id, name, preis
FROM artikel WHERE kategorie_id = 1;

UPDATE artikel
SET preis = preis + 0.50
WHERE kategorie_id = 1;

SELECT kunde_id, vorname, nachname, telefon
FROM kunde WHERE kunde_id = 4;

UPDATE kunde
SET telefon = '+1 718 555 0104'
WHERE kunde_id = 4;

SELECT * FROM bestellposition
WHERE bestell_id = 4 AND artikel_id = 5;

DELETE FROM bestellposition
WHERE bestell_id = 4 AND artikel_id = 5;

-- Übung 07, Aufgabe 6: Erwarteter Fehler 1451; einzeln ausführen
SELECT bestell_id FROM bestellung WHERE kunde_id = 1;
DELETE FROM kunde WHERE kunde_id = 1;

-- Übung 07, Zusatzaufgabe: CHECK anlegen, dann Negativtest mit 7 Sternen
ALTER TABLE bewertung
ADD CONSTRAINT chk_bewertung_sterne
CHECK (sterne BETWEEN 1 AND 5);

INSERT INTO bewertung (kunde_id, artikel_id, sterne, kommentar)
VALUES (4, 1, 7, 'Test mit sieben Sternen');
