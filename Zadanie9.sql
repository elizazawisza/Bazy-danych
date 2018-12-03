prepare ask from 'select count(distinct a.id) as wynik from aktorzy as a join kontrakty as k on k.aktor = a.id join agenci as ag on ag.licencja = k.agent
where ag.nazwa=?';
set @test_agent = 'CHRIS DEPP';

execute ask using @test_agent;
