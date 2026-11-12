USE marios_pizza;

UPDATE artikel
SET preis = 12.50
WHERE artikel_id = 1;

SELECT name, preis
FROM artikel
WHERE artikel_id = 1;