const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

// Importar rutas
const productosRoutes = require('./routes/productosRoutes');
const categoriasRoutes = require('./routes/categoriasRoutes');
const estadosRoutes = require('./routes/estadosRoutes');
const usuariosRoutes = require('./routes/usuariosRoutes');
const ordenesRoutes = require('./routes/ordenesRoutes');
const clientesRoutes = require('./routes/clientesRoutes');
const authMiddleware = require('./middlewares/authMiddleware');

const app = express();
const port = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(bodyParser.json());

// Usar middleware de autenticación
app.use(authMiddleware);

// Rutas
app.use('/api/productos', productosRoutes);
app.use('/api/categorias', categoriasRoutes);
app.use('/api/estados', estadosRoutes);
app.use('/api/usuarios', usuariosRoutes);
app.use('/api/ordenes', ordenesRoutes);
app.use('/api/clientes', clientesRoutes);


app.listen(port, () => {
  console.log(`Servidor escuchando en el puerto ${3000}`);
});
