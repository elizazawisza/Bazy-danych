create table agenci (licencja varchar(30) not null primary key, nazwa varchar(90), wiek int check(wiek >=21), typ enum('osoba indywidualna', 'agencja', 'inny') );


  create table kontrakty (id int not null primary key auto_increment, agent varchar(30), aktor int, poczatek date, koniec date, gaza int check (gaza>=0),
  foreign key (aktor) references aktorzy(id) on delete cascade, foreign key (agent) references agenci(licencja) on delete cascade,
  constraint data check(koniec>= adddate(poczatek, interval 1 day)));
