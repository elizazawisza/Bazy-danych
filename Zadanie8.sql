CREATE FUNCTION `Laboratorium-Filmoteka`.zadanie8(lic varchar(30))
RETURNS INT deterministic
BEGIN
	declare wynik int default 0;
	select avg(gaza) from kontrakty as k join agenci as a on k.agent = a.licencja where lic = a.licencja and k.koniec>CURDATE() into wynik;
	if wynik=0 then
	return null;
	else
	return wynik;
end if;
END
