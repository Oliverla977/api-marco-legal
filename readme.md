
# API Marco Legal - Backend Express.js

## Información del Proyecto

Esta API fue desarrollada por:

-  **Denilson Antonio Hi Ordoñez**

  

-  **José Humberto Chiquitá Cordero**

  

-  **Klelia Marianne Stewart de León**

  

-  **Luis René Quiñonez Gaitán**

  

-  **Oliver Eduardo López Arenas**

  

  

Para el curso de **Marco Legal y Regulatorio** de la **FACULTAD DE INGENIERÍA EN SISTEMAS DE INFORMACIÓN** - **PROGRAMA DE POSGRADOS** - **MAESTRÍA EN SEGURIDAD INFORMATÍCA**

  

  

Ingeniera a cargo: **Inga. Evelyn Yesenia Lobos Barrera**

---

## Descripción

API RESTful construida con Express.js que proporciona servicios backend para el Sistema de Cumplimiento Marco Legal. Esta API maneja la lógica de negocio, ejecuta procedimientos almacenados de MySQL, y proporciona endpoints seguros para la gestión de auditorías, evaluaciones, empresas, marcos legales y usuarios.

### Frontend Relacionado

El frontend de esta API se encuentra en el repositorio:
**https://github.com/Oliverla977/Cumplimiento-marco-legal/**

---

## Características Principales

- **API RESTful**: Endpoints organizados por módulos funcionales
- **Base de Datos MySQL**: Integración con procedimientos almacenados
- **Autenticación Firebase**: Validación de tokens
- **CORS Configurado**: Seguridad para peticiones cross-origin
- **Variables de Entorno**: Configuración flexible por ambiente
- **Arquitectura Modular**: Separación clara entre rutas, controladores y modelos
- **Manejo de Errores**: Respuestas consistentes y logging detallado

---

## Estructura del Proyecto

```
API-MARCO-LEGAL/
├── config/
│   └── db.js                    # Configuración de conexión MySQL
├── controllers/
│   ├── auditorController.js     # Lógica de auditorías
│   ├── dashboardController.js   # Datos para dashboard
│   ├── empresasController.js    # Gestión de empresas
│   ├── evaluacionController.js  # Manejo de evaluaciones
│   ├── marcoController.js       # Marcos legales y normativos
│   └── usuariosController.js    # Gestión de usuarios
├── models/                      # Modelos de datos (si aplica)
├── node_modules/               # Dependencias de npm
├── routes/
│   ├── auditor.js              # Rutas para auditorías
│   ├── dashboard.js            # Rutas para dashboard
│   ├── empresas.js             # Rutas para empresas
│   ├── evaluacion.js           # Rutas para evaluaciones
│   ├── marco.js                # Rutas para marcos legales
│   └── usuarios.js             # Rutas para usuarios
├── .env                        # Variables de entorno
├── .gitignore                  # Archivos ignorados por Git
├── BD.sql                      # Base de datos inicial del proyecto
├── index.js                    # Punto de entrada de la aplicación
└── package-lock.json           # Dependencias bloqueadas
```

---

## Requisitos del Sistema

### Prerequisitos

- **Node.js**: Versión LTS `^20.19.0 || ^22.12.0 || ^24.0.0`
- **MySQL**: Versión 8.0 o superior
- **npm**: Gestor de paquetes (incluido con Node.js)

### Base de Datos

La API requiere una base de datos MySQL configurada con:
- Base de datos llamada "Proyecto_Marco"
- Procedimientos almacenados implementados
- Usuario con permisos para ejecutar stored procedures

---

## Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/Oliverla977/api-marco-legal
cd api-marco-legal
```

### 2. Instalar Dependencias

```bash
npm install
```

### 3. Configurar Base de Datos

```bash
# Conectar a MySQL y crear la base de datos
mysql -u root -p

# Ejecutar el script inicial
mysql -u tu_usuario -p < BD.sql
```

### 4. Configurar Variables de Entorno

Crea un archivo `.env` en la raíz del proyecto con las siguientes variables:

```env
# Configuración de Base de Datos
DB_HOST=localhost
DB_USER=tu_usuario_mysql
DB_PASSWORD=tu_contraseña_mysql
DB_NAME=Proyecto_Marco
DB_PORT=3306

# Configuración de Servidor
LOCAL_SERVER_URL=http://localhost:3000
PRODUCTION_SERVER_URL=tu_url_produccion
NODE_ENV=local
```

### 5. Verificar Conexión

```bash
# Iniciar el servidor y verificar logs
npm start
```

---

## Uso

### Iniciar el Servidor

```bash
node index.js

# El servidor estará disponible en http://localhost:3000
```




## Deployment

### Variables de Entorno para Producción

Asegúrate de configurar todas las variables de entorno en tu servidor de producción:

```env
NODE_ENV=production
DB_HOST=tu_host_produccion
DB_USER=tu_usuario_produccion
DB_PASSWORD=tu_password_produccion
PRODUCTION_SERVER_URL=https://tu-api-dominio.com
```

### Plataformas Recomendadas

- **Render**: Deployment automático desde Git
- **Heroku**: Fácil configuración y escalamiento
- **DigitalOcean**: VPS con control completo
- **AWS EC2**: Máxima flexibilidad y escalabilidad




### Agregando Nuevos Endpoints

1. Crear controlador en `/controllers/`
2. Definir rutas en `/routes/`
3. Registrar rutas en `index.js`
4. Crear procedimiento almacenado si es necesario
5. Actualizar documentación


## Licencia

Este proyecto fue desarrollado con fines académicos para el curso de Marco Legal y Regulatorio de la Facultad de Ingeniería en Sistemas de Información.