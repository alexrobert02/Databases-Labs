-- 4.01. Afişaţi studenţii şi notele pe care le-au luat si profesorii care le-au pus acele note.
    SELECT s.nume || ' ' || s.prenume AS "Student", p.nume || ' ' || p.prenume AS "Profesor", valoare AS "Nota" 
    FROM studenti s
    JOIN note n ON s.nr_matricol = n.nr_matricol 
    JOIN didactic d ON n.id_curs = d.id_curs 
    JOIN profesori p ON p.id_prof = d.id_prof;

-- 4.02. Afisati studenţii care au luat nota 10 la materia 'BD'. Singurele valori pe care aveţi voie să le hardcodaţi în interogare sunt valoarea notei (10) şi numele cursului ('BD').
    SELECT s.nume, s.prenume 
    FROM studenti s 
    JOIN note n ON s.nr_matricol = n.nr_matricol 
    JOIN cursuri c ON n.id_curs = c.id_curs
    WHERE n.valoare = 10 AND c.titlu_curs = 'BD';

-- 4.03. Afisaţi profesorii (numele şi prenumele) impreuna cu cursurile pe care fiecare le ţine.
    SELECT p.nume, p.prenume, c.titlu_curs 
    FROM profesori p 
    JOIN didactic d ON p.id_prof = d.id_prof 
    JOIN cursuri c ON c.id_curs = d.id_curs;

-- 4.04. Modificaţi interogarea de la punctul 3 pentru a fi afişaţi şi acei profesori care nu au încă alocat un curs.
    SELECT p.nume, p.prenume, c.titlu_curs 
    FROM profesori p 
    LEFT OUTER JOIN didactic d ON p.id_prof = d.id_prof 
    LEFT OUTER JOIN cursuri c ON c.id_curs = d.id_curs;

-- 4.05. Modificaţi interogarea de la punctul 3 pentru a fi afişate acele cursuri ce nu au alocate încă un profesor.
    SELECT p.nume, p.prenume, c.titlu_curs 
    FROM profesori p 
    JOIN didactic d ON p.id_prof = d.id_prof 
    RIGHT OUTER JOIN cursuri c ON c.id_curs = d.id_curs
    WHERE p.nume IS NULL;
    -- (se poate pune si LEFT OUTER JOIN si RIGHT OUTER JOIN in loc de primul JOIN)

-- 4.06. Modificaţi interogarea de la punctul 3 astfel încât să fie afişaţi atat profesorii care nu au nici un curs alocat cât şi cursurile care nu sunt încă predate de nici un profesor.
    SELECT p.nume, p.prenume, c.titlu_curs 
    FROM profesori p 
    LEFT OUTER JOIN didactic d ON p.id_prof = d.id_prof 
    FULL OUTER JOIN cursuri c ON c.id_curs = d.id_curs;
    -- (se poate pune si FULL OUTER JOIN in loc de LEFT OUTER JOIN)

-- 4.07. In tabela studenti există studenţi care s-au nascut în aceeasi zi a săptămânii. De exemplu, Cobzaru George şi Pintescu Andrei s-au născut amândoi într-o zi de marti. Construiti o listă cu studentii care s-au născut in aceeaşi zi grupându-i doi câte doi în ordine alfabetică a numelor (de exemplu in rezultat va apare combinatia Cobzaru-Pintescu dar nu va apare şi Pintescu-Cobzaru). Lista va trebui să conţină doar numele de familie a celor doi împreună cu ziua în care cei doi s-au născut. Evident, dacă există şi alţi studenti care s-au născut marti, vor apare si ei in combinatie cu cei doi amintiţi mai sus. Lista va fi ordonată în funcţie de ziua săptămânii în care s-au născut si, în cazul în care sunt mai mult de trei studenţi născuţi în aceeaşi zi, rezultatele vor fi ordonate şi după numele primei persoane din listă .	
    SELECT s1.nume || '-'|| s2.nume || ' : ' || TO_CHAR(s1.data_nastere, 'DAY') AS Lista 
    FROM studenti s1 
    JOIN studenti s2 ON TO_CHAR(s1.data_nastere, 'DAY') = TO_CHAR(s2.data_nastere, 'DAY') 
    AND s1.nume < s2.nume OR (s1.nume = s2.nume AND s1.nr_matricol < s2.nr_matricol) 
    ORDER BY TO_CHAR(s1.data_nastere, 'DAY'), s1.nume;

-- 4.08. Sa se afiseze, pentru fiecare student, numele colegilor care au luat nota mai mare ca ei la fiecare dintre cursuri. Formulati rezultatele ca propozitii (de forma "Popescu Gigel a luat nota mai mare ca Vasilescu Ionel la matera BD."). Dati un nume corespunzator coloanei [pont: interogarea trebuie să returneze 118 rânduri].
    SELECT s1.nume || ' ' || s1.prenume || ' a luat nota mai mare ca ' || s2.nume || ' ' || s2.prenume || ' la materia ' || c.titlu_curs || '.' AS Lista
    FROM studenti s1
    JOIN studenti s2 ON NOT (s1.nr_matricol = s2.nr_matricol)
    JOIN note n1 ON s1.nr_matricol = n1.nr_matricol
    JOIN note n2 ON s2.nr_matricol = n2.nr_matricol
    JOIN cursuri c ON c.id_curs = n1.id_curs AND c.id_curs = n2.id_curs
    WHERE n1.valoare > n2.valoare;

-- 4.09. Afisati studentii doi cate doi impreuna cu diferenta de varsta dintre ei. Sortati in ordine crescatoare in functie de aceste diferente. Aveti grija sa nu comparati un student cu el insusi.
    SELECT s1.nume || ' ' || s1.prenume || ' - ' || s2.nume || ' ' || s2.prenume || ' : ' || TRUNC(s1.data_nastere - s2.data_nastere) AS Lista
    FROM studenti s1
    JOIN studenti s2 ON NOT (s1.nr_matricol = s2.nr_matricol)
    WHERE s1.data_nastere > s2.data_nastere
    ORDER BY s1.data_nastere - s2.data_nastere;

-- 4.10. Afisati posibilele prietenii dintre studenti si profesori. Un profesor si un student se pot imprieteni daca numele lor de familie are acelasi numar de litere.
    SELECT s.nume || ' ' || s.prenume || ' - ' || TRIM(p.nume) || ' ' || TRIM(p.prenume) || ' : ' || LENGTH(s.nume) || ' = ' || LENGTH (TRIM(p.nume)) AS Lista
    FROM studenti s
    JOIN profesori p ON (LENGTH(s.nume) = LENGTH(TRIM(p.nume)))
    ORDER BY LENGTH(s.nume), s.nume, p.nume;

-- 4.11. Afisati denumirile cursurilor la care s-au pus note cel mult egale cu 8 (<=8).
    SELECT DISTINCT c.titlu_curs
    FROM cursuri c
    JOIN note n ON (c.id_curs = n.id_curs)
    WHERE n.valoare <= 8;

-- 4.12. Afisati numele studentilor care au toate notele mai mari ca 7 sau egale cu 7.
    SELECT nr_matricol, nume, prenume
    FROM studenti
    MINUS
    SELECT nr_matricol, nume, prenume
    FROM studenti
    NATURAL JOIN note
    WHERE valoare < 7;

-- 4.13. Sa se afiseze studentii care au luat nota 7 sau nota 10 la OOP intr-o zi de marti.
    SELECT s.nr_matricol, s.nume, s.prenume
    FROM studenti s
    JOIN note n ON (s.nr_matricol = n.nr_matricol)
    JOIN cursuri c ON (n.id_curs = c.id_curs)
    WHERE c.titlu_curs = 'OOP' AND (n.valoare = 7 OR n.valoare = 10) AND TRIM(TO_CHAR(n.data_notare, 'DAY')) = 'TUESDAY';

-- 4.14. O sesiune este identificata prin luna si anul in care a fost tinuta. Scrieti numele si prenumele studentilor ce au promovat o anumita materie, cu notele luate de acestia si sesiunea in care a fost promovata materia. Formatul ce identifica sesiunea este "LUNA, AN", fara alte spatii suplimentare (De ex. "JUNE, 2015" sau "FEBRUARY, 2014"). In cazul in care luna in care s-a tinut sesiunea a avut mai putin de 30 de zile afisati simbolul "+" pe o coloana suplimentara, indicand faptul ca acea sesiune a fost mai grea (avand mai putine zile), in caz contrar (cand luna are mai mult de 29 de zile) valoarea coloanei va fi null.
    SELECT nume, prenume, valoare, TO_CHAR(data_notare, 'MONTH, YYYY') AS Sesiune, DECODE(TO_CHAR(DATA_NOTARE, 'DD'), '29','+', '28', '+','') AS "*"
    FROM studenti 
    NATURAL JOIN note 
    WHERE valoare >= 5;
