const connection = require('../config/db');
const { body, validationResult } = require('express-validator');

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

// Actualizar usuario usando el procedimiento almacenado
exports.actualizarUsuario = async (req, res) => {
  const { id_usuario } = req.params;
  const { correo, nombre, id_rol } = req.body;

  try {
    // Ejecutar el SP con los parámetros enviados
    const [result] = await connection.query(
      `CALL SP_ActualizarUsuario(?, ?, ?, ?)`,
      [id_usuario, correo, nombre, id_rol]
    );

    // Verificar si se actualizó
    if (result.affectedRows === 0) {
      return res.status(404).json({ mensaje: 'Usuario no encontrado o sin cambios' });
    }

    res.status(200).json({ mensaje: 'Usuario actualizado correctamente' });
  } catch (error) {
    console.error('Error al actualizar usuario:', error);
    res.status(500).json({ error: 'Error al actualizar usuario' });
  }
};

exports.obtenerUsuario = async (req, res) => {
  try {
    const { id_usuario } = req.params;

    const [result] = await connection.query(
      'CALL SP_ConsultarUsuario(?)',
      [id_usuario]
    );
    
    const usuario = result[0];

    res.status(200).json({
      success: true,
      data: usuario
    });
  } catch (error) {
    console.error('Error al obtener usuario:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener el usuario',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

exports.obtenerUsuarioFirebase = async (req, res) => {
  try {
    const { uid } = req.body;

    const [result] = await connection.query(
      'CALL SP_ConsultarUsuarioFirebase(?)',
      [uid]
    );
    
    const usuario = result[0];

    res.status(200).json({
      success: true,
      data: usuario
    });
  } catch (error) {
    console.error('Error al obtener usuario:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener el usuario',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};