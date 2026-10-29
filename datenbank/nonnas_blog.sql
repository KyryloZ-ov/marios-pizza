-- Nonna's Blog · Beispieldatenbank für die Präsentation „1000 Datenbank“ (Vormach-Beispiel)
-- MySQL Workbench: File › Open SQL Script…, komplett ausführen. Eine vorhandene Datenbank nonnas_blog wird ersetzt.

DROP DATABASE IF EXISTS nonnas_blog;
CREATE DATABASE nonnas_blog CHARACTER SET utf8mb4;
USE nonnas_blog;

CREATE TABLE kategorie (
    kategorie_id     INT PRIMARY KEY AUTO_INCREMENT,
    bezeichnung      VARCHAR(30) NOT NULL
);

CREATE TABLE rezept (
    rezept_id        INT PRIMARY KEY AUTO_INCREMENT,
    titel            VARCHAR(60) NOT NULL,
    dauer_min        INT NOT NULL,
    schwierigkeit    VARCHAR(10) NOT NULL,
    veroeffentlicht  DATE,
    kategorie_id     INT NOT NULL,
    FOREIGN KEY (kategorie_id) REFERENCES kategorie (kategorie_id)
);

CREATE TABLE zutat (
    zutat_id         INT PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(40) NOT NULL,
    einheit          VARCHAR(10) NOT NULL
);

CREATE TABLE rezept_zutat (
    rezept_id        INT NOT NULL,
    zutat_id         INT NOT NULL,
    menge            DECIMAL(6,1) NOT NULL,
    PRIMARY KEY (rezept_id, zutat_id),
    FOREIGN KEY (rezept_id) REFERENCES rezept (rezept_id),
    FOREIGN KEY (zutat_id) REFERENCES zutat (zutat_id)
);

CREATE TABLE leser (
    leser_id         INT PRIMARY KEY AUTO_INCREMENT,
    vorname          VARCHAR(40) NOT NULL,
    nachname         VARCHAR(40) NOT NULL,
    email            VARCHAR(80)
);

CREATE TABLE kommentar (
    kommentar_id     INT PRIMARY KEY AUTO_INCREMENT,
    rezept_id        INT NOT NULL,
    leser_id         INT NOT NULL,
    text             VARCHAR(300) NOT NULL,
    sterne           INT NOT NULL,
    geschrieben      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rezept_id) REFERENCES rezept (rezept_id),
    FOREIGN KEY (leser_id) REFERENCES leser (leser_id)
);

INSERT INTO kategorie (bezeichnung) VALUES ('Vorspeise'), ('Hauptgericht'), ('Dessert');

INSERT INTO rezept (titel, dauer_min, schwierigkeit, veroeffentlicht, kategorie_id) VALUES
('Tiramisu',          30, 'leicht', '2026-03-12', 3),
('Lasagne',           90, 'mittel', '2026-03-20', 2),
('Minestrone',        60, 'leicht', '2026-04-02', 1),
('Panna Cotta',       20, 'leicht', '2026-04-15', 3),
('Risotto ai Funghi', 45, 'mittel', '2026-05-03', 2),
('Bruschetta',        15, 'leicht', NULL,         1);

INSERT INTO zutat (name, einheit) VALUES
('Mascarpone', 'g'), ('Eier', 'Stück'), ('Zucker', 'g'), ('Löffelbiskuits', 'Stück'), ('Espresso', 'ml'),
('Kakao', 'g'), ('Nudelplatten', 'Stück'), ('Hackfleisch', 'g'), ('Tomaten', 'g'), ('Parmesan', 'g'),
('Sahne', 'ml'), ('Risottoreis', 'g'), ('Champignons', 'g'), ('Weißbrot', 'Scheibe'), ('Knoblauch', 'Zehe'),
('Zucchini', 'g'), ('Gelatine', 'Blatt');

INSERT INTO rezept_zutat (rezept_id, zutat_id, menge) VALUES
(1, 1, 500), (1, 2, 4), (1, 3, 100), (1, 4, 24), (1, 5, 300), (1, 6, 20),
(2, 7, 12), (2, 8, 500), (2, 9, 800), (2, 10, 100),
(3, 9, 400), (3, 16, 200), (3, 15, 2), (3, 10, 30),
(4, 11, 500), (4, 3, 60), (4, 17, 3),
(5, 12, 300), (5, 13, 250), (5, 10, 60), (5, 15, 1),
(6, 14, 8), (6, 9, 300), (6, 15, 2);

INSERT INTO leser (vorname, nachname, email) VALUES
('Peach', 'Toadstool', 'peach@example.com'),
('Daisy', 'Sarasa',    'daisy@example.com'),
('Luigi', 'Mario',     NULL),
('Rosalina', 'Stella', 'rosalina@example.com'),
('Yoshi', 'Isola',     'yoshi@example.com');

INSERT INTO kommentar (rezept_id, leser_id, text, sterne, geschrieben) VALUES
(1, 1, 'Wie bei Nonna in Neapel!', 5, '2026-03-14 18:02:00'),
(1, 2, 'Mit einem Schuss Amaretto noch besser.', 4, '2026-03-15 20:41:00'),
(2, 3, 'Meine Lieblings-Lasagne – Mario bekommt keine ab.', 5, '2026-03-22 19:10:00'),
(2, 1, 'Hat bei mir zwei Stunden gedauert, nicht 90 Minuten.', 3, '2026-03-23 21:30:00'),
(4, 2, 'Leicht und lecker.', 5, '2026-04-16 12:05:00'),
(5, 4, 'Die Pilze vorher scharf anbraten!', 4, '2026-05-04 18:47:00'),
(1, 4, 'Den Kakao erst kurz vor dem Servieren darüber.', 5, '2026-05-10 15:20:00');
