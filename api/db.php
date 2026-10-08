<?php
// Gemeinsame Hilfsfunktionen für alle Schnittstellen (API-Dateien).

// Schickt eine Antwort als JSON und beendet das Skript.
function antworte(int $status, array $daten) {
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($daten, JSON_UNESCAPED_UNICODE);
    exit;
}

// Baut die Verbindung zur Datenbank auf (PDO).
function verbinde(): PDO {
    $datei = __DIR__ . '/config.php';
    if (!file_exists($datei)) {
        antworte(500, ['fehler' => 'api/config.php fehlt. Kopiere config.example.php nach config.php.']);
    }
    $c = require $datei;

    // Normalfall: MySQL. Mit "dsn" in config.php lässt sich das für Tests überschreiben.
    $port = $c['port'] ?? 3306;
    $dsn = $c['dsn'] ?? "mysql:host={$c['host']};port={$port};dbname={$c['name']};charset=utf8mb4";

    try {
        return new PDO($dsn, $c['user'] ?? null, $c['password'] ?? null, [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,   // Fehler als Exception melden
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,         // Zeilen als Array mit Spaltennamen
            PDO::ATTR_EMULATE_PREPARES   => false,                    // echte Prepared Statements
        ]);
    } catch (PDOException $e) {
        // Die genaue Meldung gehört ins Log, nicht zum Besucher (sie kann Passwörter oder Pfade verraten).
        error_log('DB-Verbindung fehlgeschlagen: ' . $e->getMessage());
        antworte(500, ['fehler' => 'Keine Verbindung zur Datenbank. Läuft MySQL? Stimmen die Angaben in config.php?']);
    }
}
