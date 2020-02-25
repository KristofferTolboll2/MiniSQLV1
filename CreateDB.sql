DROP TABLE IF EXISTS students;
create table students (
	studentID SERIAL PRIMARY KEY,
	firstname text,
	lastname text
);

DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers (
	teacherID SERIAL PRIMARY KEY,
	firstname text,
	lastname text
);	

DROP TABLE IF EXISTS courses;
CREATE  TABLE courses (
	courseID SERIAL PRIMARY KEY,
	title text
);
	
	
DROP TABLE IF EXISTS teacherteams;
CREATE TABLE teacherteams (
	teacherteamID int PRIMARY KEY
);
	
DROP TABLE IF EXISTS teacher_teacherteam;
CREATE TABLE teacher_teacherteam (
	teacherID int references teachers(teacherID) ON DELETE CASCADE,
	teacherteamID INT references teacherteams(teacherteamID) ON DELETE CASCADE								  
);


DROP TABLE IF EXISTS grades;
CREATE TABLE grades (
	studentID INT REFERENCES students(studentID) ON DELETE CASCADE,
	courseID INT REFERENCES courses(courseID) ON DELETE CASCADE,
	grade INT NOT NULL,
	PRIMARY KEY(studentID ,courseID)
);

DROP TABLE IF EXISTS classes;
CREATE TABLE classes (
	classID INT UNIQUE NOT NULL,
	courseID INT REFERENCES courses(courseID) ON DELETE CASCADE,
	starts TIMESTAMP,
	ends TIMESTAMP,
	teacherteamID INT REFERENCES teacherteams(teacherteamID) ON DELETE CASCADE,
	coursetype text CHECK(coursetype='Attendance' OR coursetype='Online'),
	PRIMARY KEY(classID,courseID)
);


DROP TABLE IF EXISTS classmembers;
CREATE TABLE classmembers (
	classID INT REFERENCES classes(classID) ON DELETE CASCADE,
	studentID INT REFERENCES students(studentID) ON DELETE CASCADE,
	PRIMARY KEY(classID,studentID)
); 
