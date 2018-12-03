create database `Laboratorium-Filmoteka`;
create user `244967`@`localhost`;
  set password for `244967`@`localhost` = password('eliza967')
  grant select on `Laboratorium-Filmoteka`.* to '244967'@'localhost'
    grant insert, update on `Laboratorium-Filmoteka`.* to '244967'@'localhost'
