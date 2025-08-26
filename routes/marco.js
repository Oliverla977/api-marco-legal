const express = require('express');
const router = express.Router();
const marcoLegalController = require('../controllers/marcoController');

// Registrar un marco legal completo con títulos, capítulos y artículos
router.post('/registrar', marcoLegalController.registrarMarcoLegal);

//  Obtener todos los marcos legales
router.get('/', marcoLegalController.obtenerMarcosLegales);

// GET /marcoslegales/:id
router.get('/:id_marco_legal', marcoLegalController.obtenerDetalleMarcoLegal);

// Nueva ruta: eliminar marco legal
router.delete('/:id_marco_legal', marcoLegalController.eliminarMarcoLegal);

module.exports = router;
