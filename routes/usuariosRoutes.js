const express = require('express');
const router = express.Router();
const { getUsuarios, addUsuario, updateUsuario } = require('../controllers/usuariosController');
const authMiddleware = require('../middlewares/authMiddleware');

router.get('/', getUsuarios);
router.post('/', authMiddleware, addUsuario);
router.put('/:id', authMiddleware, updateUsuario);

module.exports = router;
