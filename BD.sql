-- --------------------------------------------------------
-- Host:                         marcolegal-marcolegal.d.aivencloud.com
-- Versión del servidor:         8.0.35 - Source distribution
-- SO del servidor:              Linux
-- HeidiSQL Versión:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para Proyecto_Marco
CREATE DATABASE IF NOT EXISTS `Proyecto_Marco` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `Proyecto_Marco`;

-- Volcando estructura para tabla Proyecto_Marco.Articulo_Marco_Legal
CREATE TABLE IF NOT EXISTS `Articulo_Marco_Legal` (
  `id_articulo` int NOT NULL AUTO_INCREMENT,
  `id_capitulo` int NOT NULL,
  `numero` varchar(8) DEFAULT NULL,
  `nombre` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `aplicable` int NOT NULL,
  PRIMARY KEY (`id_articulo`),
  KEY `id_capitulo` (`id_capitulo`),
  CONSTRAINT `Articulo_Marco_Legal_ibfk_1` FOREIGN KEY (`id_capitulo`) REFERENCES `Capitulo_Marco_Legal` (`id_capitulo`)
) ENGINE=InnoDB AUTO_INCREMENT=536 DEFAULT CHARSET=utf8mb3;

-- Volcando estructura para tabla Proyecto_Marco.Capitulo_Marco_Legal
CREATE TABLE IF NOT EXISTS `Capitulo_Marco_Legal` (
  `id_capitulo` int NOT NULL AUTO_INCREMENT,
  `id_titulo` int NOT NULL,
  `nombre` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`id_capitulo`),
  KEY `id_titulo` (`id_titulo`),
  CONSTRAINT `Capitulo_Marco_Legal_ibfk_1` FOREIGN KEY (`id_titulo`) REFERENCES `Titulo_Marco_Legal` (`id_titulo`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb3;

-- Volcando estructura para tabla Proyecto_Marco.Empresa
CREATE TABLE IF NOT EXISTS `Empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `sector` varchar(50) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `id_estado` int NOT NULL,
  PRIMARY KEY (`id_empresa`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `Empresa_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `Estado` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Volcando estructura para tabla Proyecto_Marco.Empresa_auditor
CREATE TABLE IF NOT EXISTS `Empresa_auditor` (
  `id_empresa_auditor` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `fecha_asignacion` date DEFAULT NULL,
  PRIMARY KEY (`id_empresa_auditor`),
  KEY `id_empresa` (`id_empresa`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `Empresa_auditor_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `Empresa` (`id_empresa`),
  CONSTRAINT `Empresa_auditor_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- Volcando estructura para tabla Proyecto_Marco.Estado
CREATE TABLE IF NOT EXISTS `Estado` (
  `id_estado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla Proyecto_Marco.Estado: ~3 rows (aproximadamente)
INSERT INTO `Estado` (`id_estado`, `nombre`, `descripcion`) VALUES
	(1, 'Activo', 'Representa que el usuario puede ser usado.'),
	(2, 'Inactivo', 'El usuario no puede ser usado.'),
	(3, 'Bloqueado', 'El usuario se encuentra bloqueado.');

-- Volcando estructura para tabla Proyecto_Marco.Estado_Evaluacion
CREATE TABLE IF NOT EXISTS `Estado_Evaluacion` (
  `id_estado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla Proyecto_Marco.Estado_Evaluacion: ~4 rows (aproximadamente)
INSERT INTO `Estado_Evaluacion` (`id_estado`, `nombre`, `descripcion`) VALUES
	(1, 'Cumple', 'El artículo evaluado cumple con lo requerido.'),
	(2, 'No Cumple', 'El artículo evaluado no cumple con lo requerido.'),
	(3, 'Parcial', 'El artículo evaluado cumple parcialmente.'),
	(4, 'N/A', 'El artículo evaluado no aplica.');

-- Volcando estructura para tabla Proyecto_Marco.Evaluacion
CREATE TABLE IF NOT EXISTS `Evaluacion` (
  `id_evaluacion` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `id_marco_legal` int NOT NULL,
  `id_usuario` int NOT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id_evaluacion`),
  KEY `id_empresa` (`id_empresa`),
  KEY `id_marco_legal` (`id_marco_legal`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `Evaluacion_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `Empresa` (`id_empresa`),
  CONSTRAINT `Evaluacion_ibfk_2` FOREIGN KEY (`id_marco_legal`) REFERENCES `Marco_Legal` (`id_marco_legal`),
  CONSTRAINT `Evaluacion_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;

-- Volcando estructura para tabla Proyecto_Marco.Evaluacion_Detalle
CREATE TABLE IF NOT EXISTS `Evaluacion_Detalle` (
  `id_evaluacion_detalle` int NOT NULL AUTO_INCREMENT,
  `id_evaluacion` int NOT NULL,
  `id_articulo` int NOT NULL,
  `id_estado` int NOT NULL,
  `observaciones` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `evidencia` text,
  PRIMARY KEY (`id_evaluacion_detalle`),
  KEY `id_evaluacion` (`id_evaluacion`),
  KEY `id_articulo` (`id_articulo`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `Evaluacion_Detalle_ibfk_1` FOREIGN KEY (`id_evaluacion`) REFERENCES `Evaluacion` (`id_evaluacion`),
  CONSTRAINT `Evaluacion_Detalle_ibfk_2` FOREIGN KEY (`id_articulo`) REFERENCES `Articulo_Marco_Legal` (`id_articulo`),
  CONSTRAINT `Evaluacion_Detalle_ibfk_3` FOREIGN KEY (`id_estado`) REFERENCES `Estado_Evaluacion` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb3;

-- Volcando estructura para tabla Proyecto_Marco.Marco_Legal
CREATE TABLE IF NOT EXISTS `Marco_Legal` (
  `id_marco_legal` int NOT NULL AUTO_INCREMENT,
  `nombre` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `pais_origen` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`id_marco_legal`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Volcando estructura para tabla Proyecto_Marco.Rol
CREATE TABLE IF NOT EXISTS `Rol` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla Proyecto_Marco.Rol: ~4 rows (aproximadamente)
INSERT INTO `Rol` (`id_rol`, `nombre`, `descripcion`) VALUES
	(1, 'Administrador', 'Se encarga de administrar el sistema.'),
	(2, 'Digitador', 'Carga leyes al sistema.'),
	(3, 'Auditor', 'Evalua las leyes.'),
	(4, 'Supervisar', 'Obtiene reportes de evaluaciones.');

-- Volcando estructura para tabla Proyecto_Marco.Titulo_Marco_Legal
CREATE TABLE IF NOT EXISTS `Titulo_Marco_Legal` (
  `id_titulo` int NOT NULL AUTO_INCREMENT,
  `id_marco_legal` int NOT NULL,
  `nombre` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`id_titulo`),
  KEY `id_marco_legal` (`id_marco_legal`),
  CONSTRAINT `Titulo_Marco_Legal_ibfk_1` FOREIGN KEY (`id_marco_legal`) REFERENCES `Marco_Legal` (`id_marco_legal`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3;

-- Volcando estructura para tabla Proyecto_Marco.Usuario
CREATE TABLE IF NOT EXISTS `Usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `uid_firebase` varchar(100) DEFAULT NULL,
  `correo` varchar(50) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `id_rol` int NOT NULL,
  `id_estado` int NOT NULL,
  `verificado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `id_rol` (`id_rol`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `Usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `Rol` (`id_rol`),
  CONSTRAINT `Usuario_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `Estado` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla Proyecto_Marco.Usuario: ~23 rows (aproximadamente)
INSERT INTO `Usuario` (`id_usuario`, `uid_firebase`, `correo`, `nombre`, `id_rol`, `id_estado`, `verificado`) VALUES
	(1, '0XQkE6k6OeT47TWNQn2NC5F3YNU2', 'olopeza8@miumg.edu.gt', 'Oliver', 1, 1, 1),
	(2, 'Rxh1AmZTT6eRlxG1sXn7qqOfh8h1', 'admin@admin.com', 'Administrador', 1, 1, 1),
	(3, 'OZe7DVEXJNOWBIm3g2OjUuGk2Pz2', 'auditor@auditor.com', 'Auditor', 3, 1, 0),
	(4, 'HmYmvmc1LARVM6sIptVPuEpNH9l1', 'digitador@digitador.com', 'Digitador', 2, 1, 0),
	(5, 'IWhkggR3UpNZBQJZnEtJG3udjYB3', 'supervisor@supervisor.com', 'Supervisor', 4, 1, 0);

-- Volcando estructura para procedimiento Proyecto_Marco.GetEvaluacionesEmpresa
DELIMITER //
CREATE PROCEDURE GetEvaluacionesEmpresa(
	IN p_id_empresa INT
)
BEGIN
    SELECT 
        e.id_evaluacion,
        ml.nombre AS marco_legal,
        e.fecha,
        u.nombre AS usuario,
        ROUND(
            (SUM(
                CASE 
                    WHEN ed.id_estado = 1 THEN 100
                    WHEN ed.id_estado = 2 THEN 0
                    WHEN ed.id_estado = 3 THEN 50
                    ELSE NULL
                END
            ) / COUNT(CASE WHEN ed.id_estado <> 4 THEN 1 END)),2
        ) AS porcentaje_cumplimiento
    FROM Evaluacion e
    INNER JOIN Marco_Legal ml ON e.id_marco_legal = ml.id_marco_legal
    INNER JOIN Usuario u ON e.id_usuario = u.id_usuario
    INNER JOIN Evaluacion_Detalle ed ON e.id_evaluacion = ed.id_evaluacion
    WHERE e.id_empresa = p_id_empresa
      AND ed.id_estado <> 4
    GROUP BY e.id_evaluacion, ml.nombre, e.fecha, u.nombre
    ORDER BY e.id_evaluacion DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ActualizarArticulo
DELIMITER //
CREATE PROCEDURE SP_ActualizarArticulo(IN p_id_articulo INT, IN p_numero VARCHAR(8), IN p_nombre VARCHAR(50), IN p_descripcion VARCHAR(100), IN p_aplicable INT)
BEGIN
  UPDATE Articulo_Marco_Legal SET numero = p_numero, nombre = p_nombre, descripcion = p_descripcion, aplicable = p_aplicable
  WHERE id_articulo = p_id_articulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ActualizarCapitulo
DELIMITER //
CREATE PROCEDURE SP_ActualizarCapitulo(IN p_id_capitulo INT, IN p_nombre VARCHAR(50))
BEGIN
  UPDATE Capitulo_Marco_Legal SET nombre = p_nombre WHERE id_capitulo = p_id_capitulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ActualizarEmpresa
DELIMITER //
CREATE PROCEDURE SP_ActualizarEmpresa(IN p_id_empresa int, p_nombre VARCHAR(50), p_sector VARCHAR(50), p_pais VARCHAR(50))
BEGIN
UPDATE Empresa
SET
  nombre = p_nombre,
  sector = p_sector,
  pais = p_pais
WHERE id_empresa = p_id_empresa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ActualizarEmpresaAuditor
DELIMITER //
CREATE PROCEDURE SP_ActualizarEmpresaAuditor(IN p_id_empresa_auditor INT, IN p_id_empresa INT, IN p_id_usuario INT, IN p_fecha DATE)
BEGIN
  UPDATE Empresa_auditor 
  SET id_empresa = p_id_empresa, id_usuario = p_id_usuario, fecha_asignacion = p_fecha
  WHERE id_empresa_auditor = p_id_empresa_auditor;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ActualizarEvaluacion
DELIMITER //
CREATE PROCEDURE SP_ActualizarEvaluacion(IN p_id_evaluacion INT, IN p_id_empresa INT, IN p_id_marco_legal INT, IN p_id_usuario INT, IN p_fecha DATE)
BEGIN
  UPDATE Evaluacion 
  SET id_empresa = p_id_empresa, id_marco_legal = p_id_marco_legal, id_usuario = p_id_usuario, fecha = p_fecha
  WHERE id_evaluacion = p_id_evaluacion;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ActualizarEvaluacionDetalle
DELIMITER //
CREATE PROCEDURE SP_ActualizarEvaluacionDetalle(IN p_id_evaluacion_detalle INT, IN p_id_estado INT, IN p_observaciones VARCHAR(100))
BEGIN
  UPDATE Evaluacion_Detalle 
  SET id_estado = p_id_estado, observaciones = p_observaciones
  WHERE id_evaluacion_detalle = p_id_evaluacion_detalle;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ActualizarMarcoLegal
DELIMITER //
CREATE PROCEDURE SP_ActualizarMarcoLegal(IN p_id_marco_legal INT, IN p_nombre VARCHAR(100), IN p_pais_origen VARCHAR(50), IN p_descripcion VARCHAR(100))
BEGIN
  UPDATE Marco_Legal 
  SET nombre = p_nombre, pais_origen = p_pais_origen, descripcion = p_descripcion
  WHERE id_marco_legal = p_id_marco_legal;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ActualizarTitulo
DELIMITER //
CREATE PROCEDURE SP_ActualizarTitulo(IN p_id_titulo INT, IN p_nombre VARCHAR(50))
BEGIN
  UPDATE Titulo_Marco_Legal SET nombre = p_nombre WHERE id_titulo = p_id_titulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ActualizarUsuario
DELIMITER //
CREATE PROCEDURE SP_ActualizarUsuario(IN p_id_usuario int, p_correo varchar(50), p_nombre varchar(50), p_id_rol int )
BEGIN
  UPDATE Usuario 
  SET correo = p_correo,
  nombre = p_nombre,
  id_rol = p_id_rol
  WHERE id_usuario = p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarArticulo
DELIMITER //
CREATE PROCEDURE SP_ConsultarArticulo(IN p_id_articulo INT)
BEGIN
  SELECT * FROM Articulo_Marco_Legal WHERE id_articulo = p_id_articulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarArticulos
DELIMITER //
CREATE PROCEDURE SP_ConsultarArticulos(IN p_id_capitulo INT)
BEGIN
  SELECT * FROM Articulo_Marco_Legal WHERE id_capitulo = p_id_capitulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarAuditores
DELIMITER //
CREATE PROCEDURE SP_ConsultarAuditores()
BEGIN
  SELECT id_usuario, nombre
  FROM Usuario
  WHERE id_rol = 3 AND id_estado = 1;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarAuditoresEmpresa
DELIMITER //
CREATE PROCEDURE SP_ConsultarAuditoresEmpresa(IN p_id_empresa int)
BEGIN
	SELECT a.id_usuario, a.nombre, b.fecha_asignacion
		FROM Usuario a
  		INNER JOIN Empresa_auditor b ON b.id_usuario = a.id_usuario
  		WHERE b.id_empresa = p_id_empresa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarCapitulo
DELIMITER //
CREATE PROCEDURE SP_ConsultarCapitulo(IN p_id_capitulo INT)
BEGIN
  SELECT * FROM Capitulo_Marco_Legal WHERE id_capitulo = p_id_capitulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarCapitulos
DELIMITER //
CREATE PROCEDURE SP_ConsultarCapitulos(IN p_id_titulo INT)
BEGIN
  SELECT * FROM Capitulo_Marco_Legal WHERE id_titulo = p_id_titulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarEmpresa
DELIMITER //
CREATE PROCEDURE SP_ConsultarEmpresa(IN p_id_empresa int)
BEGIN
SELECT nombre, sector, pais, id_estado
FROM Empresa
WHERE id_empresa = p_id_empresa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarEmpresaAuditor
DELIMITER //
CREATE PROCEDURE SP_ConsultarEmpresaAuditor(IN p_id_empresa_auditor INT)
BEGIN
  SELECT * FROM Empresa_auditor WHERE id_empresa_auditor = p_id_empresa_auditor;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarEmpresas
DELIMITER //
CREATE PROCEDURE SP_ConsultarEmpresas()
BEGIN
SELECT id_empresa, nombre, sector, pais, id_estado
FROM Empresa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarEmpresasAuditor
DELIMITER //
CREATE PROCEDURE SP_ConsultarEmpresasAuditor(IN p_id_usuario INT)
BEGIN
  SELECT * FROM Empresa_auditor WHERE id_usuario = p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarEvaluacion
DELIMITER //
CREATE PROCEDURE SP_ConsultarEvaluacion(IN p_id_evaluacion INT)
BEGIN
  SELECT * FROM Evaluacion WHERE id_evaluacion = p_id_evaluacion;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarEvaluacionDetalle
DELIMITER //
CREATE PROCEDURE SP_ConsultarEvaluacionDetalle(IN p_id_evaluacion_detalle INT)
BEGIN
  SELECT * FROM Evaluacion_Detalle WHERE id_evaluacion_detalle = p_id_evaluacion_detalle;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarEvaluacionDetalles
DELIMITER //
CREATE PROCEDURE SP_ConsultarEvaluacionDetalles(IN p_id_evaluacion INT)
BEGIN
  SELECT * FROM Evaluacion_Detalle WHERE id_evaluacion = p_id_evaluacion;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarEvaluaciones
DELIMITER //
CREATE PROCEDURE SP_ConsultarEvaluaciones()
BEGIN
  SELECT * FROM Evaluacion;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarEvaluacionesPorEmpresa
DELIMITER //
CREATE PROCEDURE SP_ConsultarEvaluacionesPorEmpresa(IN p_id_empresa INT)
BEGIN
  SELECT * FROM Evaluacion WHERE id_empresa = p_id_empresa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarMarcoLegal
DELIMITER //
CREATE PROCEDURE SP_ConsultarMarcoLegal(IN p_id_marco_legal INT)
BEGIN
  SELECT * FROM Marco_Legal WHERE id_marco_legal = p_id_marco_legal;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarMarcoLegalDetalle
DELIMITER //
CREATE PROCEDURE SP_ConsultarMarcoLegalDetalle(
    IN p_id_marco_legal INT
)
BEGIN
    -- Información del marco legal
    SELECT 
        ml.id_marco_legal,
        ml.nombre,
        ml.descripcion,
        ml.pais_origen
    FROM Marco_Legal ml
    WHERE ml.id_marco_legal = p_id_marco_legal;

    -- Títulos del marco legal
    SELECT 
        t.id_titulo,
        t.nombre,
        t.id_marco_legal
    FROM Titulo_Marco_Legal t
    WHERE t.id_marco_legal = p_id_marco_legal;

    -- Capítulos asociados a los títulos de ese marco legal
    SELECT 
        c.id_capitulo,
        c.nombre,
        c.id_titulo
    FROM Capitulo_Marco_Legal c
    INNER JOIN Titulo_Marco_Legal t ON c.id_titulo = t.id_titulo
    WHERE t.id_marco_legal = p_id_marco_legal;

    -- Artículos asociados a los capítulos
    SELECT 
        a.id_articulo,
        a.numero,
        a.nombre,
        a.descripcion,
        a.aplicable,
        a.id_capitulo
    FROM Articulo_Marco_Legal a
    INNER JOIN Capitulo_Marco_Legal c ON a.id_capitulo = c.id_capitulo
    INNER JOIN Titulo_Marco_Legal t ON c.id_titulo = t.id_titulo
    WHERE t.id_marco_legal = p_id_marco_legal;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarMarcosLegales
DELIMITER //
CREATE PROCEDURE SP_ConsultarMarcosLegales()
BEGIN
  SELECT * FROM Marco_Legal;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarTitulo
DELIMITER //
CREATE PROCEDURE SP_ConsultarTitulo(IN p_id_titulo INT)
BEGIN
  SELECT * FROM Titulo_Marco_Legal WHERE id_titulo = p_id_titulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarTitulos
DELIMITER //
CREATE PROCEDURE SP_ConsultarTitulos(IN p_id_marco_legal INT)
BEGIN
  SELECT * FROM Titulo_Marco_Legal WHERE id_marco_legal = p_id_marco_legal;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarUsuario
DELIMITER //
CREATE PROCEDURE SP_ConsultarUsuario(IN p_id_usuario int)
BEGIN
  SELECT uid_firebase, nombre, correo, id_rol, id_estado, verificado
  FROM Usuario
  WHERE id_usuario = p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarUsuarioFirebase
DELIMITER //
CREATE PROCEDURE SP_ConsultarUsuarioFirebase(IN puid_firebase VARCHAR(100))
BEGIN
  SELECT id_usuario, uid_firebase, nombre, correo, id_rol, id_estado, verificado
  FROM Usuario
  WHERE uid_firebase = puid_firebase;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ConsultarUsuarios
DELIMITER //
CREATE PROCEDURE SP_ConsultarUsuarios()
BEGIN
  SELECT a.id_usuario, a.uid_firebase AS uid, a.nombre, a.correo, a.id_rol, b.nombre AS rol, a.id_estado, c.nombre AS estado, a.verificado
  FROM Usuario a
  INNER JOIN Rol b ON b.id_rol = a.id_rol
  INNER JOIN Estado c ON c.id_estado = a.id_estado;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarArticulo
DELIMITER //
CREATE PROCEDURE SP_EliminarArticulo(IN p_id_articulo INT)
BEGIN
  DELETE FROM Articulo_Marco_Legal WHERE id_articulo = p_id_articulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarCapitulo
DELIMITER //
CREATE PROCEDURE SP_EliminarCapitulo(IN p_id_capitulo INT)
BEGIN
  DELETE FROM Capitulo_Marco_Legal WHERE id_capitulo = p_id_capitulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarEmpresa
DELIMITER //
CREATE PROCEDURE SP_EliminarEmpresa(IN p_id_empresa int)
BEGIN
UPDATE Empresa 
  SET id_estado = 2
  WHERE id_empresa = p_id_empresa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarEmpresaAuditor
DELIMITER //
CREATE PROCEDURE SP_EliminarEmpresaAuditor(IN p_id_empresa_auditor INT)
BEGIN
  DELETE FROM Empresa_auditor WHERE id_empresa_auditor = p_id_empresa_auditor;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarEvaluacion
DELIMITER //
CREATE PROCEDURE SP_EliminarEvaluacion(IN p_id_evaluacion INT)
BEGIN
  DELETE FROM Evaluacion WHERE id_evaluacion = p_id_evaluacion;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarEvaluacionDetalle
DELIMITER //
CREATE PROCEDURE SP_EliminarEvaluacionDetalle(IN p_id_evaluacion_detalle INT)
BEGIN
  DELETE FROM Evaluacion_Detalle WHERE id_evaluacion_detalle = p_id_evaluacion_detalle;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarMarcoLegal
DELIMITER //
CREATE PROCEDURE SP_EliminarMarcoLegal(IN p_id_marco_legal INT)
BEGIN
  DELETE FROM Marco_Legal WHERE id_marco_legal = p_id_marco_legal;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarMarcoLegalCompleto
DELIMITER //
CREATE PROCEDURE SP_EliminarMarcoLegalCompleto(IN p_id_marco_legal INT)
BEGIN
    DECLARE v_count INT;

    -- Verificar si el marco legal ya fue utilizado en alguna evaluación
    SELECT COUNT(*) INTO v_count
    FROM Evaluacion
    WHERE id_marco_legal = p_id_marco_legal;

    IF v_count > 0 THEN
        -- Retornar mensaje si ya fue utilizado
        SELECT CONCAT('El marco legal con ID ', p_id_marco_legal, 
                      ' ya se evaluó en una empresa y no puede ser eliminado.') AS mensaje;
    ELSE
        -- Eliminar primero los artículos
        DELETE A
        FROM Articulo_Marco_Legal A
        INNER JOIN Capitulo_Marco_Legal C ON A.id_capitulo = C.id_capitulo
        INNER JOIN Titulo_Marco_Legal T ON C.id_titulo = T.id_titulo
        WHERE T.id_marco_legal = p_id_marco_legal;

        -- Eliminar capítulos
        DELETE C
        FROM Capitulo_Marco_Legal C
        INNER JOIN Titulo_Marco_Legal T ON C.id_titulo = T.id_titulo
        WHERE T.id_marco_legal = p_id_marco_legal;

        -- Eliminar títulos
        DELETE FROM Titulo_Marco_Legal
        WHERE id_marco_legal = p_id_marco_legal;

        -- Finalmente eliminar el marco legal
        DELETE FROM Marco_Legal
        WHERE id_marco_legal = p_id_marco_legal;

        -- Confirmación
        SELECT CONCAT('El marco legal con ID ', p_id_marco_legal, ' fue eliminado correctamente.') AS mensaje;
    END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarTitulo
DELIMITER //
CREATE PROCEDURE SP_EliminarTitulo(IN p_id_titulo INT)
BEGIN
  DELETE FROM Titulo_Marco_Legal WHERE id_titulo = p_id_titulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_EliminarUsuario
DELIMITER //
CREATE PROCEDURE SP_EliminarUsuario(IN p_id_usuario int)
BEGIN
  UPDATE Usuario 
  SET id_estado = 2
  WHERE id_usuario = p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_HabilitarEmpresa
DELIMITER //
CREATE PROCEDURE SP_HabilitarEmpresa(IN p_id_empresa int)
BEGIN
UPDATE Empresa 
  SET id_estado = 1
  WHERE id_empresa = p_id_empresa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_HabilitarUsuario
DELIMITER //
CREATE PROCEDURE SP_HabilitarUsuario(IN p_id_usuario int)
BEGIN
  UPDATE Usuario 
  SET id_estado = 1
  WHERE id_usuario = p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_informe_evaluacion
DELIMITER //
CREATE PROCEDURE SP_informe_evaluacion(IN p_id_evaluacion INT)
BEGIN
    SELECT 
        ml.id_marco_legal,
        ml.nombre AS marco_legal,
        ml.descripcion AS descripcion_marco,
        ml.pais_origen,
        
        tml.id_titulo,
        tml.nombre AS titulo,
        
        cml.id_capitulo,
        cml.nombre AS capitulo,
        
        aml.id_articulo,
        aml.numero AS numero_articulo,
        aml.nombre AS nombre_articulo,
        aml.descripcion AS descripcion_articulo,
        aml.aplicable,
        
        ee.id_estado,
        ee.nombre AS estado,
        ee.descripcion AS descripcion_estado,
        
        ed.observaciones,
        ed.evidencia
        
    FROM Evaluacion e
    INNER JOIN Marco_Legal ml 
        ON e.id_marco_legal = ml.id_marco_legal
    INNER JOIN Evaluacion_Detalle ed 
        ON e.id_evaluacion = ed.id_evaluacion
    INNER JOIN Articulo_Marco_Legal aml 
        ON ed.id_articulo = aml.id_articulo
    INNER JOIN Capitulo_Marco_Legal cml 
        ON aml.id_capitulo = cml.id_capitulo
    INNER JOIN Titulo_Marco_Legal tml 
        ON cml.id_titulo = tml.id_titulo
    INNER JOIN Estado_Evaluacion ee 
        ON ed.id_estado = ee.id_estado
    WHERE e.id_evaluacion = p_id_evaluacion
    ORDER BY tml.id_titulo, cml.id_capitulo, aml.id_articulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_RegistrarArticulo
DELIMITER //
CREATE PROCEDURE SP_RegistrarArticulo(
	IN `p_id_capitulo` INT,
	IN `p_numero` VARCHAR(8),
	IN `p_nombre` TEXT,
	IN `p_descripcion` TEXT,
	IN `p_aplicable` INT
)
BEGIN
  INSERT INTO Articulo_Marco_Legal(id_capitulo, numero, nombre, descripcion, aplicable) VALUES(p_id_capitulo, p_numero, p_nombre, p_descripcion, p_aplicable);
  SELECT LAST_INSERT_ID() AS id_articulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_RegistrarCapitulo
DELIMITER //
CREATE PROCEDURE SP_RegistrarCapitulo(
	IN `p_id_titulo` INT,
	IN `p_nombre` TEXT
)
BEGIN
  INSERT INTO Capitulo_Marco_Legal(id_titulo, nombre) VALUES(p_id_titulo, p_nombre);
  SELECT LAST_INSERT_ID() AS id_capitulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_RegistrarEmpresa
DELIMITER //
CREATE PROCEDURE SP_RegistrarEmpresa(IN p_nombre VARCHAR(50), p_sector VARCHAR(50), p_pais VARCHAR(50))
BEGIN
INSERT INTO Empresa(nombre, sector, pais, id_estado) VALUES (p_nombre, p_sector, p_pais, 1);
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_RegistrarEmpresaAuditor
DELIMITER //
CREATE PROCEDURE SP_RegistrarEmpresaAuditor(IN p_id_empresa int, p_id_usuario int)
BEGIN
INSERT INTO Empresa_auditor(id_empresa, id_usuario, fecha_asignacion) VALUES(p_id_empresa, p_id_usuario, CURDATE());
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_RegistrarEvaluacion
DELIMITER //
CREATE PROCEDURE SP_RegistrarEvaluacion(IN p_id_empresa INT, IN p_id_marco_legal INT, IN p_id_usuario INT)
BEGIN
  INSERT INTO Evaluacion(id_empresa, id_marco_legal, id_usuario, fecha)
  VALUES(p_id_empresa, p_id_marco_legal, p_id_usuario, CURDATE());
  SELECT LAST_INSERT_ID() AS id_evaluacion;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_RegistrarEvaluacionDetalle
DELIMITER //
CREATE PROCEDURE SP_RegistrarEvaluacionDetalle(
	IN `p_id_evaluacion` INT,
	IN `p_id_articulo` INT,
	IN `p_id_estado` INT,
	IN `p_observaciones` TEXT,
	IN `p_evidencia` TEXT
)
BEGIN
  INSERT INTO Evaluacion_Detalle(id_evaluacion, id_articulo, id_estado, observaciones, evidencia)
  VALUES(p_id_evaluacion, p_id_articulo, p_id_estado, p_observaciones, p_evidencia);
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_RegistrarMarcoLegal
DELIMITER //
CREATE PROCEDURE SP_RegistrarMarcoLegal(
	IN `p_nombre` TEXT,
	IN `p_pais_origen` VARCHAR(100),
	IN `p_descripcion` TEXT
)
BEGIN
  INSERT INTO Marco_Legal(nombre, pais_origen, descripcion) VALUES(p_nombre, p_pais_origen, p_descripcion);
  -- Retornar el ID insertado
  SELECT LAST_INSERT_ID() AS id_marco_legal;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_RegistrarTitulo
DELIMITER //
CREATE PROCEDURE SP_RegistrarTitulo(
	IN `p_id_marco_legal` INT,
	IN `p_nombre` TEXT
)
BEGIN
  INSERT INTO Titulo_Marco_Legal(id_marco_legal, nombre) VALUES(p_id_marco_legal, p_nombre);
  SELECT LAST_INSERT_ID() AS id_titulo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_RegistrarUsuario
DELIMITER //
CREATE PROCEDURE SP_RegistrarUsuario(IN p_uid_firebase varchar(100), p_correo varchar(50), p_nombre varchar(50),
  p_id_rol int)
BEGIN
  INSERT INTO Usuario(uid_firebase, correo, nombre, id_rol, id_estado, verificado)
    VALUES (p_uid_firebase, p_correo, p_nombre, p_id_rol, 1, false);
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.SP_ResumenEvaluacionEspecifica
DELIMITER //
CREATE PROCEDURE SP_ResumenEvaluacionEspecifica(IN p_id_evaluacion INT)
BEGIN
    SELECT 
        e.id_evaluacion,
        emp.nombre AS empresa,
        ml.nombre AS marco_legal,
        u.nombre AS usuario_auditor,
        
        -- Cantidades
        SUM(CASE WHEN ed.id_estado = 1 THEN 1 ELSE 0 END) AS cantidad_cumple,
        SUM(CASE WHEN ed.id_estado = 2 THEN 1 ELSE 0 END) AS cantidad_no_cumple,
        SUM(CASE WHEN ed.id_estado = 3 THEN 1 ELSE 0 END) AS cantidad_cumple_parcial,
        SUM(CASE WHEN ed.id_estado = 4 THEN 1 ELSE 0 END) AS cantidad_no_aplica,

        -- % de Cumple
        ROUND(SUM(CASE WHEN ed.id_estado = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS porcentaje_cumple,
        
        -- % de No Cumple
        ROUND(SUM(CASE WHEN ed.id_estado = 2 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS porcentaje_no_cumple,
        
        -- % de Cumple Parcialmente
        ROUND(SUM(CASE WHEN ed.id_estado = 3 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS porcentaje_cumple_parcial,
        
        -- % de No Aplica
        ROUND(SUM(CASE WHEN ed.id_estado = 4 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS porcentaje_no_aplica,
        
        -- Porcentaje Global de Cumplimiento (solo considera 1,2,3)
        ROUND(
            (SUM(
                CASE 
                    WHEN ed.id_estado = 1 THEN 100
                    WHEN ed.id_estado = 2 THEN 0
                    WHEN ed.id_estado = 3 THEN 50
                    ELSE NULL
                END
            ) / COUNT(CASE WHEN ed.id_estado <> 4 THEN 1 END)),2
        ) AS porcentaje_cumplimiento
        
    FROM Evaluacion e
    INNER JOIN Empresa emp ON e.id_empresa = emp.id_empresa
    INNER JOIN Marco_Legal ml ON e.id_marco_legal = ml.id_marco_legal
    INNER JOIN Evaluacion_Detalle ed ON e.id_evaluacion = ed.id_evaluacion
    INNER JOIN Empresa_auditor ea ON emp.id_empresa = ea.id_empresa
    INNER JOIN Usuario u ON e.id_usuario = u.id_usuario
    
    WHERE e.id_evaluacion = p_id_evaluacion
    GROUP BY e.id_evaluacion, emp.nombre, ml.nombre, u.nombre;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.sp_resumen_cumplimiento
DELIMITER //
CREATE PROCEDURE sp_resumen_cumplimiento(IN modo VARCHAR(10))
BEGIN
    -- Tabla temporal para trabajar
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_eval (
        id_evaluacion INT PRIMARY KEY
    );

    TRUNCATE tmp_eval;

    -- Si el modo es 'ULTIMAS' → seleccionar las 5 más recientes
    IF modo = 'ULTIMAS' THEN
        INSERT INTO tmp_eval (id_evaluacion)
        SELECT id_evaluacion
        FROM Evaluacion
        ORDER BY fecha DESC, id_evaluacion DESC
        LIMIT 5;
    ELSE
        -- Si es 'TODAS' → seleccionar todas
        INSERT INTO tmp_eval (id_evaluacion)
        SELECT id_evaluacion
        FROM Evaluacion;
    END IF;

    -- Calcular los porcentajes por cada evaluación seleccionada
    SELECT 
        e.id_evaluacion,
        emp.nombre AS empresa,
        ml.nombre AS marco_legal,
        e.fecha,
        COUNT(CASE WHEN ed.id_estado = 1 THEN 1 END) AS total_cumple,
        COUNT(CASE WHEN ed.id_estado = 2 THEN 1 END) AS total_no_cumple,
        COUNT(CASE WHEN ed.id_estado = 3 THEN 1 END) AS total_cumple_parcial,
        COUNT(*) AS total_articulos,
        ROUND( (COUNT(CASE WHEN ed.id_estado = 1 THEN 1 END) / COUNT(*)) * 100, 2) AS pct_cumple,
        ROUND( (COUNT(CASE WHEN ed.id_estado = 2 THEN 1 END) / COUNT(*)) * 100, 2) AS pct_no_cumple,
        ROUND( (COUNT(CASE WHEN ed.id_estado = 3 THEN 1 END) / COUNT(*)) * 100, 2) AS pct_cumple_parcial
    FROM Evaluacion e
    INNER JOIN tmp_eval t ON e.id_evaluacion = t.id_evaluacion
    INNER JOIN Empresa emp ON e.id_empresa = emp.id_empresa
    INNER JOIN Marco_Legal ml ON e.id_marco_legal = ml.id_marco_legal
    INNER JOIN Evaluacion_Detalle ed ON e.id_evaluacion = ed.id_evaluacion
    GROUP BY e.id_evaluacion, emp.nombre, ml.nombre, e.fecha
    ORDER BY e.fecha DESC;

    DROP TEMPORARY TABLE IF EXISTS tmp_eval;
END//
DELIMITER ;

-- Volcando estructura para procedimiento Proyecto_Marco.sp_resumen_dashboard1
DELIMITER //
CREATE PROCEDURE sp_resumen_dashboard1()
BEGIN
    DECLARE totalUsuarios INT DEFAULT 0;
    DECLARE totalAuditores INT DEFAULT 0;
    DECLARE totalEmpresasActivas INT DEFAULT 0;
    DECLARE totalMarcosLegales INT DEFAULT 0;

    -- Total de usuarios
    SELECT COUNT(*) INTO totalUsuarios
    FROM Usuario;

    -- Total de auditores (rol = 3)
    SELECT COUNT(*) INTO totalAuditores
    FROM Usuario
    WHERE id_rol = 3;

    -- Total de empresas activas (estado = 1)
    SELECT COUNT(*) INTO totalEmpresasActivas
    FROM Empresa
    WHERE id_estado = 1;

    -- Total de marcos legales con al menos un título
    SELECT COUNT(DISTINCT ML.id_marco_legal) INTO totalMarcosLegales
    FROM Marco_Legal ML
    INNER JOIN Titulo_Marco_Legal TL ON ML.id_marco_legal = TL.id_marco_legal;

    -- Retornar los resultados
    SELECT 
        IFNULL(totalUsuarios, 0) AS total_usuarios,
        IFNULL(totalAuditores, 0) AS total_auditores,
        IFNULL(totalEmpresasActivas, 0) AS total_empresas_activas,
        IFNULL(totalMarcosLegales, 0) AS total_marcos_legales;
END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
