const express = require('express');
const router = express.Router();
const evaluacionController = require('../controllers/evaluacionController');

//POST /evaluacion/encabezado
router.post('/encabezado', evaluacionController.nuevaEvaluacion);

//POST /evaluacion/detalle
router.post('/detalle', evaluacionController.nuevaEvaluacionDetalle);

//GET
router.get('/resumen/:id_empresa', evaluacionController.resumenEvaluacion);

//GET informe evaluacion
router.get('/informe/:id_evaluacion', evaluacionController.informeEvaluacion);

module.exports = router;