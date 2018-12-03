Create view zadanie14 as select a.imie, a.nazwisko, ag.nazwa, datediff(k.koniec, curdate()) as ilosc_dni from
aktorzy as a inner join kontrakty as k on k.aktor = a.id inner join agenci as ag on ag.licencja = k.agent; 
