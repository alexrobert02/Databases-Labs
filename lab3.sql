-- 3.01. Scrieți o interogare pentru a afișa data de azi. Etichetați coloana "Astazi".
    SELECT sysdate AS Astazi FROM DUAL;

-- 3.02. Pentru fiecare student afișați numele, data de nastere si numărul de luni între data curentă și data nașterii.
    SELECT nume, data_nastere, TRUNC(MONTHS_BETWEEN(SYSDATE,data_nastere)) FROM studenti;

-- 3.03. Afișați ziua din săptămână în care s-a născut fiecare student.
    SELECT nume, prenume, TO_CHAR(data_nastere, 'day', 'nls_date_language=ROMANIAN') AS "ZIUA DE NASTERE" FROM studenti ORDER BY TO_CHAR(data_nastere, 'D');

-- 3.04. Utilizând functia de concatenare, obțineți pentru fiecare student textul 'Elevul <prenume> este in grupa <grupa>'.
    SELECT CONCAT('Elevul ', CONCAT(prenume, CONCAT(' este in grupa ', grupa))) FROM studenti;

-- 3.05. Afisati valoarea bursei pe 10 caractere, completand valoarea numerica cu caracterul $.
    SELECT RPAD(bursa, 10, '$') FROM studenti;

-- 3.06. Pentru profesorii al căror nume începe cu B, afișați numele cu prima litera mică si restul mari, precum și lungimea (nr. de caractere a) numelui.
    SELECT LENGTH(TRIM(nume)), CONCAT(SUBSTR(LOWER(TRIM(nume)),1,1), UPPER(SUBSTR(TRIM(nume), 2))) FROM profesori WHERE nume LIKE 'B%';

-- 3.07. Pentru fiecare student afișați numele, data de nastere, data la care studentul urmeaza sa isi sarbatoreasca ziua de nastere si prima zi de duminică de dupa.
    SELECT 
        nume, 
        data_nastere, 
        ADD_MONTHS(data_nastere, (TRUNC(MONTHS_BETWEEN(sysdate, data_nastere)/12)+1)*12), 
        NEXT_DAY(ADD_MONTHS(data_nastere, (TRUNC(MONTHS_BETWEEN(sysdate, data_nastere)/12)+1)*12),'SUNDAY') 
    FROM studenti;

-- 3.08. Ordonați studenții care nu iau bursă în funcție de luna cand au fost născuți; se va afișa doar numele, prenumele și luna corespunzătoare datei de naștere.
    SELECT nume, prenume, TO_CHAR(data_nastere, 'MM') FROM studenti WHERE bursa IS NULL ORDER BY TO_CHAR(data_nastere, 'MM');

-- 3.09. Pentru fiecare student afișati numele, valoarea bursei si textul: 'premiul 1' pentru valoarea 450, 'premiul 2' pentru valoarea 350, 'premiul 3' pentru valoarea 250 și 'mentiune' pentru cei care nu iau bursa. Pentru cea de a treia coloana dati aliasul "Premiu".
    SELECT nume, bursa, DECODE(bursa, 450, 'premiul 1', 350, 'premiul 2', 250, 'premiul 3', 'mentiune') AS "Premiu" FROM studenti;

-- 3.10. Afişaţi numele tuturor studenților înlocuind apariţia literei i cu a şi apariţia literei a cu i.
    SELECT nume, TRANSLATE(nume, 'ia', 'ai') FROM studenti;

-- 3.11. Afișați pentru fiecare student numele, vârsta acestuia la data curentă sub forma '<x> ani <y> luni și <z> zile' (de ex '19 ani 3 luni și 2 zile') și numărul de zile până își va sărbători (din nou) ziua de naștere.
    SELECT 
        nume, 
        prenume, 
        data_nastere, 
        TRUNC(MONTHS_BETWEEN(sysdate, data_nastere)/12) AS ani, 
        MOD(TRUNC(MONTHS_BETWEEN(sysdate, data_nastere)),12) AS luni, 
        TRUNC(sysdate-ADD_MONTHS(data_nastere, TRUNC(MONTHS_BETWEEN(sysdate, data_nastere)))) AS zile, 
        ADD_MONTHS(data_nastere, 12+TRUNC(MONTHS_BETWEEN(sysdate, data_nastere)/12)*12) AS next
    FROM studenti; 

-- 3.12. Presupunând că în următoarea lună bursa de 450 RON se mărește cu 10%, cea de 350 RON cu 15% și cea de 250 RON cu 20%, afișați pentru fiecare student numele acestuia, data corespunzătoare primei zile din luna urmatoare și valoarea bursei pe care o va încasa luna următoare. Pentru cei care nu iau bursa, se va afisa valoarea 0.
    SELECT 
        nume,
        ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1) AS "Data",
        DECODE(bursa, 450, bursa * 1.10, 350, bursa * 1.15, 250, bursa * 1.20, 0) AS "Valoarea bursei urmatoare"
    FROM studenti;

-- 3.13. Pentru studentii bursieri (doar pentru ei) afisati numele studentului si bursa in stelute: fiecare steluta valoreaza 50 RON. In tabel, alineati stelutele la dreapta.
    SELECT nume, prenume, bursa, LPAD(TRIM(RPAD(' ', bursa/50, '*')), 10, ' ') FROM studenti WHERE bursa IS NOT NULL;
