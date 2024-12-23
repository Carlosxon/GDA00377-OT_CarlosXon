const { poolPromise } = require('../config/db');

exports.getClientes = async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query('SELECT * FROM Clientes');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.addCliente = async (req, res) => {
  const { razon_social, nombre_comercial, direccion_entrega, telefono, email } = req.body;
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('razon_social', razon_social)
      .input('nombre_comercial', nombre_comercial)
      .input('direccion_entrega', direccion_entrega)
      .input('telefono', telefono)
      .input('email', email)
      .query(`INSERT INTO Clientes (razon_social, nombre_comercial, direccion_entrega, telefono, email) 
              VALUES (@razon_social, @nombre_comercial, @direccion_entrega, @telefono, @email)`);
    res.status(201).json({ message: 'Cliente agregado exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.updateCliente = async (req, res) => {
  const { id } = req.params;
  const { razon_social, nombre_comercial, direccion_entrega, telefono, email } = req.body;
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('id', id)
      .input('razon_social', razon_social)
      .input('nombre_comercial', nombre_comercial)
      .input('direccion_entrega', direccion_entrega)
      .input('telefono', telefono)
      .input('email', email)
      .query(`UPDATE Clientes SET razon_social = @razon_social, nombre_comercial = @nombre_comercial, 
              direccion_entrega = @direccion_entrega, telefono = @telefono, email = @email WHERE idClientes = @id`);
    res.json({ message: 'Cliente actualizado exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
