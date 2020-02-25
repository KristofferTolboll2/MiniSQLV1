INSERT INTO teachers (firstname, lastname) VALUES (Jens, Johansen);

INSERT INTO courses (title) VALUES (Maths);

INSERT INTO teacherteam (teacherteamID, teacherID) VALUES (0,1);

INSERT INTO classmembers (classID, studentID) VALUES (2,6);

INSERT INTO students (firstname, lastname) VALUES (Søren, Frederiksen);

INSERT INTO grades (studentID, courseID, grade) VALUES (2,4,10);

INSERT INTO classes (classID, courseID, starts, ends, teacherteamID, coursetype) VALUES (4,1,3,Online);

INSERT INTO teac




function - addTeacher
function - addCourselist
function - addTeacherteam
function - addClassmember
function - addStudent
function - addGrade
function - addClass
function - addTeacherToTeacherteam


CREATE PROC [db].[createTeacher]
(
    @firstname text,
    @lastname text
)
AS
    BEGIN
        if (EXIST(SELECT firstname FROM teachers WHERE firstname=@firstname AND lastname=@lastname))
            return 1;
        else
            BEGIN
                INSERT INTO db.teachers (firstname, lastname) 
                VALUES (@firstname, @lastname);
                return 0;
            END
    
    END
GO

exec db.CreateTeacher 'Henrik', 'Larsen';


CREATE PROC [db].[createCourses]
(
    @title text
)
AS
    BEGIN
        if (EXIST(SELECT title FROM courses WHERE courses=@title))
            return 1;
        else
            BEGIN
                INSERT INTO db.courses (title) 
                VALUES (@title);
                return 0;
            END
    
    END
GO




CREATE PROC [db].[createTeacherTeam]
(
    @teacherteamID int,
)
AS
    BEGIN
        if (EXIST(SELECT teacherteamID FROM teacherteam WHERE teacherteamID=@teacherteam))
            return 1;
        else
            BEGIN
                INSERT INTO db.teacherteam (teacherteamID) 
                VALUES (@teacherteamID);
                return 0;
            END
    
    END
GO
