# Übungen Datenbank

## Übung 00
- doppelt: Bella Farina mit Telefon in E1 und E3
- mehrere Werte: „Mehl Tipo 00, Hefe“ in einer Zelle
- Widerspruch: Mehlpreis könnte 1,20 und 1,25 lauten
- Frage: Mehl im September nur von Hand

## Übung 01

| Entität | Attribute |
| --- | --- |
| rezept | titel, zubereitungsdauer, schwierigkeit, veroeffentlichungsdatum |
| kategorie | bezeichnung |
| zutat | name, einheit |
| leser | vorname, nachname, email |
| kommentar | text, sterne |

## Übung 05

| einkauf_nr | datum | lieferant | telefon | ware | menge | preis | gruppe |
| --- | --- | --- | --- | --- | --- | --- | --- |
| E1 | 01.09.26 | Bella Farina | +1 718 555 0301 | Mehl Tipo 00 | 25 | 1,20 | Teig |
| E1 | 01.09.26 | Bella Farina | +1 718 555 0301 | Hefe | 2 | 4,50 | Teig |
| E2 | 02.09.26 | Caseificio Rossi | +1 718 555 0302 | Mozzarella | 10 | 8,90 | Käse |
| E2 | 02.09.26 | Caseificio Rossi | +1 718 555 0302 | Parmesan | 2 | 19,50 | Käse |
| E3 | 08.09.26 | Bella Farina | +1 718 555 0301 | Mehl Tipo 00 | 25 | 1,20 | Teig |
| E4 | 09.09.26 | Fratelli Pomodoro | +1 718 555 0303 | Tomaten (Dose) | 24 | 2,10 | Gemüse |
| E4 | 09.09.26 | Fratelli Pomodoro | +1 718 555 0303 | Basilikum | 3 | 1,90 | Gemüse |

Primärschlüssel: (`einkauf_nr`, `ware`).
