const connection = require('../config/db');

exports.nuevaEvaluacion = async (req, res) => {
  try {
    const { id_empresa, id_marco_legal, id_usuario } = req.body;

    const [result] = await connection.query(
      'CALL SP_RegistrarEvaluacion(?, ?, ?)',
      [id_empresa, id_marco_legal, id_usuario]
    );

    const idEvaluacion = result[0][0].id_evaluacion;

    res.status(201).json({
      success: true,
      message: 'Evaluacion creada correctamente',
      data: {
        id: idEvaluacion,
      }
    });

  } catch (error) {
    console.error('Error al crear evaluacion:', error);
    res.status(500).json({
      success: false,
      message: 'Error al crear',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

exports.nuevaEvaluacionDetalle = async (req, res) => {
  try {
    const detalles = req.body; // debe ser un array de objetos

    if (!Array.isArray(detalles)) {
      return res.status(400).json({
        success: false,
        message: 'El body debe ser un arreglo de evaluaciones'
      });
    }

    // Procesar cada evaluacion con una transacción (opcional)
    const results = [];
    for (const detalle of detalles) {
      const { id_evaluacion, id_articulo, id_estado, observaciones, evidencia } = detalle;

      const [result] = await connection.query(
        'CALL SP_RegistrarEvaluacionDetalle(?, ?, ?, ?, ?)',
        [id_evaluacion, id_articulo, id_estado, observaciones, evidencia]
      );

      results.push(result);
    }

    res.status(201).json({
      success: true,
      message: 'Evaluaciones creadas correctamente',
      registros: results.length
    });

  } catch (error) {
    console.error('Error al crear evaluaciones:', error);
    res.status(500).json({
      success: false,
      message: 'Error al crear evaluaciones',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

exports.resumenEvaluacion = async (req, res) => {
  try {
    const { id_empresa } = req.params;

    if (!id_empresa) {
      return res.status(400).json({
        success: false,
        message: 'Debe enviar id_empresa'
      });
    }

    // Llamar al stored procedure
    const [result] = await connection.query(
      'CALL GetEvaluacionesEmpresa(?)',
      [id_empresa]
    );

    const evaluaciones = result[0];

    res.status(200).json({
      success: true,
      message: 'Resumen de evaluaciones obtenido correctamente',
      data: evaluaciones
    });

  } catch (error) {
    console.error('Error al obtener resumen de evaluaciones:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener resumen',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Informe de una evaluación específica
exports.informeEvaluacion = async (req, res) => {
  try {
    const { id_evaluacion } = req.params;

    if (!id_evaluacion) {
      return res.status(400).json({
        success: false,
        message: 'Debe enviar id_evaluacion'
      });
    }

    // Ejecutar el stored procedure
    const [result] = await connection.query(
      'CALL SP_informe_evaluacion(?)',
      [id_evaluacion]
    );

    // En MySQL los resultados de CALL vienen como un array anidado:
    // result[0] contiene el dataset real
    const informe = result[0];

    res.status(200).json({
      success: true,
      message: 'Informe de evaluación obtenido correctamente',
      data: informe
    });

  } catch (error) {
    console.error('Error al obtener informe de evaluación:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener informe',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};