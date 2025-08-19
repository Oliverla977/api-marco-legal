const express = require('express');
const router = express.Router();
const empresasController = require('../controllers/empresasController');

// POST /empresas/registro → creación de nuevas empresas
router.post('/registro', empresasController.crearEmpresa);

// GET /empresas/:id_empresa → obtener una empresa por ID
router.get('/:id_empresa', empresasController.obtenerEmpresa);

// GET /empresas → obtener todas las empresas
router.get('/', empresasController.obtenerEmpresas);

// PUT /empresas/actualizar/:id_empresa → actualizar empresa por ID
router.put('/actualizar/:id_empresa', empresasController.actualizarEmpresa);

// PUT /empresas/deshabilitar/:id_empresa → deshabilitar empresa (cambia estado a 2)
router.put('/deshabilitar/:id_empresa', empresasController.deshabilitarEmpresa);

// PUT /empresas/habilitar/:id_empresa → habilitar empresa (cambia estado a 1)
router.put('/habilitar/:id_empresa', empresasController.habilitarEmpresa);

// POST /empresas/asignar-auditor → asignar un auditor a una empresa
router.post('/asignar-auditor', empresasController.registrarEmpresaAuditor);

module.exports = router;
