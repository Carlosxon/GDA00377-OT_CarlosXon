const { sql, poolPromise } = require('../config/db');

exports.getProductos = async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query('SELECT * FROM Productos');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.addProducto = async (req, res) => {
  const { nombre, marca, codigo, stock, precio } = req.body;
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('nombre', nombre)
      .input('marca', marca)
      .input('codigo', codigo)
      .input('stock', stock)
      .input('precio', precio)
      .query(`INSERT INTO Productos (nombre, marca, codigo, stock, precio) VALUES (@nombre, @marca, @codigo, @stock, @precio)`);
    res.status(201).json({ message: 'Producto agregado exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.updateProducto = async (req, res) => {
  const { id } = req.params;
  const { nombre, marca, stock, precio } = req.body;
  try {
    const pool = await poolPromise;
    await pool.request()
      .input('id', id)
      .input('nombre', nombre)
      .input('marca', marca)
      .input('stock', stock)
      .input('precio', precio)
      .query(`UPDATE Productos SET nombre = @nombre, marca = @marca, stock = @stock, precio = @precio WHERE idProductos = @id`);
    res.json({ message: 'Producto actualizado exitosamente' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
