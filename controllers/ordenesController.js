const { poolPromise } = require('../config/db');

// Obtener todas las órdenes
exports.getOrdenes = async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query('SELECT * FROM Orden');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Agregar una nueva orden (solo encabezado)
exports.addOrden = async (req, res) => {
  const { usuarios_idusuarios, estados_idestados, nombre_completo, direccion, telefono, correo_electronico, fecha_entrega, total_orden } = req.body;

  try {
    const pool = await poolPromise;
    await pool.request()
      .input('usuarios_idusuarios', usuarios_idusuarios)
      .input('estados_idestados', estados_idestados)
      .input('nombre_completo', nombre_completo)
      .input('direccion', direccion)
      .input('telefono', telefono)
      .input('correo_electronico', correo_electronico)
      .input('fecha_entrega', fecha_entrega)
      .input('total_orden', total_orden)
      .query(`
        INSERT INTO Orden (usuarios_idusuarios, estados_idestados, fecha_creacion, nombre_completo, direccion, telefono, correo_electronico, fecha_entrega, total_orden)
        VALUES (@usuarios_idusuarios, @estados_idestados, GETDATE(), @nombre_completo, @direccion, @telefono, @correo_electronico, @fecha_entrega, @total_orden)
      `);
    res.status(201).json({ message: 'Orden agregada exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Actualizar una orden existente (solo encabezado)
exports.updateOrden = async (req, res) => {
  const { id } = req.params;
  const { usuarios_idusuarios, estados_idestados, nombre_completo, direccion, telefono, correo_electronico, fecha_entrega, total_orden } = req.body;

  try {
    const pool = await poolPromise;
    await pool.request()
      .input('id', id)
      .input('usuarios_idusuarios', usuarios_idusuarios)
      .input('estados_idestados', estados_idestados)
      .input('nombre_completo', nombre_completo)
      .input('direccion', direccion)
      .input('telefono', telefono)
      .input('correo_electronico', correo_electronico)
      .input('fecha_entrega', fecha_entrega)
      .input('total_orden', total_orden)
      .query(`
        UPDATE Orden
        SET usuarios_idusuarios = @usuarios_idusuarios,
            estados_idestados = @estados_idestados,
            nombre_completo = @nombre_completo,
            direccion = @direccion,
            telefono = @telefono,
            correo_electronico = @correo_electronico,
            fecha_entrega = @fecha_entrega,
            total_orden = @total_orden
        WHERE idOrden = @id
      `);
    res.json({ message: 'Orden actualizada exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
