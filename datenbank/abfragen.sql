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
