var db= require('../config/index_2');
//var updateConnection = require('../config/updateConnection');
const fs = require('fs')
const mysql = require('mysql');

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

// exports.updateDatabaseConnection = function(req, res) {
//     var newConfig = {
//         host: req.body.host,
//         database: req.body.database,
//         port: req.body.port,
//         user: req.body.user,
//         password: req.body.password
//     };

//     try {
//         fs.writeFile('./app/config/test.json', JSON.stringify(newConfig, null, 2), (err) => {
//             if (err) {
//               return res.status(500).send('Failed to update configuration');
//             }
        
//             // Reinitialize database connection
//             db = reinitializeDbConnection(newConfig);
        
//             res.status(200).send('Configuration updated successfully');
            
//         });
//     } catch (error) {
//         console.error('Error updating database connection:', error.stack);
//         res.status(500).send('Error updating database connection');
//     }
// };

// function reinitializeDbConnection(config){
//     const mysql = require('mysql');
//     return mysql.createConnection(config);
// }

exports.updateDatabaseConnection = function(req, res) {
    // New configuration from request body
    var newConfig = {
        host: req.body.host,
        database: req.body.database,
        port: req.body.port,
        user: req.body.user,
        password: req.body.password
    };

    // Path to the config file
    const configFilePath = './app/config/test.json';

    // Read the existing configuration
    fs.readFile(configFilePath, 'utf8', (readErr, oldConfigData) => {
        if (readErr) {
            console.error('Failed to read existing configuration:', readErr);
            return res.status(500).send('Failed to read existing configuration');
        }

        const oldConfig = JSON.parse(oldConfigData);

        // Write the new configuration to the file
        fs.writeFile(configFilePath, JSON.stringify(newConfig, null, 2), (writeErr) => {
            if (writeErr) {
                console.error('Failed to write new configuration:', writeErr);
                return res.status(500).send('Failed to write new configuration');
            }

            // Try to reinitialize the database connection
            const newDbConnection = mysql.createConnection(newConfig);
            newDbConnection.connect((connectErr) => {
                if (connectErr) {
                    console.error('Failed to connect with new configuration:', connectErr);

                    // Restore old configuration
                    fs.writeFile(configFilePath, JSON.stringify(oldConfig, null, 2), (restoreErr) => {
                        if (restoreErr) {
                            console.error('Failed to restore old configuration:', restoreErr);
                            return res.status(500).send('Failed to connect and failed to restore old configuration');
                        }
                        return res.status(500).send('Failed to connect with new configuration, old configuration restored');
                    });
                } else {
                    // Connection successful
                    newDbConnection.end();  // End the new connection if successful
                    res.status(200).send('Configuration updated and connected successfully');
                }
            });
        });
    });
};


