const express = require('express');
const userRoutes = require('./app/routers/userRoutes');
const groupRoutes = require ('./app/routers/groupRoutes')
const app = express();
app.use(express.json());

app.use('/api/users', userRoutes);
app.use('/api/groups', groupRoutes);

module.exports = app;