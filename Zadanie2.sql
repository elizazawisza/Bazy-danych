
  SELECT DISTINCT a.actor_id FROM sakila.film_actor as fa inner join film_list as f on fa.film_id = f.FID
  inner join actor as a on fa.actor_id = a.actor_id
  where f.title not like '%x%' and f.title not like '%v%' and f.title not like '%q%'and
  a.last_name not like '%x%' and a.last_name not like '%v%' and a.last_name not like '%q%' and
  a.first_name not like '%x%' and a.first_name not like '%v%' and a.first_name not like '%q%'


  create table filmy (film_id int auto_increment primary key, tytul varchar (225) not null, gatunek varchar (45) not null, czas_trwania smallint (5) unsigned,
kategoria_wiekowa varchar (10) not null, filmOldId smallint (5) unsigned)

create table aktorzy (id int auto_increment primary key, imie varchar (45) not null, nazwisko varchar (45) not null, actorOldId smallint (5) )
create table zagrali (actor_id smallint (5) unsigned, film_id smallint (5) unsigned );

  insert into aktorzy(imie, nazwisko, actorOldId) SELECT distinct a.first_name, a.last_name, a.actor_id
FROM sakila.film_actor as fa inner join sakila.film_list as f on fa.film_id = f.FID
inner join sakila.actor as a on fa.actor_id = a.actor_id
where f.title not like '%x%' and f.title not like '%v%' and f.title not like '%q%'and
a.last_name not like '%x%' and a.last_name not like '%v%' and a.last_name not like '%q%' and
a.first_name not like '%x%' and a.first_name not like '%v%' and a.first_name not like '%q%'

insert into filmy(tytul, gatunek, czas_trwania, kategoria_wiekowa, filmOldId) SELECT distinct f.title, f.category, f.`length`, f.rating, f.FID
FROM sakila.film_actor as fa inner join sakila.film_list as f on fa.film_id = f.FID
inner join sakila.actor as a on fa.actor_id = a.actor_id
where f.title not like '%x%' and f.title not like '%v%' and f.title not like '%q%'and
a.last_name not like '%x%' and a.last_name not like '%v%' and a.last_name not like '%q%' and
a.first_name not like '%x%' and a.first_name not like '%v%' and a.first_name not like '%q%'




update zagrali
join filmy on zagrali.filmOld_Id = filmy.filmOldId
set zagrali.film_id = filmy.film_id
where filmy.filmOldId = zagrali.filmOld_Id

update zagrali
join aktorzy on zagrali.actorOld_Id = aktorzy.actorOldId
set zagrali.actor_id = aktorzy.id
where aktorzy.actorOldId = zagrali.actorOld_Id


alter table filmy
drop column filmy.filmOldId

alter table zagrali
drop column zagrali.filmOld_Id

alter table zagrali
drop column zagrali.actorOld_Id

alter table aktorzy
drop column aktorzy.actorOldId
