-- 2.01. Scrieți o interogare pentru a afișa numele, prenumele, anul de studiu si data nașterii pentru toți studenții. Editați în SQL*Plus și executați. Salvați apoi interogarea intr-un fișier numit p1.sql.
    SELECT nume, prenume, an, data_nastere FROM studenti;

-- 2.02. Scrieți și executați o interogare pentru a afișa în mod unic valorile burselor.
    SELECT DISTINCT bursa FROM studenti;

-- 2.03. Încărcați fișierul p1.sql în buffer. Dați fiecărei coloane din clauza SELECT un alias. Executați înterogarea.
    SELECT nume AS "NAME", prenume AS "SURNAME", an AS "YEAR", data_nastere AS "BIRTHDATE" FROM studenti;

-- 2.04. Afișați numele concatenat cu prenumele urmat de virgulă și anul de studiu. Ordonați crescător după anul de studiu. Denumiți coloana “Studenți pe ani de studiu�?.	
    SELECT nume || ' ' || prenume || ', ' || an AS "STUDENTI PE AN DE STUDIU" FROM studenti ORDER BY an;

-- 2.05. Afișați numele, prenumele și data de naștere a studenților născuți între 1 ianuarie 1995 si 10 iunie 1997. Ordonați descendent după anul de studiu.
    SELECT an, nume, prenume, data_nastere FROM studenti WHERE data_nastere BETWEEN '1-JAN-95' AND '10-JUN-97' ORDER BY an DESC;

-- 2.06. Afișați numele și prenumele precum și anii de studiu pentru toți studenții născuți în 1995.
    SELECT an, nume, prenume, data_nastere FROM studenti WHERE data_nastere LIKE '%95';

-- 2.07. Afișați studenții (toate informațiile pentru aceștia) care nu iau bursă.
    SELECT * FROM studenti WHERE bursa IS NULL;

-- 2.08. Afișați studenții (nume și prenume) care iau bursă și sunt în anii 2 și 3 de studiu. Ordonați alfabetic ascendent după nume și descendent după prenume.
    SELECT * FROM studenti WHERE an IN (2,3) AND bursa IS NOT NULL ORDER BY nume, prenume DESC;

-- 2.09. Afișați studenții care iau bursă, precum și valoarea bursei dacă aceasta ar fi mărită cu 15%.
    SELECT nr_matricol, nume, prenume, an, grupa, bursa*1.15, data_nastere FROM studenti WHERE bursa IS NOT NULL;

-- 2.10. Afișați studenții al căror nume începe cu litera P și sunt în anul 1 de studiu.
    SELECT * FROM studenti WHERE nume LIKE 'P%' AND an=1;

-- 2.11. Afișați toate informațiile despre studenții care au două apariții ale literei “a�? în prenume.
    SELECT * FROM studenti WHERE prenume like '%a%a%';

-- 2.12. Afișați toate informațiile despre studenții al căror prenume este “Alexandru�?, “Ioana�? sau “Marius�?.
    SELECT * FROM studenti WHERE prenume IN ('Alexandru_', 'Ioana_', 'Marius_');

-- 2.13. Afișați studenții bursieri din semianul A.
    SELECT * FROM studenti WHERE grupa LIKE 'A%' AND bursa IS NOT NULL;

-- 2.14. Afișați toate informatiile despre studentii ale caror prenume contine EXACT o singura data litera 'a' (se ignora litera 'A' de la inceputul unor prenume).
    SELECT * FROM studenti WHERE LOWER(SUBSTR(prenume, 2)) LIKE '%a%' AND LENGTH(prenume) - LENGTH(REPLACE(LOWER(prenume), 'a', '')) = 1;

-- 2.15. Afişaţi numele şi prenumele profesorilor a căror prenume se termină cu litera "n".
    SELECT nume, prenume FROM profesori WHERE prenume LIKE '%n %' OR prenume LIKE '%n';
