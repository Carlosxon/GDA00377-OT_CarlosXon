const express = require('express');
const router = express.Router();
const { getClientes, addCliente, updateCliente } = require('../controllers/clientesController');
const authMiddleware = require('../middlewares/authMiddleware');

router.get('/', getClientes);
router.post('/', authMiddleware, addCliente);
router.put('/:id', authMiddleware, updateCliente);

module.exports = router;
