// Mario's Pizza – Ersatzdaten für die Speisekarte
// Werden nur gezeigt, solange die Datenbank (api/artikel.php) nicht erreichbar ist.
// Gleicher Aufbau wie die Antwort von api/artikel.php: id, name, beschreibung, preis, kategorie
const SPEISEKARTE = [
    { id: 1, name: "Margherita", beschreibung: "Tomaten, Mozzarella, Basilikum", preis: 12.5, kategorie: "Pizza" },
    { id: 2, name: "Pepperoni", beschreibung: "Tomaten, Mozzarella, Pepperoni-Salami", preis: 14, kategorie: "Pizza" },
    { id: 3, name: "Funghi", beschreibung: "Tomaten, Mozzarella, frische Champignons", preis: 14, kategorie: "Pizza" },
    { id: 4, name: "Mario's Special", beschreibung: "Schinken, Pilze, Oliven", preis: 16.5, kategorie: "Pizza" },
    { id: 5, name: "Luigi's Verde", beschreibung: "Spinat, Rucola, Pesto", preis: 15, kategorie: "Pizza" },
    { id: 6, name: "Quattro Formaggi", beschreibung: "Vier Käsesorten", preis: 15.5, kategorie: "Pizza" },
    { id: 7, name: "Cola", beschreibung: "0,4 l", preis: 3.5, kategorie: "Getränk" },
    { id: 8, name: "Wasser", beschreibung: "0,5 l", preis: 3, kategorie: "Getränk" },
    { id: 9, name: "Tiramisu", beschreibung: "Nach Rezept der Nonna", preis: 6.5, kategorie: "Dessert" }
];
