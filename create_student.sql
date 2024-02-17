-- comanda: SQLPLUS /NOLOG
--          CONN STUDENT/STUDENT@localhost/XE

CREATE TABLESPACE tbs_perm_student_file
  DATAFILE 'd:\tbs_perm_student_file.dat' 
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50M MAXSIZE 2000M
/
    
CREATE TEMPORARY TABLESPACE tbs_temp_student_file
  TEMPFILE 'd:\tbs_temp_student_file.dbf'
    SIZE 50M
    AUTOEXTEND ON
/    

CREATE UNDO TABLESPACE tbs_undo_student_file
  DATAFILE 'd:\tbs_undo_student_file.f'
    SIZE 50M 
    AUTOEXTEND ON
  RETENTION GUARANTEE
/

drop user student;

create user student identified by STUDENT;
alter user student default tablespace tbs_perm_student_file quota 1990M on tbs_perm_student_file;

grant connect to student;
GRANT CONNECT TO STUDENT; 
GRANT CREATE TABLE TO STUDENT;
GRANT CREATE VIEW TO STUDENT;
GRANT CREATE SEQUENCE TO STUDENT;
GRANT CREATE TRIGGER TO STUDENT;
GRANT CREATE SYNONYM TO STUDENT;
GRANT CREATE PROCEDURE TO STUDENT;
GRANT CREATE TYPE TO STUDENT; 

--grant all privileges to std;
