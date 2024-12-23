const sql = require('mssql');
require('dotenv').config();

const config = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  database: process.env.DB_NAME,
  options: {
    encrypt: false, // Desactiva SSL si no se usa
    trustServerCertificate: true,
  },
};

const poolPromise = new sql.ConnectionPool(config)
  .connect()
  .then(pool => {
    console.log('Conexión a SQL Server establecida');
    return pool;
  })
  .catch(err => console.error('Error en la conexión a SQL Server', err));

module.exports = {
  sql, poolPromise
};
