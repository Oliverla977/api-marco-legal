const express = require('express');
const router = express.Router();
const usuariosController = require('../controllers/usuariosController');

//POST /usuarios/registro creacion de nuevos usuarios con validacion de datos
router.post('/registro', usuariosController.validateUser, usuariosController.crearUsuario);
//GET /usuarios/usuarios obtener todos los usuarios
router.get('/', usuariosController.obtenerUsuarios);


module.exports = router;