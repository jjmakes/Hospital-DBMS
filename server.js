const mysql = require('mysql');
const express = require('express');
const bodyparser = require('body-parser');
const path = require('path');
var app = express();
let fs = require('fs')

//Rendering content with EJS
//https://stackoverflow.com/questions/50581353/send-html-file-and-data-using-express/50581772


//Posting Data
//https://codeforgeek.com/handle-get-post-request-express-4/

//Dir
//C:\Users\jayjurz\Documents\workspace\CS331-HRBM
//nodemon server.js


//Configuring express server
app.use(bodyparser.json());
app.use(express.static(path.join(__dirname, 'public')));

//MySQL details
var mysqlConnection = mysql.createConnection({
    host: 'cs331-hrbm.cgwgu96bw36v.us-east-1.rds.amazonaws.com',
    port: '3306',
    user: 'admin_J',
    password: '3e4iEj%hU*rf',
    database: 'hrbm',
    multipleStatements: true
});

mysqlConnection.connect((err)=> {
    if(!err)
    console.log('Connection Established Successfully');
    else
    console.log('Connection Failed!'+ JSON.stringify(err,undefined,2));
});

//Establish the server connection
//PORT ENVIRONMENT VARIABLE
const port = process.env.PORT || 8080;
app.listen(port, () => console.log(`Listening on port ${port}..`));


//Home
app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname, '/index.html'));
});


//Departments
app.get('/departments' , (req, res) => {
    mysqlConnection.query('SELECT * FROM DEPARTMENTS', (err, rows, fields) => {
    if (!err) {
        //path.join(__dirname, '/index.html')
        //res.send(rows);
        res.send(fs.readFileSync(path.join(__dirname, '/departments.html')).toString() + sqlToHTML(rows));
    }
    else
    console.log(err);
    })
});

//Employees
app.get('/employees' , (req, res) => {
    mysqlConnection.query('SELECT * FROM EMPLOYEES', (err, rows, fields) => {
    if (!err)
    res.send(fs.readFileSync(path.join(__dirname, '/employees.html')).toString() + sqlToHTML(rows));
    else
    console.log(err);
    })
});

//Schedules
app.get('/schedules' , (req, res) => {
    mysqlConnection.query('SELECT * FROM SCHEDULES', (err, rows, fields) => {
    if (!err)
    res.send(fs.readFileSync(path.join(__dirname, '/schedules.html')).toString() + sqlToHTML(rows));
    else
    console.log(err);
    })
});

//Hospital_Resources
app.get('/resources' , (req, res) => {
    mysqlConnection.query('SELECT * FROM HOSPITAL_RESOURCES', (err, rows, fields) => {
    if (!err)
    res.send(fs.readFileSync(path.join(__dirname, '/resources.html')).toString() + sqlToHTML(rows));
    else
    console.log(err);
    })
});

//Patients
app.get('/patients' , (req, res) => {
    mysqlConnection.query('SELECT * FROM PATIENTS', (err, rows, fields) => {
    if (!err)
    res.send(fs.readFileSync(path.join(__dirname, '/patients.html')).toString() + sqlToHTML(rows));
    else
    console.log(err);
    })
});

//Cases
app.get('/cases' , (req, res) => {
    mysqlConnection.query('SELECT * FROM CASES', (err, rows, fields) => {
    if (!err)
    res.send(fs.readFileSync(path.join(__dirname, '/cases.html')).toString() + sqlToHTML(rows));
    else
    console.log(err);
    })
});

//Handles
app.get('/handles' , (req, res) => {
    mysqlConnection.query('SELECT * FROM HANDLES', (err, rows, fields) => {
    if (!err)
    res.send(fs.readFileSync(path.join(__dirname, '/handles.html')).toString() + sqlToHTML(rows));
    else
    console.log(err);
    })
});

//Housed_Under
app.get('/houses' , (req, res) => {
    mysqlConnection.query('SELECT * FROM HOUSED_UNDER', (err, rows, fields) => {
    if (!err)
    res.send(fs.readFileSync(path.join(__dirname, '/houses.html')).toString() + sqlToHTML(rows));
    else
    console.log(err);
    })
});

//Router to INSERT/POST a Patient
//r_id = String(Math.floor(Math.random() * 9) + 1) + String(Math.floor(Math.random() * 9000));

function sqlToHTML(sqlRes) {
    htmlString = '<script>document.getElementById(\'resdata\').innerHTML = `';
    //Append titles first
    htmlString += "<table><tr>";
    for (key in sqlRes[0]) {
        htmlString += ('<th>' + JSON.stringify(key).replace(/['"]+/g, '') + '</th>');
    };
    htmlString += "</tr>";

    //Append data
    sqlRes.forEach(obj =>{
        htmlString += "<tr>";
        for (key in obj) {
            htmlString += ('<td>' + JSON.stringify(obj[key]).replace(/['"]+/g, '') + '</td>');
        }
        htmlString += "</tr>";
    });
    return htmlString + '`</script>';
}