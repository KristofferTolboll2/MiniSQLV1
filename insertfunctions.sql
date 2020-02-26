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

exec db.createTeacher 'Henrik', 'Larsen';


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
    @teacherID int REFERENCES teachers(teacherID),
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



CREATE PROC [db].[createClassmember]
(
    @classID int REFERENCES class(classID),
    @studentID int REFERENCES students(studentID),
)
AS
    BEGIN
        if (EXIST(SELECT classID FROM classmembers WHERE classID=@classmembers))
            return 1;
        else
            BEGIN
                INSERT INTO db.classmembers (classID, studentID) 
                VALUES (@classID, @studentID);
                return 0;
            END
    
    END
GO



CREATE PROC [db].[createStudent]
(
    @firstname text,
    @lastname text
)
AS
    BEGIN
        if (EXIST(SELECT firstname FROM students WHERE firstname=@firstname AND lastname=@lastname))
            return 1;
        else
            BEGIN
                INSERT INTO db.students (firstname, lastname) 
                VALUES (@firstname, @lastname);
                return 0;
            END
    
    END
GO


CREATE PROC [db].[createGrade]
(
    @studentID int REFERENCES students(studentID),
    @courseID int REFERENCES courseslist(courseID),
    @grade int NOT NULL,
)
AS
    BEGIN
        if (EXIST(SELECT studentID FROM grades WHERE studentID=@studentID, courseID=@courseID))
            return 1;
        else
            BEGIN
                INSERT INTO db.grades (studentID, courseID, grade) 
                VALUES (@studentID, @courseID, @grade);
                return 0;
            END
    
    END
GO



CREATE PROC [db].[createClass]
(
    @classID INT UNIQUE NOT NULL,
    @courseID INT REFERENCES courseslist(courseID),
    @teacherteamID INT REFERENCES teacherteam(teacherteamID),
    @coursetype text CHECK(coursetype='Attendance' OR coursetype='Online')
)
AS
    BEGIN
        if (EXIST(SELECT classID FROM classes WHERE classID=@classID, courseID=@courseID, teacherteamID=@teacherteamID))
            return 1;
        else
            BEGIN
                INSERT INTO db.classes (classID, courseID, teacherteamID, coursetype) 
                VALUES (@classID, @courseID, @teacherteamID, @coursetype);
                return 0;
            END
    
    END
GO


--CREATE PROC [db].[createTeacherToTeacherteam]
--(
--    @teacherteamID int,
--	@teacherID int REFERENCES teachers(teacherID),
--)
--AS
--    BEGIN
--        if (EXIST(SELECT teacherteamID FROM teacherteam WHERE teacherteamID=@teacherteamID, teacherID=@teacherID))
--            return 1;
--        else
--            BEGIN
--                INSERT INTO db.classes (teacherteamID, teacherID) 
--                VALUES (@teacherteamID, @teacherID);
--                return 0;
--            END
--    
--    END
--GO
