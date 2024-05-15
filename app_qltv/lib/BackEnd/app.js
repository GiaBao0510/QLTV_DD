//Thêm module
const express = require('express');
const session = require('express-session');
const cors = require('cors');
const os = require('os');

const connectMySQL = require('./app/config/index');

var bodyParser = require('body-parser');

const app = express();

app.use(
    session({
        secret: 'somesecret',
        cookie: {maxAge:60000},
        resave:true,
        saveUninitialized:false
    })
);

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended: true}));

//Xử lý lỗi
app