<?php
// Verbindungstest: http://localhost/marios-pizza/api/ping.php
require __DIR__ . '/db.php';

$pdo = verbinde();
$anzahl = $pdo->query('SELECT COUNT(*) FROM artikel')->fetchColumn();

antworte(200, ['ok' => true, 'artikel' => (int) $anzahl]);
