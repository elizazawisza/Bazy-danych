create table logi(PESEL char(11),stara_pensja float, nowa_pensja float, czas_zmiant datetime, uzytkownik varchar(90))

  create
  	trigger zad8 after update
  		on
  		pracownicy for each row
  	begin
  		if new.pensja <> old.pensja then insert
  			into
  				`zadanie8`.logi
  			values(old.PESEL,
  			old.pensja,
  			new.pensja,
  			now(),
  			current_user());
  end if;
  end
