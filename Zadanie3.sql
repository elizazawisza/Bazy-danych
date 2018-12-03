ALTER TABLE aktorzy
ADD ilosc_filmow smallint (5) unsigned;

update aktorzy
set ilosc_filmow = (SELECT count(film_id) FROM zagrali where aktorzy.id = zagrali.actor_id GROUP by actor_id)

update aktorzy
set tytuly_filmow =
(select group_concat(tytul) from zagrali as z join filmy as f on z.film_id = f.film_id where aktorzy.ilosc_filmow<4 and aktorzy.id = z.actor_id);
