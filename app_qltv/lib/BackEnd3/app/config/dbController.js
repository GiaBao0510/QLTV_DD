var db = require('../config/index_2');
var updateConnection = require('../config/updateConnection');
const fs = require('fs')

exports.getDatabaseInfo = function(req, res) {
    db.query('SELECT DATABASE() AS db_name, SUBSTRING_INDEX(USER(), "@", 1) AS db_user', function(err, results) {
        if (err) {
            console.error('Error executing query:', err.stack);
            res.status(500).send('Error executing query');
            return;
        }

        var dbInfo = {
            database: results[0].db_name,
            user: results[0].db_user,
            host: db.config.host,
            port: db.config.port
        };

        res.json(dbInfo);
    });
};

exports.updateDatabaseConnection = function(req, res) {
    var newConfig = {
        host: req.body.host,
        database: req.body.database,
        port: req.body.port,
        user: req.body.user,
        password: req.body.password
    };

    try {
        fs.writeFile('./app/config/test.json', JSON.stringify(newConfig, null, 2), (err) => {
            if (err) {
              return res.status(500).send('Failed to update configuration');
            }
        
            // Reinitialize database connection
            db = reinitializeDbConnection(newConfig);
        
            res.status(200).send('Configuration updated successfully');
            
        });
    } catch (error) {
        console.error('Error updating database connection:', error.stack);
        res.status(500).send('Error updating database connection');
    }
};

function reinitializeDbConnection(config){
    const mysql = require('mysql');
    return mysql.createConnection(config);
}
