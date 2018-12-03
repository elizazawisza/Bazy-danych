CREATE TRIGGER dodaj_zagrali
AFTER INSERT
ON zagrali FOR EACH ROW
BEGIN
update aktorzy set ilosc_filmow = (SELECT count(film_id) FROM zagrali where aktorzy.id = zagrali.actor_id GROUP by actor_id);
update aktorzy set tytuly_filmow = (select group_concat(tytul) from zagrali as z join filmy as f on z.film_id = f.film_id where aktorzy.ilosc_filmow<4 and aktorzy.id = z.actor_id);
END

CREATE TRIGGER aktualizuj_zagrali
AFTER UPDATE
ON zagrali FOR EACH ROW
BEGIN
update aktorzy set ilosc_filmow = (SELECT count(film_id) FROM zagrali where aktorzy.id = zagrali.actor_id GROUP by actor_id);
update aktorzy set tytuly_filmow = (select group_concat(tytul) from zagrali as z join filmy as f on z.film_id = f.film_id where aktorzy.ilosc_filmow<4 and aktorzy.id = z.actor_id);
END

CREATE TRIGGER usun_zagrali
AFTER DELETE
ON zagrali FOR EACH ROW
BEGIN
update aktorzy set ilosc_filmow = (SELECT count(film_id) FROM zagrali where aktorzy.id = zagrali.actor_id GROUP by actor_id);
update aktorzy set tytuly_filmow = (select group_concat(tytul) from zagrali as z join filmy as f on z.film_id = f.film_id where aktorzy.ilosc_filmow<4 and aktorzy.id = z.actor_id);
END
