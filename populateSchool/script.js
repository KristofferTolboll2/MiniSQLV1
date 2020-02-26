const pg = require('pg');
const format = require('pg-format');
const { teachersQuery } = require('./queries/teachersQuery')
const { studentsQuery } = require('./queries/studentsQuery')
const { coursesQuery } = require('./queries/coursesQuery')

run = async (query) => {
  let client;
  try {
    client = new pg.Client({
      connectionString: 'postgresql://management:1234@localhost:5432/school'
    });
    await client.connect();
    let {rows} = await client.query(query);
    return rows
  } catch (e) {
    console.error(e);
  } finally {
    client.end();
  }
}

getNum = (max) => {
  return Math.floor(Math.random() * Math.floor(max));
}

getDay = () => {
    let day = getNum(27) + 1
    return (''+day).length === 2 ? day : ''+0+day
}

createClasses = () => {    
    var classes = []

    for(let i = 0; i < 20; i++){
        const _class = []
        _class.push(''+i)
        _class.push(''+getNum(82))
        _class.push('now()')
        _class.push(`2020-0${getNum(2)+1}-${getDay()}`)
        _class.push(''+getNum(20))
        _class.push(getNum(2) === 0 ? 'Attendance' : 'Online')
        classes.push(_class) 
    }
    return classes
}

createTeacherTeams = () => {
    var teacherTeams = []
    for(let i = 0; i < 20; i++){
        teacherTeams.push([i])
    }
    return teacherTeams
}

createTeacherTeacherTeam = async() => {
    return run('select * from teachers').then(e => {
        let arr = []
        e.forEach(e => {
                for(let i = 0; i < getNum(2) + 1; i++){
                    arr.push([e.teacherid+'', getNum(20)+'' ])
                }
            })
    return arr
    })
}

createClassMembers = () => {
        return run('select * from students').then(e => {
        let arr = []
        e.forEach(e => {
              arr.push([e.studentid+'', getNum(20)+'' ])
            })
    return arr
    })
}

runQueries = async () => {
    await run('delete from classes where classid < 101010')
    await run('delete from students where studentid < 10000')
    await run('delete from teachers where teacherid < 10101010')
    await run('delete from courses where courseID < 101010')
    await run('delete from teacherteams where teacherteamid < 101010')
    await run('delete from teacher_teacherteam where teacherteamid < 101010')
    await run('delete from classmembers where classid < 101010')
    await run(studentsQuery)
    await run(teachersQuery)
    await run(coursesQuery)
    await run(format('INSERT INTO teacherteams (teacherteamid) VALUES %L', createTeacherTeams()))
    await createTeacherTeacherTeam().then(e => run(format('INSERT INTO teacher_teacherteam (teacherid, teacherteamid) VALUES %L',e)))
    await run(format('INSERT INTO classes (classid, courseid, starts, ends, teacherteamid, coursetype) VALUES %L', createClasses()))
    await createClassMembers().then(e => run(format('INSERT INTO classmembers (studentid, classid) VALUES %L',e)))
}
runQueries()

