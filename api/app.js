const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const API_PORT = process.env.PORT || 8080;
const DB_URL = "mongodb://localhost:27017/task-loco-api";
const testData = require('./test/TestData');

mongoose.connect(DB_URL, {useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true})
    .then(() => { console.log("Database Connected")})
    .catch(() => { console.log("Database not Connected")});

let app = express();
app.use(bodyParser.json());
app.get("/", (req, res) => {res.json({api: "Welcome to Task Loco Api"})});
app.use('/user', require('./route/User'));
app.use('/task', require('./route/Task'));
app.use('/project', require('./route/Project'));
app.listen(API_PORT, function () {console.log("Task Loco API is running on port: " + API_PORT)});

//Generate Test Task Data
testData.initDate();