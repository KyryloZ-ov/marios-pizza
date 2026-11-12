<?php
// GET /api/artikel.php  →  alle Artikel mit Kategorie als JSON
//
// TODO Übung 11, Aufgabe 3: Gib die Speisekarte aus der Datenbank als JSON zurück.
require __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    antworte(405, ['fehler' => 'Nur GET ist erlaubt.']);
}

$pdo = verbinde();

// 1. Schreibe die SELECT-Abfrage: artikel und kategorie per JOIN verbinden.
//    Die Spalten müssen so heißen (siehe speisekarte.js):
//    id, name, beschreibung, preis, kategorie
//    Tipp: "a.artikel_id AS id" benennt eine Spalte um.
$sql = 'SELECT a.artikel_id as id,
	        a.name,
            a.beschreibung,
            a.preis,
            k.bezeichnung AS kategorie
        FROM artikel AS a
        INNER JOIN kategorie as k
	        ON a.kategorie_id = k.kategorie_id
        ORDER BY k.kategorie_id, a.preis ASC, a.artikel_id';

// 2. Führe die Abfrage aus und hole alle Zeilen:
//    $zeilen = $pdo->query($sql)->fetchAll();

$zeilen = $pdo->query($sql)->fetchAll();

// 3. Aus der Datenbank kommt alles als Text. Wandle in einer foreach-Schleife
//    id in int und preis in float um: (int) $zeile['id']

foreach ($zeilen as &$zeile) {
    $zeile['id'] = (int) $zeile['id'];
    $zeile['preis'] = (float) $zeile['preis'];
}
unset($zeile);
// 4. Schicke das Ergebnis als JSON: antworte(200, $zeilen);

antworte(200, $zeilen);
