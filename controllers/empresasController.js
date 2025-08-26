const connection = require('../config/db');
const { validationResult } = require('express-validator');

// Crear empresa
exports.crearEmpresa = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        errors: errors.array()
      });
    }

    const { nombre, sector, pais } = req.body;

    const [result] = await connection.query(
      'CALL SP_RegistrarEmpresa(?, ?, ?)',
      [nombre, sector, pais]
    );

    res.status(201).json({
      success: true,
      message: 'Empresa creada correctamente',
      data: {
        id: result.insertId,
        nombre,
        sector,
        pais
      }
    });

  } catch (error) {
    console.error('Error al crear empresa:', error);
    res.status(500).json({
      success: false,
      message: 'Error al crear la empresa',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Obtener una empresa por id
exports.obtenerEmpresa = async (req, res) => {
  try {
    const { id_empresa } = req.params;

    const [rows] = await connection.query(
      'CALL SP_ConsultarEmpresa(?)',
      [id_empresa]
    );

    const empresa = rows[0][0]; // primera fila del resultado

    if (!empresa) {
      return res.status(404).json({
        success: false,
        message: 'Empresa no encontrada'
      });
    }

    res.status(200).json({
      success: true,
      data: empresa
    });

  } catch (error) {
    console.error('Error al obtener empresa:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener la empresa',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Obtener todas las empresas
exports.obtenerEmpresas = async (req, res) => {
  try {
    const [rows] = await connection.query('CALL SP_ConsultarEmpresas()');
    const empresas = rows[0];

    res.status(200).json({
      success: true,
      data: empresas
    });

  } catch (error) {
    console.error('Error al obtener empresas:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener las empresas',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Actualizar empresa
exports.actualizarEmpresa = async (req, res) => {
  try {
    const { id_empresa } = req.params;
    const { nombre, sector, pais } = req.body;

    const [result] = await connection.query(
      'CALL SP_ActualizarEmpresa(?, ?, ?, ?)',
      [id_empresa, nombre, sector, pais]
    );

    res.status(200).json({
      success: true,
      message: `Empresa ${id_empresa} actualizada correctamente`,
      data: result
    });

  } catch (error) {
    console.error('Error al actualizar empresa:', error);
    res.status(500).json({
      success: false,
      message: 'Error al actualizar la empresa',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Deshabilitar empresa
exports.deshabilitarEmpresa = async (req, res) => {
  try {
    const { id_empresa } = req.params;

    const [result] = await connection.query(
      'CALL SP_EliminarEmpresa(?)',
      [id_empresa]
    );

    res.status(200).json({
      success: true,
      message: `Empresa ${id_empresa} deshabilitada correctamente`,
      data: result
    });

  } catch (error) {
    console.error('Error al deshabilitar empresa:', error);
    res.status(500).json({
      success: false,
      message: 'Error al deshabilitar la empresa',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Habilitar empresa
exports.habilitarEmpresa = async (req, res) => {
  try {
    const { id_empresa } = req.params;

    const [result] = await connection.query(
      'CALL SP_HabilitarEmpresa(?)',
      [id_empresa]
    );

    res.status(200).json({
      success: true,
      message: `Empresa ${id_empresa} habilitada correctamente`,
      data: result
    });

  } catch (error) {
    console.error('Error al habilitar empresa:', error);
    res.status(500).json({
      success: false,
      message: 'Error al habilitar la empresa',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Registrar empresa-auditor
exports.registrarEmpresaAuditor = async (req, res) => {
  try {
    const { id_empresa, id_usuario } = req.body;

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

// Consultar todos los auditores (usuarios con rol = 3)
exports.consultarAuditores = async (req, res) => {
  try {
    const [rows] = await connection.query("CALL SP_ConsultarAuditores()");
    // MySQL con CALL devuelve un array doble, tomamos [0]
    res.json(rows[0]);
  } catch (error) {
    console.error("Error en consultarAuditores:", error);
    res.status(500).json({ message: "Error al consultar auditores" });
  }
};

// Consultar auditores asignados a una empresa
exports.consultarAuditoresEmpresa = async (req, res) => {
  try {
    const { id_empresa } = req.params;

    const [rows] = await connection.query("CALL SP_ConsultarAuditoresEmpresa(?)", [
      id_empresa,
    ]);

    res.json(rows[0]);
  } catch (error) {
    console.error("Error en consultarAuditoresEmpresa:", error);
    res.status(500).json({ message: "Error al consultar auditores de empresa" });
  }
};

// Consultar empresas asignadas a un auditor
exports.consultarEmpresasAuditor = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    // Ejecutar la consulta (o SP si lo tienes creado)
    const [rows] = await connection.query(
      "SELECT id_empresa FROM Empresa_auditor WHERE id_usuario = ?",
      [id_usuario]
    );

    res.status(200).json({
      success: true,
      data: rows
    });

  } catch (error) {
    console.error("Error en consultarEmpresasAuditor:", error);
    res.status(500).json({
      success: false,
      message: "Error al consultar empresas asignadas al auditor"
    });
  }
};
