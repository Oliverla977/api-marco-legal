const connection = require('../config/db');

// Consultar resumen para dashboard
exports.consultarResumenDashboard = async (req, res) => {
  try {
    // Ejecutar el SP
    const [rows] = await connection.query("CALL sp_resumen_dashboard1()");

    // El resultado del SP viene en la primera posición del arreglo
    const data = rows[0];

    if (!data || data.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No se encontraron datos para el resumen'
      });
    }

    res.status(200).json({
      success: true,
      data: data[0] // el primer objeto con los totales
    });

  } catch (error) {
    console.error('Error al consultar el resumen del dashboard:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener los datos del resumen',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Consultar resumen de cumplimiento (últimas 5 o todas las evaluaciones)
exports.consultarResumenCumplimiento = async (req, res) => {
  try {
    // Recibir el parámetro desde query (?modo=ULTIMAS o ?modo=TODAS)
    const { modo } = req.query;

    if (!modo || (modo !== 'ULTIMAS' && modo !== 'TODAS')) {
      return res.status(400).json({
        success: false,
        message: "Debe enviar el parámetro 'modo' con valor 'ULTIMAS' o 'TODAS'"
      });
    }

    // Llamar al SP
    const [rows] = await connection.query("CALL sp_resumen_cumplimiento(?)", [modo]);

    const data = rows[0]; // Los datos vienen en la primera posición

    if (!data || data.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No se encontraron resultados'
      });
    }

    res.status(200).json({
      success: true,
      modo,
      data
    });

  } catch (error) {
    console.error('Error al consultar resumen de cumplimiento:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener el resumen de cumplimiento',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};