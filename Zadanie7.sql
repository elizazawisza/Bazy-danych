CREATE FUNCTION `Laboratorium-Filmoteka`.zadanie7(imie VARCHAR(45), nazwisko varchar(45)) returns varchar(120) deterministic
BEGIN
declare wynik VARCHAR(120) default '';
select CONCAT_WS (' ', a.nazwa, datediff(koniec,curdate())) from kontrakty as k join agenci as a on k.agent = a.licencja
join aktorzy as ak on k.aktor = ak.id where ak.imie = imie and ak.nazwisko = nazwisko into wynik;
if wynik ='' then set wynik='Niestety nie ma w bazie takiego aktora';
end if;
RETURN wynik;
END

select zadanie7('CHRIS', 'DEPP');
