USE marios_pizza;

SELECT a.artikel_id as id,
	   a.name,
       a.beschreibung,
       a.preis,
       k.bezeichnung AS kategorie
FROM artikel AS a
INNER JOIN kategorie as k
	ON a.kategorie_id = k.kategorie_id
ORDER BY k.kategorie_id, a.artikel_id;