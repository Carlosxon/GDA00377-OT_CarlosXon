const express = require('express');
const router = express.Router();
const { getOrdenes, addOrden, updateOrden } = require('../controllers/ordenesController');
const authMiddleware = require('../middlewares/authMiddleware');

router.get('/', getOrdenes);
router.post('/', authMiddleware, addOrden);
router.put('/:id', authMiddleware, updateOrden);

module.exports = router;
