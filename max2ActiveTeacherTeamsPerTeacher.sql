DROP TRIGGER IF EXISTS isTeacherAvailable ON teacher_teacherteam;
DROP FUNCTION IF EXISTS isTeacherAvailaibleTeacher_teacherteam;

CREATE FUNCTION isTeacherAvailaibleTeacher_teacherteam()
  RETURNS trigger AS
$func$
BEGIN
   	IF (
		(SELECT count(*) as amount
		FROM classes 
		JOIN teacher_teacherteam 
		ON (classes.teacherteamid = teacher_teacherteam.teacherteamid)
		WHERE teacher_teacherteam.teacherid = NEW.teacherid AND classes.ends > now())
		>= 2 )
	THEN 
		RAISE EXCEPTION 'Teacher is currently assigned two active teacherteams';
   	END IF;
   RETURN NEW;
END
$func$  
LANGUAGE plpgsql;

CREATE TRIGGER isTeacherAvailable BEFORE INSERT ON teacher_teacherteam
	FOR EACH ROW EXECUTE PROCEDURE isTeacherAvailaibleTeacher_teacherteam();

----------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS isTeacherAvailable ON classes;
DROP FUNCTION IF EXISTS isTeacherAvailaibleClasses; 

CREATE FUNCTION isTeacherAvailaibleClasses()
  RETURNS trigger AS
$func$
BEGIN
   	IF (
		(SELECT count(*) as amount
		FROM classes 
		JOIN teacher_teacherteam 
		ON (classes.teacherteamid = teacher_teacherteam.teacherteamid)
		WHERE teacher_teacherteam.teacherteamid = NEW.teacherteamid AND classes.ends > now())
		>= 2 )
	THEN
            RAISE EXCEPTION 'Teacher is currently assigned two active teacherteams';
   	END IF;
   RETURN NEW;
END
$func$  
LANGUAGE plpgsql;

CREATE TRIGGER isTeacherAvailable BEFORE INSERT ON classes
	FOR EACH ROW EXECUTE PROCEDURE isTeacherAvailaibleClasses();
