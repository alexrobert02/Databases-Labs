-- 9.01. Afişaţi toţi studenţii care au în an cu ei măcar un coleg care să fie mai mare ca ei (vezi data naşterii). Atentie, un student s1 este mai mare daca are data_nastere mai mica decat celalat student s2.
    SELECT * 
    FROM studenti s1
    WHERE EXISTS (
        SELECT *
        FROM STUDENTI s2
        WHERE s1.data_nastere < s2.data_nastere AND s1.an = s2.an
    );

-- 9.02. Afişaţi toţi studenţii care au media mai mare decât media tuturor notelor colegilor din an cu ei. Pentru aceştia afişaţi numele, prenumele şi media lor.
    SELECT s1.nume, s1.prenume, AVG(valoare) 
    FROM note n1
    JOIN studenti s1 ON n1.nr_matricol = s1.nr_matricol
    GROUP BY s1.nume, s1.prenume, s1.nr_matricol, s1.an
    HAVING AVG(valoare) >= ALL (
        SELECT AVG(valoare) 
        FROM note n2
        JOIN studenti s2 ON s2.nr_matricol = n2.nr_matricol
        WHERE s2.an = s1.an
        GROUP BY s2.nr_matricol
    );

-- 9.03. Afişaţi numele, prenumele si grupa celui mai bun student din fiecare grupa în parte.
    SELECT s1.nume, s1.prenume, s1.grupa
    FROM note n1
    JOIN studenti s1 ON n1.nr_matricol = s1.nr_matricol
    GROUP BY s1.nume, s1.prenume, s1.grupa, s1.nr_matricol
    HAVING AVG(valoare) = (
        SELECT MAX(AVG(valoare)) 
        FROM note n2
        JOIN studenti s2 ON s2.nr_matricol = n2.nr_matricol
        WHERE s2.grupa = s1.grupa
        GROUP BY s2.nr_matricol
    );

-- 9.04. Găsiţi toţi studenţii care au măcar un coleg în acelaşi an care să fi luat aceeaşi nota ca şi el la măcar o materie.
    SELECT * 
    FROM studenti s1
    WHERE EXISTS (
        SELECT * 
        FROM note 
        WHERE (valoare, id_curs) IN (
            SELECT valoare, id_curs 
            FROM note 
            WHERE nr_matricol = s1.nr_matricol
        ) AND s1.nr_matricol != nr_matricol
    );

-- 9.05. Afișați toți studenții care sunt singuri în grupă (nu au alți colegi în aceeași grupă).
    SELECT *
    FROM studenti s1
    WHERE 1 = (
        SELECT COUNT(*) 
        FROM studenti s2 
        WHERE s1.grupa = S2.grupa AND s1.an = s2.an
    );


-- 9.06. Afișați profesorii care au măcar un coleg (profesor) ce are media notelor puse la fel ca și el.
    SELECT p1.nume, p1.prenume 
    FROM profesori p1
    JOIN didactic d1 ON d1.id_prof = p1.id_prof
    JOIN note n1 ON n1.id_curs = d1.id_curs
    GROUP BY p1.nume, p1.prenume, p1.id_prof
    HAVING EXISTS (
        SELECT COUNT(*)
        FROM profesori p2
        JOIN didactic d2 ON d2.id_prof = p2.id_prof
        JOIN note n2 ON n2.id_curs = d2.id_curs
        GROUP BY p2.id_prof
        HAVING p1.id_prof != p2.id_prof AND AVG(n1.valoare) = AVG(n2.valoare)
    );

-- 9.07. Fara a folosi join, afisati numele si media fiecarui student.
    SELECT s.nume, s.prenume, s.an, 
        NVL ((
            SELECT AVG(n.valoare) 
            FROM note n
            WHERE n.nr_matricol = s.nr_matricol
        ), 0) "MEDIE"
    FROM studenti s;

-- 9.08. Afisati cursurile care au cel mai mare numar de credite din fiecare an (pot exista si mai multe pe an).
    SELECT titlu_curs FROM cursuri
    WHERE (an, credite) IN (
        SELECT an, MAX(credite) 
        FROM cursuri
        GROUP BY an
    );
    --(necorelat)
    
    SELECT titlu_curs, an, credite FROM cursuri c1
    WHERE c1.credite = (
        SELECT MAX(c2.credite) 
        FROM cursuri c2 
        WHERE c2.an = c1.an
    );
    -- (corelat)
