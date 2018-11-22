create index koniec_index using btree on kontrakty(koniec);
select aktor from kontrakty use index (koniec_index) where koniec< date_add(curdate(), interval 1 month);
