CREATE DEFINER=`root`@`localhost` PROCEDURE `Laboratorium-Filmoteka`.`zadanie10`()
BEGIN
	declare dlugosc1 int(10);
	declare dlugosc2 int(10);
	declare agent1 varchar(30);
	declare agent2 varchar(30);
	declare nazwa1 varchar(90);
	declare nazwa2 varchar(90);

	/*wybiera najdłuższą długość dwóch połączonych kontraktów */
	set dlugosc1 = (SELECT datediff(curdate(), k1.poczatek) from kontrakty as k1 left outer join kontrakty as k2 on k1.agent = k2.agent
	where k1.aktor=k2.aktor and k1.id>k2.id and k1.koniec=date_add(k2.poczatek, interval 1 day));
	/*wybiera najdłuższą długość kontarktów nadal trwających */
	set dlugosc2 = (SELECT datediff( curdate(), k.poczatek)
	from kontrakty as k where k.id not in (SELECT k1.id
	from kontrakty as k1 left outer join kontrakty as k2 on k1.agent = k2.agent where k1.aktor=k2.aktor and k1.id>k2.id) order by 1 desc Limit 1);

	if(dlugosc2>dlugosc1) THEN
	/*wybiera agenta, którego kontrakt był najdłuższy*/
	set agent1 =(select tmp1.ag2 from (SELECT datediff( curdate(), k.poczatek) as dni, k.agent as ag2
	from kontrakty as k where k.id not in (SELECT k1.id
	from kontrakty as k1 left outer join kontrakty as k2 on k1.agent = k2.agent where k1.aktor=k2.aktor and k1.id>k2.id) order by 1 desc Limit 1) as tmp1);
	select agent1;
	/*wypisuje informacje o agencie */
	set nazwa1 = (select a.nazwa from agenci as a where a.licencja=agent1);
	else
	/*wybiera agenta, którego wspołpraca z danym agentem była najdłuższa*/
	set agent2 = (select tmp2.ag1 from (SELECT k1.agent as ag1, datediff(CURDATE(), k1.poczatek ) as suma_dni
	from kontrakty as k1 left outer join kontrakty as k2 on k1.agent = k2.agent
	where k1.aktor=k2.aktor and k1.id>k2.id and k1.koniec=date_add(k2.poczatek, interval 1 day)) as tmp2);
	/*wypisuje informacje o agencie */
  	set nazwa2 = (select a.nazwa from agenci as a where a.licencja=agent2);
	end if;
END
