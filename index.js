const cors = require('cors');
const express = require('express')
const app = express()
const port = 3000
const dotenv = require('dotenv');
const swaggerUi = require('swagger-ui-express');
const yaml = require('yamljs');
const fs = require('fs');
const usuariosRoutes = require('./routes/usuarios');
const empresasRoutes = require('./routes/empresas');

dotenv.config();
app.use(express.json());

app.use(cors({
  //origin: 'http://localhost:4200'
  origin: 'https://cumplimiento-marcos-legales.web.app/'
}));

// Rutas de api
app.use('/usuarios', usuariosRoutes);
app.use('/empresas', empresasRoutes);


app.listen(port, () => {
  console.log(`Servidor corriendo`);
});