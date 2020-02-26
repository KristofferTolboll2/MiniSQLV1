const pg = require("pg");
const format = require("pg-format");
const { teachersQuery } = require("./queries/teachersQuery");
const { studentsQuery } = require("./queries/studentsQuery");
const { coursesQuery } = require("./queries/coursesQuery");

run = async query => {
  let client;
  try {
    client = new pg.Client({
      connectionString: "postgresql://management:1234@localhost:5432/school"
    });
    await client.connect();
    let { rows } = await client.query(query);
    return rows;
  } catch (e) {
    console.error(e);
  } finally {
    client.end();
  }
};

const amountOfClasses = 20;
const amountOfTeacherTeams = 10;
const amountOfCourses = 81;

getNum = max => {
  return Math.floor(Math.random() * Math.floor(max));
};

getDay = () => {
  let day = getNum(27) + 1;
  return ("" + day).length === 2 ? day : "" + 0 + day;
};

createClasses = () => {
  var classes = [];

  for (let i = 0; i < amountOfClasses; i++) {
    const _class = [];
    _class.push("" + i);
    _class.push("" + getNum(amountOfCourses));
    _class.push("now()");
    _class.push(`2020-0${getNum(2) + 1}-${getDay()}`);
    _class.push("" + getNum(amountOfTeacherTeams));
    _class.push(getNum(2) === 0 ? "Attendance" : "Online");
    classes.push(_class);
  }
  return classes;
};

createTeacherTeams = () => {
  var teacherTeams = [];
  for (let i = 0; i < amountOfTeacherTeams; i++) {
    teacherTeams.push([i]);
  }
  return teacherTeams;
};

createTeacherTeacherTeam = async () => {
  return run("select * from teachers").then(e => {
    let arr = [];
    e.forEach(e => {
      for (let i = 0; i < getNum(2) + 1; i++) {
        arr.push([e.teacherid + "", getNum(amountOfTeacherTeams) + ""]);
      }
    });
    return arr;
  });
};

createClassMembers = async () => {
  return run("select * from students").then(e => {
    let arr = [];
    e.forEach(e => {
      arr.push([e.studentid + "", getNum(amountOfTeacherTeams) + ""]);
    });
    return arr;
  });
};

createGrades = async () => {
  const grades = ["12", "10", "7", "4", "2", "00"];
  return run("select studentid from students").then(e => {
    let arr = [];
    e.forEach(e => {
      arr.push([
        e.studentid + "",
        getNum(amountOfCourses) + "",
        grades[getNum(grades.length) + ""]
      ]);
    });
    return arr;
  });
};

runQueries = async () => {
  await run("delete from classes where true");
  await run("delete from classmembers where true");
  await run("delete from courses where true");
  await run("delete from grades where true");
  await run("delete from students where true");
  await run("delete from teacher_teacherteam where true");
  await run("delete from teachers where true");
  await run("delete from teacherteams where true");
  await run(studentsQuery);
  await run(teachersQuery);
  await run(coursesQuery);
  await run(
    format(
      "INSERT INTO teacherteams (teacherteamid) VALUES %L",
      createTeacherTeams()
    )
  );
  await createTeacherTeacherTeam().then(e =>
    run(
      format(
        "INSERT INTO teacher_teacherteam (teacherid, teacherteamid) VALUES %L",
        e
      )
    )
  );
 await run(
    format(
      "INSERT INTO classes (classid, courseid, starts, ends, teacherteamid, coursetype) VALUES %L",
      createClasses()
    )
  );
  await createClassMembers().then(e =>
    run(format("INSERT INTO classmembers (studentid, classid) VALUES %L", e))
  );
  await createGrades().then(e =>
    run(format("INSERT INTO grades (studentid, courseid, grade) VALUES %L", e))
  );
};
try {
  runQueries();
} catch (e) {
  console.warn(e);
}
