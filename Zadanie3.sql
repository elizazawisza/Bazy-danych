select
	imie
from
	aktorzy use index (aktorzy1litera_index)
where
	imie like 'J%'

select
	nazwisko
from
	aktorzy use index (aktorzy_index)
where
	ilosc_filmow >= 12

select
	distinct tytul
from
	filmy as f
join zagrali as z1 on
	f.film_id = z1.film_id
where
	z1.actor_id in (
	select
		actor_id
	from
		zagrali
	where
		zagrali.film_id in (
		select
			z.film_id
		from
			zagrali as z
		join aktorzy as a
		where
			a.id = z.actor_id
			and a.imie = 'ZERO'
			and a.nazwisko = 'CAGE')) oreder by 1


select
	aktor
from
	kontrakty use index (koniec_index)
where
	kontrakty.koniec in (
	select
		min(koniec)
	from
		kontrakty
	where
		koniec>curdate())

		select
			imie,
			max(suma)
		from
			(
			select
				imie,
				count(imie) as suma
			from
				aktorzy use index (aktorzy1litera_index)
			group by
				imie) as wynik
