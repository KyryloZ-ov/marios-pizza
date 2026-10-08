<?php
// GET /api/kategorien.php  →  alle Kategorien mit Anzahl der Artikel als JSON
// Beispiel aus der Präsentation (Übung 11): So liest PHP Daten aus der Datenbank und schickt sie als JSON.
require __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    antworte(405, ['fehler' => 'Nur GET ist erlaubt.']);
}

$pdo = verbinde();

$sql = 'SELECT k.kategorie_id AS id, k.bezeichnung, COUNT(a.artikel_id) AS artikel
        FROM kategorie k
        LEFT JOIN artikel a ON a.kategorie_id = k.kategorie_id
        GROUP BY k.kategorie_id, k.bezeichnung
        ORDER BY k.kategorie_id';

$zeilen = $pdo->query($sql)->fetchAll();

// Aus der Datenbank kommt alles als Text: Zahlen in Zahlen umwandeln
foreach ($zeilen as &$zeile) {
    $zeile['id']      = (int) $zeile['id'];
    $zeile['artikel'] = (int) $zeile['artikel'];
}
unset($zeile);

antworte(200, $zeilen);
