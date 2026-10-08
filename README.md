# Mario's Pizza – Daten und Backend

Die Website von **Mario's Pizza** (Court Street / Montague Street, Brooklyn) aus der 11. Klasse – jetzt mit Datenbank:
Die Speisekarte kommt aus MySQL, Bestellungen landen in den Tabellen `kunde`, `bestellung` und `bestellposition`.

## Aufbau

| Ordner / Datei | Inhalt |
|---|---|
| `index.html`, `style.css`, `script.js` | die Website (HTML, CSS, JavaScript) |
| `speisekarte.js` | Ersatzdaten, falls die Datenbank nicht läuft |
| `api/` | PHP-Schnittstelle (Backend): `ping.php`, `artikel.php`, `bestellung.php` |
| `datenbank/` | SQL-Skripte, Datenmodell, Diagramme |

## Starten (XAMPP)

1. Projekt nach `C:\xampp\htdocs\marios-pizza` klonen.
2. Im XAMPP Control Panel **Apache** und **MySQL** starten.
3. `datenbank/marios_pizza_start.sql` in MySQL Workbench oder phpMyAdmin ausführen.
4. `api/config.example.php` nach `api/config.php` kopieren (steht in `.gitignore`).
5. Test: <http://localhost/marios-pizza/api/ping.php> → `{"ok":true,"artikel":9}`
6. Website: <http://localhost/marios-pizza/>

## Status / To-do

- [x] Website aus der 11. Klasse (HTML, CSS, JavaScript)
- [ ] Datenmodell: ER-Diagramm, UML (Übung 01–04)
- [ ] Normalisierung (Übung 05–06)
- [ ] SQL: Tabellen, Abfragen, JOIN (Übung 07–10)
- [ ] Speisekarte aus der Datenbank (Übung 11)
- [ ] Bestellung wird gespeichert (Übung 12)
- [ ] Abgesichert: Prepared Statements, eigener Benutzer (Übung 13)

## Gebaut von

Kyrylo Zolotukhin
