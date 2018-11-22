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
