function - addTeacher
function - addCourselist
function - addTeacherteam
function - addClassmember
function - addStudent
function - addGrade
function - addClass
function - addTeacherToTeacherteam


CREATE OR REPLACE PROCEDURE teacher(fname text, lname text) AS
$$
BEGIN
    INSERT INTO teachers (firstname, lastname) VALUES (fname, lname);
END
$$
    LANGUAGE 'plpgsql';
  
CALL teacher('Henrik', 'Jakobsen');
SELECT * from teachers;
