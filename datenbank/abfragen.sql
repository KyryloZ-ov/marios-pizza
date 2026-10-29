USE marios_pizza;

SELECT COUNT(*) AS anzahl_artikel FROM artikel;
SELECT COUNT(*) AS anzahl_kunden FROM kunde;
SELECT COUNT(*) AS anzahl_bestellungen FROM bestellung;

SELECT artikel_id, name
FROM artikel
WHERE name = 'Cola';

-- Übung 07, Aufgabe 2
ALTER TABLE kunde
ADD COLUMN email VARCHAR(80);

DESCRIBE kunde;

-- Übung 07, Aufgabe 2: Tabelle bewertung
CREATE TABLE bewertung (
	bewertung_id INT PRIMARY KEY AUTO_INCREMENT,
    kunde_id INT NOT NULL,
    artikel_id INT NOT NULL,
    sterne INT,
    kommentar VARCHAR(200),

    FOREIGN KEY (kunde_id) REFERENCES kunde(kunde_id),
    FOREIGN KEY (artikel_id) REFERENCES artikel(artikel_id)
);

DESCRIBE bewertung;

-- Übung 07, Aufgabe 3: Neue Kundin

INSERT INTO kunde
	(vorname, nachname, telefon, strasse, plz, ort)
VALUES
	('Jin', 'Park', '+1 718 555 0105', 'Henry Street 21', '11201', 'Brooklyn');

SELECT *
FROM kunde
WHERE vorname = 'Jin' and nachname = 'Park';

-- Übung 07, Aufgabe 3: Limonade

INSERT INTO artikel (name, beschreibung, preis, kategorie_id)
VALUES ('Limonade', '0,33 l, hausgemacht', 3.80, 2);

SELECT artikel_id, name, preis
FROM artikel
WHERE name = 'Limonade';

INSERT INTO artikel (name, beschreibung, preis, kategorie_id)
VALUES ('Panna Cotta', 'Mit Beerensauce', 5.50, 3);

SELECT artikel_id, name, preis, kategorie_id
FROM artikel
WHERE name IN ('Panna Cotta', 'Limonade');


-- Übung 07, Aufgabe 4

SELECT kunde_id, vorname, nachname
FROM kunde
WHERE vorname = 'Aisha' AND nachname = 'Johnson';

SELECT artikel_id, name, preis 
FROM artikel
WHERE name IN ('Margherita', 'Limonade');

INSERT INTO bestellung (kunde_id, bestelldatum, lieferart)
VALUES (4, '2026-09-29 13:00:00', 'Abholung');

SET @aisha_bestell_id = LAST_INSERT_ID();

SELECT @aisha_bestell_id AS neue_bestell_id;

INSERT INTO bestellposition (bestell_id, artikel_id, menge)
SELECT @aisha_bestell_id, artikel_id, 1
FROM artikel
WHERE name IN ('Margherita', 'Limonade');

SELECT *
FROM bestellposition
WHERE bestell_id = @aisha_bestell_id;

-- Übung 07 - Aufgabe 5

SELECT artikel_id, name, preis
FROM artikel
WHERE kategorie_id = 1;

UPDATE artikel
SET preis = preis + 0.50
WHERE kategorie_id = 1;

SELECT artikel_id, name, preis
FROM artikel
WHERE kategorie_id = 1;

UPDATE kunde
SET telefon = '+1 718 555 0104'
WHERE kunde_id = 4;

SELECT kunde_id, vorname, nachname, telefon
FROM kunde
WHERE kunde_id = 4;

SELECT *
FROM bestellposition
WHERE bestell_id = 4 AND artikel_id = 5;

DELETE FROM bestellposition
WHERE bestell_id = 4 AND artikel_id = 5;

SELECT *
FROM bestellposition
WHERE bestell_id = 4;

-- Übung 07 - Aufgabe 6

SELECT *
FROM bestellung
WHERE kunde_id = 1;

DELETE FROM kunde
WHERE kunde_id = 1;


-- Bonus

ALTER TABLE bewertung
ADD CONSTRAINT chk_bewertung_sterne
CHECK (sterne BETWEEN 1 AND 5);

INSERT INTO bewertung (kunde_id, artikel_id, sterne, kommentar)
VAlUES (4, 1, 7, 'Test mit sieben Sternen');



SELECT 'artikel' AS tabelle, COUNT(*) AS anzahl FROM artikel
UNION ALL
SELECT 'kunde', COUNT(*) FROM kunde
UNION ALL
SELECT 'bestellung', COUNT(*) FROM bestellung
UNION ALL
SELECT 'bestellposition', COUNT(*) FROM bestellposition;








