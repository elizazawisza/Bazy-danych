CREATE FUNCTION `Laboratorium3`.`Laplace`(a float, b float, x float) RETURNS float
    DETERMINISTIC
BEGIN
	return ((1/(2*b))*exp(-((abs(x-a))/b)));
END

CREATE
	 PROCEDURE `Laboratorium3`.`Zadanie7`(in nazwa_kolumny varchar(50),
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
