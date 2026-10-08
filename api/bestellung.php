<?php
// POST /api/bestellung.php  →  speichert eine Bestellung (kunde, bestellung, bestellposition)
//
// Erwartet JSON, z. B.:
// {
//   "kunde": { "vorname": "Tony", "nachname": "Russo", "telefon": "+1 718 555 0101",
//              "strasse": "Court Street 12", "plz": "11201", "ort": "Brooklyn" },
//   "lieferart": "Lieferung",
//   "positionen": [ { "artikel_id": 1, "menge": 2 }, { "artikel_id": 7, "menge": 2 } ]
// }
require __DIR__ . '/db.php';

class UngueltigeEingabe extends Exception {}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    antworte(405, ['fehler' => 'Nur POST ist erlaubt.']);
}

// 1. Eingabe lesen. Dem Browser darf man nie trauen: alles wird hier geprüft.
$eingabe = json_decode(file_get_contents('php://input'), true);
if (!is_array($eingabe)) {
    antworte(400, ['fehler' => 'Die Daten sind kein gültiges JSON.']);
}

$kunde      = is_array($eingabe['kunde'] ?? null) ? $eingabe['kunde'] : [];
$lieferart  = $eingabe['lieferart'] ?? '';
$positionen = $eingabe['positionen'] ?? [];

$vorname  = trim((string) ($kunde['vorname']  ?? ''));
$nachname = trim((string) ($kunde['nachname'] ?? ''));
$telefon  = trim((string) ($kunde['telefon']  ?? ''));
$strasse  = trim((string) ($kunde['strasse']  ?? ''));
$plz      = trim((string) ($kunde['plz']      ?? ''));
$ort      = trim((string) ($kunde['ort']      ?? ''));

if ($vorname === '' || $nachname === '') {
    antworte(400, ['fehler' => 'Vorname und Nachname sind Pflicht.']);
}
if (!in_array($lieferart, ['Lieferung', 'Abholung', 'Vor Ort'], true)) {
    antworte(400, ['fehler' => 'Die Lieferart muss Lieferung, Abholung oder Vor Ort sein.']);
}
if ($lieferart === 'Lieferung' && ($strasse === '' || $plz === '' || $ort === '')) {
    antworte(400, ['fehler' => 'Für eine Lieferung brauchen wir Straße, PLZ und Ort.']);
}
if (!is_array($positionen) || count($positionen) === 0) {
    antworte(400, ['fehler' => 'Die Bestellung enthält keinen Artikel.']);
}

// 2. Positionen bereinigen: gleiche Artikel zusammenfassen (der Schlüssel von bestellposition ist
//    (bestell_id, artikel_id), derselbe Artikel darf nur einmal vorkommen).
$mengen = [];
foreach ($positionen as $p) {
    $artikelId = filter_var($p['artikel_id'] ?? null, FILTER_VALIDATE_INT);
    $menge     = filter_var($p['menge'] ?? null, FILTER_VALIDATE_INT);
    if ($artikelId === false || $menge === false || $menge < 1 || $menge > 20) {
        antworte(400, ['fehler' => 'Ungültiger Artikel oder ungültige Menge (erlaubt: 1 bis 20).']);
    }
    $mengen[$artikelId] = ($mengen[$artikelId] ?? 0) + $menge;
}

// 3. Alles in einer Transaktion speichern: entweder ganz oder gar nicht.
//
// TODO Übung 12, Aufgabe 2: Speichere die Bestellung. Bis hier ist alles vorbereitet:
//   $vorname, $nachname, $telefon, $strasse, $plz, $ort   (Kundendaten, geprüft)
//   $lieferart                                             (geprüft)
//   $mengen                                                (Array: artikel_id => menge, geprüft)
$pdo = verbinde();
$pdo->beginTransaction();

try {
    // a) Kunde suchen (gleicher Vorname, Nachname und Telefon), sonst neu anlegen.
    //    Prepared Statement mit Platzhaltern (?), nie Variablen in den SQL-Text schreiben!
    //    Die neue kunde_id bekommst du mit $pdo->lastInsertId().

    // b) Bestellung anlegen: INSERT INTO bestellung (kunde_id, lieferart) ...
    //    Das Datum setzt die Datenbank selbst. $bestellId = (int) $pdo->lastInsertId();

    // c) Für jeden Eintrag in $mengen:
    //    - den Preis des Artikels aus der Datenbank holen (SELECT preis FROM artikel ...)
    //    - gibt es den Artikel nicht, wirf: throw new UngueltigeEingabe("Den Artikel $artikelId gibt es nicht.");
    //    - eine Zeile in bestellposition einfügen
    //    - $summe um preis * menge erhöhen

    // d) $pdo->commit(); und antworte(201, ['bestell_id' => $bestellId, 'summe' => round($summe, 2)]);

    $pdo->rollBack();
    antworte(501, ['fehler' => 'Noch nicht programmiert (Übung 12, Aufgabe 2).']);

} catch (UngueltigeEingabe $e) {
    $pdo->rollBack();
    antworte(400, ['fehler' => $e->getMessage()]);
} catch (PDOException $e) {
    $pdo->rollBack();
    error_log('Bestellung fehlgeschlagen: ' . $e->getMessage());
    antworte(500, ['fehler' => 'Die Bestellung konnte nicht gespeichert werden.']);
}
