const connection = require('../config/db');
const { validationResult } = require('express-validator');

// Registrar empresa-auditor
exports.registrarEmpresaAuditor = async (req, res) => {
  try {
    const { id_empresa, id_usuario } = req.body;

    // Verficar si el registro ya existe
    const [existing] = await connection.query(
      'SELECT id_usuario, id_empresa FROM Empresa_auditor WHERE id_usuario = ? AND id_empresa = ?',
      [id_usuario, id_empresa]
    );

    if (existing.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Este auditor ya está asignado a esta empresa'
      });
    }


    const [result] = await connection.query(
      'CALL SP_RegistrarEmpresaAuditor(?, ?)',
      [id_empresa, id_usuario]
    );

    res.status(201).json({
      success: true,
      message: `Auditor ${id_usuario} asignado a empresa ${id_empresa}`,
      data: result
    });

  } catch (error) {
    console.error('Error al asignar auditor a empresa:', error);
    res.status(500).json({
      success: false,
      message: 'Error al asignar auditor',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Consultar auditores asignados a una empresa
exports.consultarAuditoresEmpresa = async (req, res) => {
  try {
    const { id_empresa } = req.params;

    const [rows] = await connection.query("CALL SP_ConsultarAuditoresEmpresa(?)", [
      id_empresa,
    ]);

    const data = rows[0];

    if (!data) {
      return res.status(404).json({
        success: false,
        message: 'Data no encontrada'
      });
    }

    res.status(200).json({
      success: true,
      data: data
    });

  } catch (error) {
    console.error('Error al consultar auditores de la empresa:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener la data',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

//consultar todos los auditores
exports.obtenerData = async (req, res) => {
  try {
    const [rows] = await connection.query('CALL SP_ConsultarAuditores()');

    const data = rows[0]; // primera fila del resultado

    if (!data) {
      return res.status(404).json({
        success: false,
        message: 'Data no encontrada'
      });
    }

    res.status(200).json({
      success: true,
      data: data
    });

  } catch (error) {
    console.error('Error al obtener data:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener la data',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};