
Skift peer til md5 for password eller trust for direkte adgang. Peer bruger unix sockets til at forbinde. Så UNIX brugernavnet skal matche psql brugernavnet for at det virker.

**Sudo nano /etc/postgresql/12/main/pg_hba.conf**

**psql postgresql -U postgres**

--gør at andre brugere bliver frataget retitgheden til at forbinde tig databasen school på schema public
**REVOKE connect ON DATABASE school FROM PUBLIC;**
--skaber brugeren read med kodeord 1234
**CREATE ROLE read WITH PASSWORD '1234';**

--giver nu specifikt brugeren read tilladelse til at forbinde til school
**GRANT connect ON DATABASE school TO read;**

--giver adgang til at forbinde til postgres
**ALTER ROLE read WITH LOGIN;**

--giver read adgang til read
**GRANT SELECT ON ALL TABLES IN SCHEMA public TO read;**

--skaber brugeren management med kodeord 1234
**CREATE ROLE management WITH PASSWORD '1234';**

**GRANT connect ON DATABASE school TO management;**

**ALTER ROLE man**agement WITH LOGIN;**

**GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO management;**

**GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO management;**

Kontroller at brugerne er oprettet
**\du**

Log ud
**\q**


Kontroller at brugerne virker
**psql postgres -U management**

**\c school**

**INSERT INTO teachers (teacherid, firstname, lastname) VALUES(1000, 'test','test');**
**\q**

**psql postgres -U read**

**\c school**

**INSERT INTO teachers (teacherid, firstname, lastname) VALUES(1000, 'test','test');**

**SELECT * FROM teachers;**

**\q**
