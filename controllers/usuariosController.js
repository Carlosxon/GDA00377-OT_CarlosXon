const { poolPromise } = require('../config/db');
const bcrypt = require('bcryptjs');

exports.getUsuarios = async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query('SELECT * FROM usuarios');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.addUsuario = async (req, res) => {
  const { rol_idrol, correo_electronico, nombre_completo, password } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('rol_idrol', rol_idrol)
      .input('correo_electronico', correo_electronico)
      .input('nombre_completo', nombre_completo)
      .input('password', hashedPassword)
      .query(`INSERT INTO usuarios (rol_idrol, correo_electronico, nombre_completo, password) 
              VALUES (@rol_idrol, @correo_electronico, @nombre_completo, @password)`);
    res.status(201).json({ message: 'Usuario agregado exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.updateUsuario = async (req, res) => {
  const { id } = req.params;
  const { rol_idrol, correo_electronico, nombre_completo, password } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('id', id)
      .input('rol_idrol', rol_idrol)
      .input('correo_electronico', correo_electronico)
      .input('nombre_completo', nombre_completo)
      .input('password', hashedPassword)
      .query(`UPDATE usuarios SET rol_idrol = @rol_idrol, correo_electronico = @correo_electronico, 
              nombre_completo = @nombre_completo, password = @password WHERE idusuarios = @id`);
    res.json({ message: 'Usuario actualizado exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
