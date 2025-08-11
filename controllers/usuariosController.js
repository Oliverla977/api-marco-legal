const connection = require('../config/db');
const { body, validationResult } = require('express-validator');

// Validacion al crear usuario
exports.validateUser = [
    body('nombre')
      .trim()
      .notEmpty()
      .withMessage('El nombre es requerido')
      .isLength({ min: 3 })
      .withMessage('El nombre debe tener al menos 3 caracteres')
      .matches(/^[A-Za-z]+$/)
      .withMessage('El nombre solo puede contener letras'),
    body('correo')
      .trim()
      .notEmpty()
      .withMessage('El correo es requerido')
      .matches(/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)
      .withMessage('Formato de correo inválido')
      .isEmail()
      .withMessage('Debe ser un correo válido')
      .normalizeEmail()
  ];

exports.crearUsuario = async (req, res) => {
  try {
    // Verificar si hay errores de validación
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ 
        success: false,
        errors: errors.array() 
      });
    }

    const { uid_firebase, nombre, correo, rol } = req.body;

    // Verficar si el usuario existe
    const [existingUsers] = await connection.query(
      'SELECT id_usuario FROM Usuario WHERE correo = ?',
      [correo]
    );

    if (existingUsers.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'El correo ya esta registrado'
      });
    }

    // Insertar el nuevo usuario
    const [result] = await connection.query(
      'CALL SP_RegistrarUsuario(?, ?, ?, ?)',
      [uid_firebase, correo, nombre, rol]
    );

    res.status(201).json({
      success: true,
      message: 'Usuario creado',
      data: {
        id: result.insertId,
        nombre,
        correo,
        rol
      }
    });

  } catch (error) {
    console.error('Error al crear usuario:', error);
    res.status(500).json({
      success: false,
      message: 'Error al crear el usuario',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

exports.obtenerUsuarios = async (req, res) => {
  try {
    const [rows] = await connection.query('CALL SP_ConsultarUsuarios()');
    const usuarios = rows[0];

    res.status(200).json({
      success: true,
      data: usuarios
    });
  } catch (error) {
    console.error('Error al obtener usuarios:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener los usuarios',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

exports.deshabilitarUsuario = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    const [result] = await connection.query(
      'CALL SP_EliminarUsuario(?)',
      [id_usuario]
    );

    res.status(200).json({
      success: true,
      message: `Usuario ${id_usuario} deshabilitado correctamente`,
      data: result
    });
  } catch (error) {
    console.error('Error al deshabilitar usuario:', error);
    res.status(500).json({
      success: false,
      message: 'Error al deshabilitar usuario',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

exports.habilitarUsuario = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    const [result] = await connection.query(
      'CALL SP_HabilitarUsuario(?)',
      [id_usuario]
    );

    res.status(200).json({
      success: true,
      message: `Usuario ${id_usuario} habilitado correctamente`,
      data: result
    });
  } catch (error) {
    console.error('Error al habilitar usuario:', error);
    res.status(500).json({
      success: false,
      message: 'Error al habilitar usuario',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};