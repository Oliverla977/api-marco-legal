const express = require('express');
const router = express.Router();
const auditorController = require('../controllers/auditorController');

// asignar un auditor a una empresa
router.post('/asignar', auditorController.registrarEmpresaAuditor);

// Obtener todos los auditores
router.get("/", auditorController.obtenerData);

// Obtener auditores de una empresa específica
router.get("/empresa/:id_empresa", auditorController.consultarAuditoresEmpresa);

module.exports = router;
