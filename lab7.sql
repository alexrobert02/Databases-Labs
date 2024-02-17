-- 7.01. Afișați numele studenților care iau cea mai mare bursa acordată.
    SELECT nume, prenume 
    FROM studenti 
    WHERE bursa = (SELECT MAX(bursa) FROM studenti);

-- 7.02. Afișați numele studenților care sunt colegi cu un student pe nume Arhire (coleg = același an si aceeași grupă).
    SELECT nume, prenume 
    FROM studenti 
    WHERE (grupa, an) IN (
        SELECT grupa, an 
        FROM studenti 
        WHERE nume = 'Arhire'
    );

-- 7.03. Pentru fiecare grupă afișați numele studenților care au obținut cea mai mică notă la nivelul grupei.
    SELECT DISTINCT an, grupa, nume, prenume, valoare
    FROM studenti
    NATURAL JOIN note
    WHERE (grupa, an, valoare) IN (
        SELECT grupa, an, MIN(valoare)
        FROM studenti
        NATURAL JOIN note
        GROUP BY grupa, an
    ) ORDER BY an, grupa;

-- 7.04. Identificați studenții a căror medie este mai mare decât media tuturor notelor din baza de date. Afișați numele și media acestora.
    SELECT nume, prenume, AVG(valoare)
    FROM studenti
    NATURAL JOIN note
    GROUP BY nr_matricol, nume, prenume
    HAVING AVG(valoare) > (SELECT AVG(valoare) FROM note);

-- 7.05. Afișați numele și media primilor trei studenți ordonați descrescător după medie.
    SELECT * FROM (
        SELECT nume, prenume, AVG(valoare)
        FROM studenti
        NATURAL JOIN note
        GROUP BY nr_matricol, nume, prenume
        ORDER BY AVG(valoare) DESC
    ) WHERE ROWNUM <= 3;

-- 7.06. Afișați numele studentului (studenților) cu cea mai mare medie precum și valoarea mediei (atenție: limitarea numărului de linii poate elimina studenții de pe poziții egale; găsiți altă soluție).
    SELECT nume, prenume, AVG(valoare)
    FROM studenti
    NATURAL JOIN note
    GROUP BY nr_matricol, nume, prenume
    HAVING AVG(valoare) = (
        SELECT MAX(AVG(valoare)) 
        FROM studenti
        NATURAL JOIN note
        GROUP BY nr_matricol, nume, prenume
    );

-- 7.07. Afişaţi numele şi prenumele tuturor studenţilor care au luat aceeaşi nota ca şi Ciprian Ciobotariu la materia Logică. Excludeţi-l pe acesta din listă. (Se știe în mod cert că există un singur Ciprian Ciobotariu și că acesta are o singură notă la logică)
    SELECT DISTINCT nume, prenume
    FROM studenti
    NATURAL JOIN note
    WHERE prenume != 'Ciprian' AND nume != 'Ciobotariu' AND (id_curs, valoare) IN (
        SELECT n.id_curs, n.valoare
        FROM note n
        JOIN studenti s ON n.nr_matricol = s.nr_matricol
        JOIN cursuri c ON n.id_curs = c.id_curs
        WHERE s.prenume = 'Ciprian' AND s.nume = 'Ciobotariu' AND c.titlu_curs = 'Logica'
    );

-- 7.08. Din tabela studenti, afisati al cincilea prenume in ordine alfabetica.
    SELECT prenume FROM (
        SELECT prenume, ROWNUM rn FROM (
            SELECT *
            FROM studenti
            ORDER BY prenume
        )
    ) WHERE rn = 5;

-- 7.09. Punctajul unui student se calculeaza ca fiind o suma intre produsul dintre notele luate si creditele la materiile la care au fost luate notele. Afisati toate informatiile studentului care este pe locul 3 in acest top.
    SELECT * FROM (
        SELECT nr_matricol, nume, prenume, an, grupa, punctaj, ROWNUM rn FROM (
            SELECT s.nr_matricol, s.nume, s.prenume, s.an, s.grupa, SUM(n.valoare*c.credite) AS punctaj
            FROM studenti s
            JOIN note n ON n.nr_matricol = s.nr_matricol
            JOIN cursuri c ON n.id_curs = c.id_curs
            GROUP BY s.nr_matricol, s.nume, s.prenume, s.an, s.grupa
            ORDER BY SUM(n.valoare*c.credite) DESC
        )
    ) WHERE rn = 3;

-- 7.10. Afișați studenții care au notă maximă la o materie precum și nota și materia respectivă.
    SELECT s.nr_matricol, s.nume, s.prenume, n.valoare, c.titlu_curs
    FROM studenti s
    JOIN note n ON n.nr_matricol = s.nr_matricol
    JOIN CURSURI c ON c.id_curs = n.id_curs
    WHERE (n.id_curs, valoare) IN (
        SELECT n.id_curs, MAX(valoare)
        FROM note n
        LEFT OUTER JOIN cursuri c ON c.id_curs = n.id_curs
        GROUP BY n.id_curs
    ) ORDER BY c.titlu_curs, s.nume;
