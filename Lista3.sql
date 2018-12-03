Zadanie 1:
create
	index filmy_index on
	filmy(tytul)
create
	index aktorzy_index on
	aktorzy(nazwisko)
create
	index aktorzy1litera_index on
	aktorzy(imie(1))
create
	index aktorzagrali_index on
	zagrali(actor_id)

Zadanie 2:
create
	index koniec_index
		using btree on
	kontrakty(koniec)
select
	aktor
from
	kontrakty use index (koniec_index)
where
	koniec< date_add(curdate(),
	interval 1 month)

Zadanie 3: 
SELECT
	imie
FROM
	aktorzy use INDEX (aktorzy1litera_index)
WHERE
	imie LIKE 'J%'

SELECT
	nazwisko
FROM
	aktorzy use INDEX (aktorzy_index)
WHERE
	ilosc_filmow >= 12

SELECT
	DISTINCT tytul
FROM
	filmy AS f
JOIN zagrali AS z1 ON
	f.film_id = z1.film_id
WHERE
	z1.actor_id IN (
	SELECT
		actor_id
	FROM
		zagrali
	WHERE
		zagrali.film_id IN (
		SELECT
			z.film_id
		FROM
			zagrali AS z
		JOIN aktorzy AS a
		WHERE
			a.id = z.actor_id
			AND a.imie = 'ZERO'
			AND a.nazwisko = 'CAGE')) oreder BY 1


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

SELECT
	imie,
	MAX(suma)
FROM
	(
	SELECT
		imie,
		COUNT(imie) AS suma
	FROM
		aktorzy use INDEX (aktorzy1litera_index)
	GROUP BY
		imie) AS wynik

Zadanie 4:
create
	database Laboratorium3

create
	table
		ludzie (PESEL char(11) primary key,
		imie varchar(30),
		nazwisko varchar(30),
		data_urodzenia date,
		wzrost float,
		waga float,
		rozmiar_buta int,
		ulubiony_kolor enum('czarny',
		'czerwony',
		'zielony',
		'niebieski',
		'biały'));

create
	table
		pracownicy (PESEL char(11),
		zawod varchar(50),
		pensja float);

  CREATE TRIGGER dodawanie_danych BEFORE INSERT
  		ON
  		ludzie FOR EACH ROW
  	BEGIN
  		IF rozmiar_buta <= 0
  		OR waga <= 0
  		OR wzrost <= 0 THEN SIGNAL SQLSTATE '45000' set
  			message_text = 'Niektóre z podancyh danych są nieprawidłowe.';
  END IF;
  		IF NEW.PESEL REGEXP '[0-9]' or CHAR_LENGTH(NEW.PESEL)<11 THEN
  	SIGNAL SQLSTATE '45000'
  	set message_text = 'Podany numer pesel jest nieprawidłowy';
  END IF;
  END

  CREATE TRIGGER aktualizacja_ujemne
BEFORE UPDATE
ON ludzie FOR EACH ROW
	BEGIN
		IF rozmiar_buta <= 0
		OR waga <= 0
		OR wzrost <= 0 THEN SIGNAL SQLSTATE '45000' set
			message_text = 'Niektóre z podancyh danych są nieprawidłowe.';
END IF;
END

CREATE PROCEDURE `Laboratorium3`.`dodawanie_ludzi`()
BEGIN
	declare i int default 0;
	declare data_urodzin date;
	declare pesel char(11);
	declare tmp int;
	while i<200 do
		set data_urodzin = subdate(curdate(), interval rand()*(25500-6205)+6205 day);
		set pesel = convert(data_urodzin, char);
		set pesel = replace(pesel, '-','');
		set pesel = substring(pesel, 3, 6);
		set tmp = rand()*(99999-10000)+10000;
		insert into ludzie (PESEL, imie, nazwisko, data_urodzenia, wzrost, waga, rozmiar_buta, ulubiony_kolor) values (concat(pesel, tmp), (select imie from `Laboratorium-Filmoteka`.aktorzy order by rand() limit 1),
		(select nazwisko from `Laboratorium-Filmoteka`.aktorzy order by rand() limit 1), data_urodzin, rand()*56 +150, rand()*74+50, floor(rand()*(45-35))+35,
		elt(floor(rand()* 5 + 1), 'czarny', 'czerwony', 'zielony', 'niebieski', 'biały'));
		set i= i+1;
	end while;
END

insert
	into
		pracownicy(PESEL) select
			PESEL
		from
			ludzie
		where
			timestampdiff(year,
			ludzie.data_urodzenia,
			curdate())>18
		order by
			rand()
		limit 175;

update
	pracownicy set
		zawod = 'sprzedawca'
	where
		zawod is null
	limit 77;
update
	pracownicy set
		pensja = rand()*(4500-2000)+ 2000
	where
		zawod = 'sprzedawca';

update
	pracownicy set
		zawod = 'aktor'
	where
		zawod is null
	limit 50;
update
	pracownicy set
		pensja = rand()*(45000-32000)+ 32000
	where
		zawod = 'aktor';

update
	pracownicy set
		zawod = 'informatyk'
	where
		zawod is null
	limit 13;
update
	pracownicy set
		pensja = rand()*(35000-15000)+ 15000
	where
		zawod = 'informatyk';

update
	pracownicy set
		zawod = 'agent'
	where
		zawod is null
	limit 33;
update
	pracownicy set
		pensja = rand()*(10000-5300)+ 5300
	where
		zawod = 'agent';

update
	pracownicy set
		zawod = 'reporter'
	where
		zawod is null
	limit 2;
update
	pracownicy set
		pensja = rand()*(5300-3400)+ 3400
	where
		zawod = 'reporter';


Zadanie 5:

CREATE PROCEDURE `Laboratorium3`.`zadanie5`(in agg varchar(20), kol varchar(40))
BEGIN
	case
		when agg='min' then case
			when kol='PESEL' then select agg, kol, min(PESEL) from ludzie;
			when kol='imie' then select agg, kol, min(imie) from ludzie;
			when kol='nazwisko' then select agg, kol, min(nazwisko) from ludzie;
			when kol='data_urodzenia' then select agg, kol, min(data_urodzenia) from ludzie;
			when kol='wzrost' then select agg, kol, min(wzrost) from ludzie;
			when kol='waga' then select agg, kol, min(waga) from ludzie;
			when kol='rozmiar_buta' then select agg, kol, min(rozmiar_buta) from ludzie;
			when kol='ulubiony_kolor' then select agg, kol, min(ulubiony_kolor) from ludzie;
		end case;
		when agg='max' then case
			when kol='PESEL' then select agg, kol, max(PESEL) from ludzie;
			when kol='imie' then select agg, kol, max(imie) from ludzie;
			when kol='nazwisko' then select agg, kol, max(nazwisko) from ludzie;
			when kol='data_urodzenia' then select agg, kol, max(data_urodzenia) from ludzie;
			when kol='wzrost' then select agg, kol, max(wzrost) from ludzie;
			when kol='waga' then select agg, kol, max(waga) from ludzie;
			when kol='rozmiar_buta' then select agg, kol, max(rozmiar_buta) from ludzie;
			when kol='ulubiony_kolor' then select agg, kol, max(ulubiony_kolor) from ludzie;
		end case;
		when agg='count' then case
			when kol='PESEL' then select agg, kol, count(PESEL) from ludzie;
			when kol='imie' then select agg, kol, count(imie) from ludzie;
			when kol='nazwisko' then select agg, kol, count(nazwisko) from ludzie;
			when kol='data_urodzenia' then select agg, kol, count(data_urodzenia) from ludzie;
			when kol='wzrost' then select agg, kol, count(wzrost) from ludzie;
			when kol='waga' then select agg, kol, count(waga) from ludzie;
			when kol='rozmiar_buta' then select agg, kol, count(rozmiar_buta) from ludzie;
			when kol='ulubiony_kolor' then select agg, kol, count(ulubiony_kolor) from ludzie;
		end case;
		when agg='avg' then case
			when kol='PESEL' then select agg, kol, avg(PESEL) from ludzie;
			when kol='imie' then select agg, kol, avg(imie) from ludzie;
			when kol='nazwisko' then select agg, kol, avg(nazwisko) from ludzie;
			when kol='data_urodzenia' then select agg, kol, avg(data_urodzenia) from ludzie;
			when kol='wzrost' then select agg, kol, avg(wzrost) from ludzie;
			when kol='waga' then select agg, kol, avg(waga) from ludzie;
			when kol='rozmiar_buta' then select agg, kol, avg(rozmiar_buta) from ludzie;
			when kol='ulubiony_kolor' then select agg, kol, avg(ulubiony_kolor) from ludzie;
		end case;
		when agg='sum' then case
			when kol='PESEL' then select agg, kol, sum(PESEL) from ludzie;
			when kol='imie' then select agg, kol, sum(imie) from ludzie;
			when kol='nazwisko' then select agg, kol, sum(nazwisko) from ludzie;
			when kol='data_urodzenia' then select agg, kol, sum(data_urodzenia) from ludzie;
			when kol='wzrost' then select agg, kol, sum(wzrost) from ludzie;
			when kol='waga' then select agg, kol, sum(waga) from ludzie;
			when kol='rozmiar_buta' then select agg, kol, sum(rozmiar_buta) from ludzie;
			when kol='ulubiony_kolor' then select agg, kol, sum(ulubiony_kolor) from ludzie;
		end case;
	end case;
END

Zadanie 6:

CREATE PROCEDURE `Laboratorium3`.`Zadanie6`(in budzet float,
	stanowisko varchar(50))
BEGIN
	declare czy_wyplacamy int default 1;
	declare wyplata float;
	declare reszta_budzet float;
	declare pesel_pracownika char(11);
	declare cursor_pensja cursor for select
		pensja
		from
		pracownicy
		where
		zawod = stanowisko;
	declare cursor_pesel cursor for select
		PESEL
		from
		pracownicy
		where
		zawod = stanowisko;

	declare continue handler for not found set
		czy_wyplacamy = 0;

		create
			temporary table
			wyplaty (PESEL char(11),
			status enum('Wyplacono') not null);

	start transaction;
	open cursor_pensja;
	open cursor_pesel;

	while czy_wyplacamy = 1 do 
	fetch cursor_pensja into wyplata;
	set reszta_budzet = budzet-wyplata;

	if reszta_budzet <0 then set
		czy_wyplacamy=0;
	else if czy_wyplacamy=1 then fetch cursor_pesel into
		pesel_pracownika;
	insert
	into
		wyplaty
	values(concat('********', right(pesel_pracownika, 3)),
	'Wyplacono' );
	end if;
	end if;
	end while;
	commit;
	close cursor_pensja;
	close cursor_pesel;

select
	*
from
	wyplaty;
END

Zadanie 7:
CREATE FUNCTION `Laboratorium3`.`Laplace`(a float, b float, x float) RETURNS float
    DETERMINISTIC
BEGIN
	return ((1/(2*b))*exp(-((abs(x-a))/b)));
END

CREATE PROCEDURE `Laboratorium3`.`Zadanie7`(in nazwa_kolumny varchar(50),
	nazwa_zawodu varchar(50))
BEGIN
	declare epsilon float default 0.05;

declare prywatnosc float;

declare suma float;

declare losowy float;

drop
	table
		if exists tabela_prywatnosci;

set
	@zapytanie_dane = nazwa_zawodu;

set
	@tresc_zapytania = concat('create temporary table tabela_prywatnosci as (select ', nazwa_kolumny, ' as wartosc , pracownicy.PESEL from ludzie inner join pracownicy on pracownicy.PESEL=ludzie.PESEL
    where zawod=?);');

prepare zapytanie
from
@tresc_zapytania;

execute zapytanie
	using @zapytanie_dane;

set
	suma = (
	select
		sum(wartosc)
	from
		tabela_prywatnosci);

set
	losowy = (
	select
		wartosc
	from
		tabela_prywatnosci
	order by
		rand()
	limit 1);

set
	prywatnosc = Laplace(0,
	losowy / epsilon,
	suma);

select
	suma + prywatnosc;
END

Zadanie 8:

create
	table
		logi(PESEL char(11),
		stara_pensja float,
		nowa_pensja float,
		czas_zmiant datetime,
		uzytkownik varchar(90))

  create trigger zad8 after update
  		on
  		pracownicy for each row
  	begin
  		if new.pensja <> old.pensja then insert
  			into
  				`zadanie8`.logi
  			values(old.PESEL,
  			old.pensja,
  			new.pensja,
  			now(),
  			current_user());
  end if;
  end
