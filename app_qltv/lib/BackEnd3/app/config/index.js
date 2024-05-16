const config = {
    development: {
      host: 'localhost',
      database: 'quanlytiemvang',
      user: 'userB', 
      password: '12345',
      dialect: 'mysql',
    },
    production: {
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      dialect: 'mysql',
    },
  };
  
  module.exports = config;