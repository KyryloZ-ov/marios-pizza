// Mario's Pizza – script.js (TAI12: Website mit Datenbank)
// 1. Öffnungsstatus · 2. Speisekarte (aus der Datenbank) · 3. Bestellzettel · 4. Bestellung senden
// 5. Handy-Menü, Karte, „Nach oben“ (wie in der 11. Klasse)

// Preis hübsch formatieren (12.5 → "12,50 $")
const formatPreis = (preis) => preis.toFixed(2).replace(".", ",") + " $";

/* ---------- 1. Öffnungsstatus ---------- */
// Mo Ruhetag · Di–Fr 11:30–14:00 und 17:00–22:00 · Sa 12:00–23:00 · So 12:00–21:00
function zeigeStatus() {
    const jetzt = new Date();
    const wochentag = jetzt.getDay();                           // 0 = Sonntag … 6 = Samstag
    const stunde = jetzt.getHours() + jetzt.getMinutes() / 60;  // 13:30 Uhr → 13.5
    let offen = false;
    if (wochentag === 0) {
        offen = stunde >= 12 && stunde < 21;
    } else if (wochentag === 6) {
        offen = stunde >= 12 && stunde < 23;
    } else if (wochentag >= 2) {
        offen = (stunde >= 11.5 && stunde < 14) || (stunde >= 17 && stunde < 22);
    }
    const tage = ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"];
    const status = document.getElementById("status");
    if (offen) {
        status.textContent = `Heute ist ${tage[wochentag]} – wir haben gerade geöffnet. Bis gleich!`;
        status.classList.add("offen");
    } else {
        status.textContent = `Heute ist ${tage[wochentag]} – wir haben gerade geschlossen.`;
        status.classList.add("geschlossen");
    }
}

/* ---------- 2. Speisekarte ---------- */
let speisekarte = SPEISEKARTE;          // Ersatzdaten aus speisekarte.js – ladeSpeisekarte() ersetzt sie
const quelle = document.getElementById("quelle");
const liste = document.getElementById("speisekarte-liste");
const UEBERSCHRIFT = { "Pizza": "Pizzen", "Getränk": "Getränke", "Dessert": "Desserts" };

async function ladeSpeisekarte() {
    // TODO Übung 11, Aufgabe 4: Speisekarte aus der Datenbank laden
    // 1. const antwort = await fetch("api/artikel.php");
    // 2. Ist antwort.ok falsch: throw new Error("HTTP " + antwort.status);
    // 3. const daten = await antwort.json();   und dann   speisekarte = daten;
    // 4. In das Element quelle schreiben: "Speisekarte aus der Datenbank geladen."
    // 5. Alles in try { … } catch (fehler) { … } – im catch bleiben die Ersatzdaten,
    //    quelle meldet: "Datenbank nicht erreichbar – Ersatzdaten werden gezeigt."
    quelle.textContent = "Ersatzdaten aus speisekarte.js – die Datenbank ist noch nicht angebunden (Übung 11).";
}

function zeigeSpeisekarte() {
    liste.innerHTML = "";
    const kategorien = [...new Set(speisekarte.map((artikel) => artikel.kategorie))];
    kategorien.forEach((kategorie) => {
        const ueberschrift = document.createElement("h3");
        ueberschrift.textContent = UEBERSCHRIFT[kategorie] || kategorie;
        liste.appendChild(ueberschrift);

        const ul = document.createElement("ul");
        speisekarte.filter((artikel) => artikel.kategorie === kategorie).forEach((artikel) => {
            const eintrag = document.createElement("li");
            const text = document.createElement("span");
            const name = document.createElement("strong");
            name.textContent = artikel.name;              // textContent statt innerHTML: Daten aus der
            text.append(name, ` – ${artikel.beschreibung} – ${formatPreis(artikel.preis)}`);  // Datenbank nie als HTML
            const plus = document.createElement("button");
            plus.type = "button";
            plus.className = "plus";
            plus.textContent = "+";
            plus.setAttribute("aria-label", `${artikel.name} auf den Bestellzettel`);
            plus.addEventListener("click", () => hinzufuegen(artikel.id));
            eintrag.append(text, plus);
            ul.appendChild(eintrag);
        });
        liste.appendChild(ul);
    });
}

/* ---------- 3. Bestellzettel ---------- */
// bestellung = Map: artikel_id → Menge. Genau das speichert die Tabelle bestellposition.
const bestellung = new Map();
const zettelListe = document.getElementById("zettel-liste");
const zettelLeer = document.getElementById("zettel-leer");
const zettelSumme = document.getElementById("zettel-summe");
const senden = document.getElementById("zettel-senden");
const meldung = document.getElementById("zettel-meldung");
const formular = document.getElementById("bestellformular");
const lieferart = document.getElementById("lieferart");
const adressfelder = document.getElementById("adressfelder");

function zeigeMeldung(text, art) {
    meldung.textContent = text;
    meldung.className = art || "";
}

function hinzufuegen(id) {
    bestellung.set(id, (bestellung.get(id) || 0) + 1);
    zeigeMeldung("");
    zeigeZettel();
}

function aendereMenge(id, schritt) {
    const neu = (bestellung.get(id) || 0) + schritt;
    if (neu <= 0) {
        bestellung.delete(id);
    } else {
        bestellung.set(id, neu);
    }
    zeigeZettel();
}

function zeigeZettel() {
    zettelListe.innerHTML = "";
    let summe = 0;
    for (const [id, menge] of bestellung) {
        const artikel = speisekarte.find((a) => a.id === id);
        summe += artikel.preis * menge;
        const zeile = document.createElement("li");
        const text = document.createElement("span");
        text.textContent = `${menge} × ${artikel.name} – ${formatPreis(artikel.preis * menge)}`;
        const weniger = document.createElement("button");
        weniger.type = "button";
        weniger.textContent = "−";
        weniger.setAttribute("aria-label", `Eins weniger ${artikel.name}`);
        weniger.addEventListener("click", () => aendereMenge(id, -1));
        const mehr = document.createElement("button");
        mehr.type = "button";
        mehr.textContent = "+";
        mehr.setAttribute("aria-label", `Eins mehr ${artikel.name}`);
        mehr.addEventListener("click", () => aendereMenge(id, +1));
        zeile.append(text, weniger, mehr);
        zettelListe.appendChild(zeile);
    }
    zettelLeer.hidden = bestellung.size > 0;
    zettelSumme.textContent = formatPreis(summe);
    senden.disabled = bestellung.size === 0;
}

// Adressfelder nur bei Lieferung zeigen – dann sind sie Pflicht
lieferart.addEventListener("change", () => {
    adressfelder.hidden = lieferart.value !== "Lieferung";
    for (const feld of adressfelder.querySelectorAll("input")) {
        feld.required = !adressfelder.hidden;
    }
});

/* ---------- 4. Bestellung senden ---------- */
async function schickeAb(ereignis) {
    ereignis.preventDefault();                  // Seite nicht neu laden
    const eingabe = new FormData(formular);     // eingabe.get("vorname") liefert den Wert des Feldes

    // TODO Übung 12, Aufgabe 3: Bestellung an api/bestellung.php schicken
    // 1. Objekt daten bauen – genau wie im Kommentar oben in api/bestellung.php:
    //    kunde (vorname, nachname, telefon, strasse, plz, ort), lieferart, positionen.
    //    positionen: aus der Map bestellung ein Array aus { artikel_id, menge } machen:
    //    [...bestellung].map(([id, menge]) => ({ artikel_id: id, menge: menge }))
    //    Preise schickst du NICHT mit – die kennt der Server.
    // 2. const antwort = await fetch("api/bestellung.php", { method: "POST",
    //       headers: { "Content-Type": "application/json" }, body: JSON.stringify(daten) });
    // 3. const ergebnis = await antwort.json();
    //    antwort.ok falsch → zeigeMeldung(ergebnis.fehler, "fehler")
    //    sonst → bestellung.clear(); zeigeZettel(); formular.reset(); adressfelder.hidden = true;
    //            zeigeMeldung(`Danke! Bestellung Nr. ${ergebnis.bestell_id} ist gespeichert.`, "ok");
    // 4. catch-Block: "Keine Verbindung zum Server."
    zeigeMeldung("Übung 12, Aufgabe 3 fehlt noch: Die Bestellung wird noch nicht gesendet.", "fehler");
}

formular.addEventListener("submit", schickeAb);

/* ---------- 5. Handy-Menü, Karte, Nach oben (aus der 11. Klasse) ---------- */
const menuButton = document.getElementById("menu-button");
const navListe = document.querySelector("nav ul");
menuButton.addEventListener("click", () => {
    navListe.classList.toggle("offen");
});

// Google Maps erst nach Klick laden (Datenschutz: vorher fließen keine Daten an Google)
const karteButton = document.getElementById("karte-laden");
const karte = document.getElementById("karte");
karteButton.addEventListener("click", () => {
    karte.innerHTML = `<iframe src="https://www.google.com/maps?q=Court+Street+Montague+Street+Brooklyn+NY&output=embed"
        width="100%" height="350" style="border: 0" loading="lazy" title="Karte: Mario's Pizza in Brooklyn"></iframe>`;
});

const nachOben = document.querySelector('a[href="#top"]');
nachOben.addEventListener("click", (ereignis) => {
    ereignis.preventDefault();
    window.scrollTo({ top: 0, behavior: "smooth" });
});

/* ---------- Start ---------- */
async function start() {
    zeigeStatus();
    await ladeSpeisekarte();
    zeigeSpeisekarte();
    zeigeZettel();
}
start();
