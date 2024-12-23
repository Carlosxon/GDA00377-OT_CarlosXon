const express = require('express');
const router = express.Router();
const { getCategorias, addCategoria, updateCategoria } = require('../controllers/categoriasController');
const authMiddleware = require('../middlewares/authMiddleware');

router.get('/', getCategorias);
router.post('/', authMiddleware, addCategoria);
router.put('/:id', authMiddleware, updateCategoria);

module.exports = router;
