const express = require('express');
const router = express.Router();
const { getProductos, addProducto, updateProducto } = require('../controllers/productosController');
const authMiddleware = require('../middlewares/authMiddleware');

router.get('/', getProductos);
router.post('/', authMiddleware, addProducto);
router.put('/:id', authMiddleware, updateProducto);

module.exports = router;
