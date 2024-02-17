-- 6.01: Afișați numărul de studenți din fiecare an.
    SELECT COUNT(*), an FROM studenti GROUP BY an;

-- 6.02: Afișați numărul de studenți din fiecare grupă a fiecărui an de studiu. Ordonați crescător după anul de studiu și după grupă.
    SELECT an, grupa, COUNT(*) FROM studenti GROUP BY an, grupa ORDER BY an, grupa;

-- 6.03: Afișați numărul de studenți din fiecare grupă a fiecărui an de studiu și specificați câți dintre aceștia sunt bursieri.
    SELECT COUNT(*), COUNT(bursa), an, grupa FROM studenti GROUP BY an, grupa;

-- 6.04: Afișați suma totală cheltuită de facultate pentru acordarea burselor.
    SELECT SUM(bursa) FROM studenti;

-- 6.05: Afișați valoarea bursei/cap de student (se consideră că studentii care nu sunt bursieri primesc 0 RON); altfel spus: cât se cheltuiește în medie pentru un student?
    SELECT SUM(bursa)/COUNT(*) FROM studenti;

-- 6.06: Afișați numărul de note de fiecare fel (câte note de 10, câte de 9,etc.). Ordonați descrescător după valoarea notei.
    SELECT COUNT(valoare), valoare FROM note GROUP BY valoare ORDER BY valoare DESC;

-- 6.07: Afișați numărul de note pus în fiecare zi a săptămânii. Ordonați descrescător după numărul de note.
    SELECT COUNT(*), TO_CHAR(data_notare, 'DAY') FROM note GROUP BY TO_CHAR(data_notare, 'DAY') ORDER BY COUNT(*) DESC;

-- 6.08: Afișați numărul de note pus în fiecare zi a săptămânii. Ordonați crescător după ziua saptamanii: Sunday, Monday, etc.
    SELECT TO_CHAR(data_notare, 'DAY'), COUNT(valoare) 
    FROM note 
    GROUP BY TO_CHAR(data_notare, 'D'), TO_CHAR(data_notare, 'DAY') 
    ORDER BY TO_CHAR(data_notare, 'D');

-- 6.09: Afișați pentru fiecare elev care are măcar o notă, numele și media notelor sale. Ordonați descrescător după valoarea mediei.
    SELECT studenti.nr_matricol, nume, prenume, TRUNC(AVG(valoare), 2)
    FROM note 
    JOIN studenti ON studenti.nr_matricol = note.nr_matricol 
    GROUP BY studenti.nr_matricol, nume, prenume;

-- 6.10: Modificați interogarea anterioară pentru a afișa și elevii fără nici o notă. Media acestora va fi null. 
    SELECT studenti.nr_matricol, nume, prenume, TRUNC(AVG(valoare), 2)
    FROM note 
    RIGHT JOIN studenti ON studenti.nr_matricol = note.nr_matricol 
    GROUP BY studenti.nr_matricol, nume, prenume;

-- 6.11: Modificați interogarea anterioară pentru a afișa pentru elevii fără nici o notă media 0.
    SELECT studenti.nr_matricol, nume, prenume, NVL(TRUNC(AVG(valoare), 2), 0)
    FROM note 
    RIGHT JOIN studenti ON studenti.nr_matricol = note.nr_matricol 
    GROUP BY studenti.nr_matricol, nume, prenume;

-- 6.12: Modificati interogarea de mai sus pentru a afisa doar studentii cu media mai mare ca 8.
    SELECT studenti.nr_matricol, nume, prenume, TRUNC(AVG(valoare), 2) 
    FROM note 
    RIGHT JOIN studenti ON studenti.nr_matricol = note.nr_matricol 
    GROUP BY studenti.nr_matricol, nume, prenume HAVING AVG(valoare) > 8;

-- 6.13: Afișați numele, cea mai mare notă, cea mai mică notă și media doar pentru acei studenti care au primit doar note mai mari sau egale cu 7 (au cea mai mică notă mai mare sau egală cu 7).
    SELECT studenti.nume, MAX(note.valoare), MIN(note.valoare), AVG(note.valoare) 
    FROM studenti 
    JOIN note ON studenti.nr_matricol = note.nr_matricol
    GROUP BY studenti.nume, studenti.nr_matricol HAVING MIN(note.valoare) >= 7;

-- 6.14: Afișați numele și mediile studenților care au cel puțin un număr de 3 note puse în catalog.
    SELECT nume, AVG(valoare), COUNT(valoare) 
    FROM note 
    JOIN studenti ON studenti.nr_matricol = note.nr_matricol 
    GROUP BY studenti.nr_matricol, nume HAVING COUNT(valoare) >= 3;

-- 6.15: Afișați numele și mediile studenților care au cel puțin un număr de 3 note diferite puse în catalog.
    SELECT nume, avg(valoare)
    FROM note 
    JOIN studenti ON studenti.nr_matricol = note.nr_matricol
    GROUP BY studenti.nr_matricol, nume HAVING COUNT(DISTINCT valoare) >= 3;

-- 6.16: Afișați numele și mediile studenților din grupa A2 anul 3.
    SELECT nume, prenume, TRUNC(AVG(valoare), 2) 
    FROM studenti 
    NATURAL JOIN note 
    WHERE an = 3 AND grupa='A2' 
    GROUP BY nr_matricol, nume, prenume;

-- 6.17: Afișați cea mai mare medie obținută de vreun student. Puteți să afișați și numărul matricol al studentului care are acea medie maximală ?
    SELECT MAX(AVG(valoare)) FROM note GROUP BY nr_matricol;

-- 6.18: Pentru fiecare disciplină de studiu afișati titlul acesteia, cea mai mică și cea mai mare notă pusă.
    SELECT c.titlu_curs, MIN(n.valoare), MAX(n.valoare) FROM cursuri c JOIN note n ON c.id_curs = n.id_curs GROUP BY c.titlu_curs;
