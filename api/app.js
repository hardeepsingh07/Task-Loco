const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const API_PORT = process.env.PORT || 8080;
const DB_URL = "mongodb://db:27017/task-loco-api";

mongoose.connect(DB_URL, {useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true})
    .then(() => { console.log("Database Connected")})
    .catch(() => { console.log("Database not Connected")});

let app = express();
app.use(bodyParser.json());
app.get("/", (req, res) => {res.json({api: "Welcome to Task Loco Api"})});
app.use('/user', require('./route/User'));
app.use('/task', require('./route/Task'));
app.listen(API_PORT, function () {console.log("Task Loco API is running on port: " + API_PORT)});