var express = require('express');
var router = express.Router();
var dbcontroller = require('./dbController');

router.get('/dbinfo', dbcontroller.getDatabaseInfo);
router.put('/dbinfo',dbcontroller.updateDatabaseConnection);

module.exports = router;