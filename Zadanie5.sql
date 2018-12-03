CREATE PROCEDURE utworzAgentow(in ilosc int)
begin
declare i int default 0;

declare value int default 11672;

while i < ilosc do insert
	into
		agenci(licencja,
		nazwa,
		wiek,
		typ)
	values( value,
	concat_ws(' ', elt(floor(rand()* 30 + 1), 'John', 'David', 'Stephen', 'Sarah', 'Emma', 'Rick', 'Mike', 'Susan', 'Gorge', 'Rebecca', 'Sophia', 'Adam', 'Matts', 'Zack', 'Tom', 'Chris', 'Loise', 'Meghan', 'Kate', 'Charlotte', 'Jacob', 'Andrew', 'Ann', 'Liam', 'Isabell', 'Olivier', 'Olivia', 'Paul', 'Emily', 'Brian'), elt(floor(rand()* 30 + 1), 'Smith', 'Johnson', 'Williams', 'Brown', 'Miller', 'Wilson', 'Jones', 'Davis', 'Lopez', 'Perez', 'Allen', 'King', 'Scott', 'Cruz', 'Price', 'Ramos', 'Graham', 'Kim', 'Ruiz', 'West', 'Ryan', 'Daniels', 'Walker', 'Duncan', 'Bradley', 'Lopez', 'Hopes', 'Silva', 'Matthiews', 'Powers')),
	rand()* (99-21) + 21,
	elt(floor(rand()* 3 + 1), 'osoba indywidualna', 'agencja', 'inny'));

set
	i = i + 1;

set
	value = value + 17;

end while;

end

call utworzagentow(1000);


CREATE
	DEFINER = `root` @`localhost` PROCEDURE `Laboratorium-Filmoteka`.`dodajkontrakt`()
BEGIN
	declare aktorzyilosc int;

declare k int default 0;

select
	count(id) into
		aktorzyilosc
	from
		aktorzy;

while k < aktorzyilosc do insert
	into
		kontrakty(agent,
		aktor,
		poczatek,
		koniec,
		gaza)
	VALUES ((
	select
		agenci.licencja
	from
		agenci
	order by
		rand()
	limit 1),
	(
	select
		id
	from
		aktorzy
	limit k,
	1) ,
	curdate(),
	date_add(curdate(),
	interval rand()* 480 day),
	rand()*(10000-1000)+ 1000);

set
	k = k + 1;
end while;
END

call dodajkontrakt();
