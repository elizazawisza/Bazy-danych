CREATE DEFINER=`root`@`localhost` TRIGGER zadanie12 BEFORE INSERT
		ON
		kontrakty FOR EACH ROW
	begin
		if not exists( select id from aktorzy where new.aktor = id) then
		SIGNAL SQLSTATE '45000' SET
			MESSAGE_TEXT = 'Nie można dodać rekordu, aktora nie ma w bazie';

		end if;

		if exists (
		select
			*
		from
			kontrakty
		where
			poczatek<curdate()
			and koniec>curdate()
			and new.aktor = aktor) then SIGNAL SQLSTATE '45000' SET
			MESSAGE_TEXT = 'Nie można dodać rekordu, aktor ma trwający kontrakt';
end if;

if not exists (
select
	*
from
	agenci
where
	new.agent = licencja) then insert
	into
		agenci(licencja,
		nazwa,
		wiek,
		typ)
	values(new.agent,
	concat_ws(' ', elt(floor(rand()* 30 + 1), 'John', 'David', 'Stephen', 'Sarah', 'Emma', 'Rick', 'Mike', 'Susan', 'Gorge', 'Rebecca', 'Sophia', 'Adam', 'Matts', 'Zack', 'Tom', 'Chris', 'Loise', 'Meghan', 'Kate', 'Charlotte', 'Jacob', 'Andrew', 'Ann', 'Liam', 'Isabell', 'Olivier', 'Olivia', 'Paul', 'Emily', 'Brian'), elt(floor(rand()* 30 + 1), 'Smith', 'Johnson', 'Williams', 'Brown', 'Miller', 'Wilson', 'Jones', 'Davis', 'Lopez', 'Perez', 'Allen', 'King', 'Scott', 'Cruz', 'Price', 'Ramos', 'Graham', 'Kim', 'Ruiz', 'West', 'Ryan', 'Daniels', 'Walker', 'Duncan', 'Bradley', 'Lopez', 'Hopes', 'Silva', 'Matthiews', 'Powers')),
	rand()* (99-21) + 21,
	elt(floor(rand()* 3 + 1), 'osoba indywidualna', 'agencja', 'inny'));
end if;
end
