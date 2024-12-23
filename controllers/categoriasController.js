const { poolPromise } = require('../config/db');

exports.getCategorias = async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query('SELECT * FROM CategoriaProductos');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.addCategoria = async (req, res) => {
  const { nombre } = req.body;
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('nombre', nombre)
      .query('INSERT INTO CategoriaProductos (nombre) VALUES (@nombre)');
    res.status(201).json({ message: 'Categoría agregada exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.updateCategoria = async (req, res) => {
  const { id } = req.params;
  const { nombre } = req.body;
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('id', id)
      .input('nombre', nombre)
      .query('UPDATE CategoriaProductos SET nombre = @nombre WHERE idCategoriaProductos = @id');
    res.json({ message: 'Categoría actualizada exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
