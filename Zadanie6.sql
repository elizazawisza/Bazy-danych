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

while czy_wyplacamy = 1 do fetch cursor_pensja into
	wyplata;

set
	reszta_budzet = budzet-wyplata;

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
