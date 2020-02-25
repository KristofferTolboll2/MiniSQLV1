DROP TRIGGER teacherTeamSizeCheckOnClassInsert ON classes;
DROP FUNCTION teacherTeamSizeCheck; --trigger is dependent on function

CREATE FUNCTION teacherTeamSizeCheck()
  RETURNS trigger AS
$func$
BEGIN
   	IF (
        /*
	(SELECT amount FROM 
	(SELECT COUNT(teacherid) AS amount
        FROM classes 
        JOIN teacher_teacherteam 
        ON classes.teacherteamid = teacher_teacherteam.teacherteamid
        WHERE teacher_teacherteam.teacherteamid = NEW.teacherteamid
	*/
	(SELECT COUNT(teacherid) AS amount
        FROM teacher_teacherteam 
        WHERE teacher_teacherteam.teacherteamid = NEW.teacherteamid)
	< 2 )
	THEN
            RAISE EXCEPTION 'Not sufficient teachers on the teacherteam';
   	END IF;
   RETURN NEW;
END
$func$  
LANGUAGE plpgsql;

CREATE TRIGGER teacherTeamSizeCheckOnClassInsert BEFORE INSERT ON classes
	FOR EACH ROW EXECUTE PROCEDURE teacherteamsizecheck();
