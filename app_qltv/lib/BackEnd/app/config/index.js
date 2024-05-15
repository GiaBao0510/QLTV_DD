const config = {
    app:{
        port: 3306|| process.env.PORT,
    },
    db:{
        uri: process.env.MYSQL_URI || 'mysql://localhost:3306/quanlytiemvang'
    }
};

module.exports = config;