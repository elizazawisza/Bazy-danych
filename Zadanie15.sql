create view zadanie15_aktorzy as
select imie, nazwisko from aktorzy;

create view zadanie15_agenci as
select nazwa, wiek from agenci;

create view zadanie15_filmy as
select tytul, gatunek, czas_trwania, kategoria_wiekowa from filmy


create user `zadanie15`@`localhost`;
grant select on `Laboratorium-Filmoteka`.zadanie14 to `ksiezniczka`@`localhost`
grant select on `Laboratorium-Filmoteka`.zadanie15_agenci to `ksiezniczka`@`localhost`
grant select on `Laboratorium-Filmoteka`.zadanie15_aktorzy to `ksiezniczka`@`localhost`
grant select on `Laboratorium-Filmoteka`.zadanie15_filmy  to `ksiezniczka`@`localhost`
