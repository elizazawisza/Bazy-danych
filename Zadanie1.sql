create index filmy_index on filmy(tytul);
create index aktorzy_index on aktorzy(nazwisko);
create index aktorzy1litera_index on aktorzy(imie(1));
create index aktorzagrali_index on zagrali(actor_id);
