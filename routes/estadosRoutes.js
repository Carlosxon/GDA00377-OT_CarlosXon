const express = require('express');
const router = express.Router();
const { getEstados, addEstado, updateEstado } = require('../controllers/estadosController');
const authMiddleware = require('../middlewares/authMiddleware');

router.get('/', getEstados);
router.post('/', authMiddleware, addEstado);
router.put('/:id', authMiddleware, updateEstado);

module.exports = router;
