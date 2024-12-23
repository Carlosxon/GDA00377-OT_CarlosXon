const { poolPromise } = require('../config/db');

exports.getEstados = async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query('SELECT * FROM estados');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.addEstado = async (req, res) => {
  const { nombre } = req.body;
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('nombre', nombre)
      .query('INSERT INTO estados (nombre) VALUES (@nombre)');
    res.status(201).json({ message: 'Estado agregado exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.updateEstado = async (req, res) => {
  const { id } = req.params;
  const { nombre } = req.body;
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('id', id)
      .input('nombre', nombre)
      .query('UPDATE estados SET nombre = @nombre WHERE idestados = @id');
    res.json({ message: 'Estado actualizado exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
