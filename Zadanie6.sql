CREATE TRIGGER zadanie6
BEFORE insert
ON kontrakty FOR EACH ROW
BEGIN
set @gaza = new.gaza;
set @poczatek = new.poczatek;
set @koniec = new.koniec;
if (@gaza<0 or @poczatek>@koniec or @koniec=@poczatek) THEN
SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Nie można dodać rekordu, zawiera on nieprawidłowe dane';
end if;
END

CREATE TRIGGER zadanie6a
BEFORE update
ON kontrakty FOR EACH ROW
BEGIN
set @gaza = new.gaza;
set @poczatek = new.poczatek;
set @koniec = new.koniec;
if (@gaza<0 or @poczatek>@koniec or @koniec=@poczatek) THEN
SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Nie można dodać rekordu, zawiera on nieprawidłowe dane';
end if;
END

CREATE PROCEDURE `Laboratorium-Filmoteka`.`dodaj30`()
BEGIN
declare aktorzyilosc int;
declare k int default 30;
declare i int default 0;

select count(id) into aktorzyilosc from aktorzy;

while i < k do insert
	into
		kontrakty(agent, aktor, poczatek, koniec, gaza)
	VALUES ((select agenci.licencja from agenci order by rand() limit 1),
	(select id from aktorzy order by rand() limit 1) , date_sub(curdate(), interval rand()*(365-50)+50 day)  , date_sub(curdate(),interval rand()*50 day),
	rand()*(10000-1000)+ 1000);
set
	i = i + 1;
end while;
END





ALTER TABLE kontrakty CHANGE gaza gaza INT( 11 ) COMMENT 'peso argentyńskie na tydzień'
