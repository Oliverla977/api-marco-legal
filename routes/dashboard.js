const express = require('express');
const router = express.Router();
const dashboardController = require('../controllers/dashboardController');

// Obtener todos los auditores
router.get("/resumen", dashboardController.consultarResumenDashboard);

//obetener resumen de cumplimiento
router.get("/resumencumplimiento", dashboardController.consultarResumenCumplimiento);

module.exports = router;
