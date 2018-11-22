create database Laboratorium3

create table ludzie (PESEL char(11) primary key, imie varchar(30), nazwisko varchar(30), data_urodzenia date, wzrost float, waga float, rozmiar_buta int,
ulubiony_kolor enum('czarny', 'czerwony', 'zielony', 'niebieski', 'biały') )

create table pracownicy (PESEL char(11), zawod varchar(50), pensja float)


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

call dodawanie_ludzi();


insert into pracownicy(PESEL) select PESEL from ludzie where timestampdiff(year, ludzie.data_urodzenia, curdate())>18 order by rand() limit 175;

	update pracownicy set zawod = 'sprzedawca' where zawod is null limit 77;
  update pracownicy set pensja = rand()*(4500-2000)+2000 where zawod='sprzedawca';

  update pracownicy set zawod ='aktor' where zawod is null limit 50;
  update pracownicy set pensja = rand()*(45000-32000)+32000 where zawod='aktor';

  update pracownicy set zawod ='informatyk' where zawod is null limit 13;
  update pracownicy set pensja = rand()*(35000-15000)+15000 where zawod='informatyk';

  update pracownicy set zawod ='agent' where zawod is null limit 33;
  update pracownicy set pensja = rand()*(10000-5300)+5300 where zawod='agent';

  update pracownicy set zawod = 'reporter' where zawod is null limit 2;
  update pracownicy set pensja = rand()*(5300-3400)+3400 where zawod='reporter';
