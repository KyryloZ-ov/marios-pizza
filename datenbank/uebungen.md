# Übungen Datenbank

## Übung 00

### Aufgabe 1 – Die vier Prüffragen

| Prüffrage | Beispiel aus Luigis Einkaufsliste |
| --- | --- |
| Steht etwas doppelt? | Bella Farina und die Telefonnummer +1 718 555 0301 stehen bei E1 und E3. Die Lieferantendaten werden mehrfach gespeichert. |
| Mehrere Werte in einer Zelle? | Bei E1 steht „Mehl Tipo 00, Hefe“ in einer Zelle. Auch Menge („25, 2“) und Preis („1,20, 4,50“) enthalten mehrere Werte. |
| Kann sich etwas widersprechen? | Wenn Bella Farina eine neue Telefonnummer bekommt und Luigi nur E1 ändert, stehen bei E1 und E3 unterschiedliche Telefonnummern. In der aktuellen Liste sind sie noch gleich. |
| Lässt sich eine Frage beantworten? | „Wie viel Mehl habe ich im September gekauft?“ lässt sich nur durch Suchen und Rechnen beantworten: 25 + 25 = 50. Eine Mengeneinheit fehlt. |

### Aufgabe 2 – Was will Luigi wissen?

| Luigis Frage | Mit der Liste möglich? | Welche Daten braucht man? |
| --- | --- | --- |
| Wie viel Mehl habe ich im September gekauft? | Ja, von Hand: 25 + 25 = 50. Ob das zum Beispiel Kilogramm sind, steht nicht in der Liste. | Ware, Einkaufsdatum, Menge und Mengeneinheit. |
| Bei welchem Lieferanten gebe ich am meisten aus? | Nur mit zusätzlicher Klärung und Rechnen. Man muss wissen, ob der Preis für eine Einheit oder für die gesamte Menge gilt, und jede Menge ihrem Preis zuordnen. | Lieferant, Einkaufsdatum, Menge und eindeutig zugeordneter Preis pro Einheit oder Gesamtpreis jeder Position. |
| Hat Bella Farina eine neue Telefonnummer? | Nein. E1 und E3 zeigen dieselbe Nummer. Die Liste sagt nicht, ob sie noch aktuell ist. | Die aktuelle, bestätigte Telefonnummer des Lieferanten; für einen Vergleich auch die bisherige Nummer oder eine Änderungshistorie. |

**Rechenbeispiel, falls die Preise Einzelpreise sind:**

- Bella Farina: 25 × 1,20 + 2 × 4,50 + 25 × 1,20 = 69,00.
- Caseificio Rossi: 10 × 8,90 + 2 × 19,50 = 128,00.
- Fratelli Pomodoro: 24 × 2,10 + 3 × 1,90 = 56,10.

Unter dieser Annahme gibt Luigi bei **Caseificio Rossi** am meisten aus. Die Liste nennt keine Währung.

**Zwei Vorteile einer Datenbank:**

1. Lieferantendaten können einmal in einer eigenen Tabelle gespeichert werden. Einkäufe verweisen auf den Lieferanten. So muss man eine Telefonnummer nur an einer Stelle ändern und vermeidet widersprüchliche Angaben.
2. Mit SQL kann man Mengen und Ausgaben schnell auswerten. Man muss die passenden Zeilen nicht jedes Mal von Hand suchen und zusammenrechnen.

**Merksatz:** Eine gut aufgebaute Datenbank speichert Daten geordnet, vermeidet unnötige Wiederholungen und erleichtert Auswertungen. Aktuelle Telefonnummern muss man trotzdem selbst eintragen.

### Aufgabe 3 – Das Repository vorbereiten

- Den aktuellen Stand mit `git pull` holen.
- Prüfen, dass `datenbank/marios_pizza_start.sql` vorhanden ist.
- Die Ergebnisse in `datenbank/uebungen.md` unter `# Übungen Datenbank` und `## Übung 00` sammeln.
- Die Datei speichern, mit Git sichern und auf GitHub prüfen.
