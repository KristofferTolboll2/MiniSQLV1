CREATE OR REPLACE PROCEDURE teacher(fname text, lname text) AS
$$
BEGIN
    INSERT INTO teachers (firstname, lastname) VALUES (fname, lname);
END
$$
    LANGUAGE 'plpgsql';
  
CALL teacher('Henrik', 'Jakobsen');
SELECT * from teachers;


CREATE OR REPLACE PROCEDURE courses(title text) AS
$$
BEGIN
    INSERT INTO courses (title) VALUES (title);
END
$$
    LANGUAGE 'plpgsql';



CREATE OR REPLACE PROCEDURE teacherteam(ttID int) AS
$$
BEGIN
    INSERT INTO teacherteam (teacherteamID) VALUES (ttid);
END
$$
    LANGUAGE 'plpgsql';


CREATE OR REPLACE PROCEDURE classmember(classID int, studentID int) AS
$$
BEGIN
    INSERT INTO classmembers (classID, studentID) VALUES (classID, studentID);
END
$$
    LANGUAGE 'plpgsql';


CREATE OR REPLACE PROCEDURE student(fname text, lname text) AS
$$
BEGIN
    INSERT INTO students (firstname, lastname) VALUES (fname, lname);
END
$$
    LANGUAGE 'plpgsql';


CREATE OR REPLACE PROCEDURE grade(studentID int, courseID int, grade int) AS
$$
BEGIN
    INSERT INTO grades (studentID, courseID, grade) VALUES (studentID, courseID, grade);
END
$$
    LANGUAGE 'plpgsql';



CREATE OR REPLACE PROCEDURE createClass(classID int, courseID int, starts timestamp, ends timestamp, ttID int, coursetype text) AS
$$
BEGIN
    INSERT INTO classes (classID, courseID, starts, ends, teacherteamID, coursetype) VALUES (classID, courseID, starts, ends, ttID, coursetype);
END
$$
    LANGUAGE 'plpgsql';



CREATE OR REPLACE PROCEDURE ttt(tID int, ttID int) AS
$$
BEGIN
    INSERT INTO teacher_teacherteam (teacherID, teacherteamID) VALUES (tID, ttID);
END
$$
    LANGUAGE 'plpgsql';
