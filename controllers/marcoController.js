const connection = require('../config/db');

// Registrar Marco Legal con Títulos, Capítulos y Artículos
const registrarMarcoLegal = async (req, res) => {
  const { nombre, pais_origen, descripcion, titulos } = req.body;

  try {
    await connection.beginTransaction();

    // 1. Insertar Marco Legal
    const [marcoRes] = await connection.query(
      `CALL SP_RegistrarMarcoLegal(?, ?, ?);`,
      [nombre, pais_origen, descripcion]
    );
    const idMarco = marcoRes[0][0].id_marco_legal;

    // 2. Ciclo de títulos
    for (const titulo of titulos) {
      const [tituloRes] = await connection.query(
        `CALL SP_RegistrarTitulo(?, ?);`,
        [idMarco, titulo.nombre]
      );
      const idTitulo = tituloRes[0][0].id_titulo;

      // 3. Ciclo de capítulos dentro de cada título
      for (const capitulo of titulo.capitulos) {
        const [capRes] = await connection.query(
          `CALL SP_RegistrarCapitulo(?, ?);`,
          [idTitulo, capitulo.nombre]
        );
        const idCapitulo = capRes[0][0].id_capitulo;

        // 4. Ciclo de artículos dentro de cada capítulo
        for (const articulo of capitulo.articulos) {
          await connection.query(
            `CALL SP_RegistrarArticulo(?, ?, ?, ?, ?);`,
            [
              idCapitulo,
              articulo.numero,
              articulo.nombre,
              articulo.descripcion,
              articulo.aplicable
            ]
          );
        }
      }
    }

    await connection.commit();
    res.json({
      success: true,
      message: 'Marco legal y jerarquía registrados correctamente',
      idMarco
    });

  } catch (err) {
    await connection.rollback();
    console.error('Error en registrarMarcoLegal:', err);
    res.status(500).json({
      success: false,
      message: 'Error al registrar marco legal',
      error: err.message
    });
  } finally {
    //onnection.release();
    console.log('Conexión liberada');
  }
};

// Obtener todos los marcos legales
const obtenerMarcosLegales = async (req, res) => {
  try {
    const [rows] = await connection.query('CALL SP_ConsultarMarcosLegales()');
    const data = rows[0];

    res.status(200).json({
      success: true,
      data: data
    });

  } catch (error) {
    console.error('Error al obtener marcos legales:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener marcos legales',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Controlador para obtener un marco legal completo
const obtenerDetalleMarcoLegal = async (req, res) => {
  try {
    const { id_marco_legal } = req.params;

    const [results] = await connection.query('CALL SP_ConsultarMarcoLegalDetalle(?)', [id_marco_legal]);

    const marcoLegal = results[0][0]; // Solo un registro
    const titulos = results[1];
    const capitulos = results[2];
    const articulos = results[3];

    if (!marcoLegal) {
      return res.status(404).json({
        success: false,
        message: 'Marco legal no encontrado'
      });
    }

    // Construir el JSON anidado
    const detalle = {
      id_marco_legal: marcoLegal.id_marco_legal,
      nombre: marcoLegal.nombre,
      descripcion: marcoLegal.descripcion,
      pais_origen: marcoLegal.pais_origen,
      titulos: titulos.map(titulo => ({
        id_titulo: titulo.id_titulo,
        nombre: titulo.nombre,
        capitulos: capitulos
          .filter(cap => cap.id_titulo === titulo.id_titulo)
          .map(capitulo => ({
            id_capitulo: capitulo.id_capitulo,
            nombre: capitulo.nombre,
            articulos: articulos
              .filter(art => art.id_capitulo === capitulo.id_capitulo)
              .map(articulo => ({
                id_articulo: articulo.id_articulo,
                numero: articulo.numero,
                nombre: articulo.nombre,
                descripcion: articulo.descripcion,
                aplicable: articulo.aplicable
              }))
          }))
      }))
    };

    res.status(200).json({
      success: true,
      data: detalle
    });

  } catch (error) {
    console.error('Error al obtener detalle de marco legal:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener detalle de marco legal',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};

// Eliminar Marco Legal
const eliminarMarcoLegal = async (req, res) => {
  try {
    const { id_marco_legal } = req.params;

    // Ejecutar el SP de eliminación
    const [result] = await connection.query(
      'CALL SP_EliminarMarcoLegalCompleto(?);',
      [id_marco_legal]
    );

    // El SP retorna un SELECT con el mensaje, lo capturamos
    const mensaje = result[0][0]?.mensaje || 'Operación completada';

    res.status(200).json({
      success: true,
      message: mensaje
    });

  } catch (error) {
    console.error('Error al eliminar marco legal:', error);
    res.status(500).json({
      success: false,
      message: 'Error al eliminar marco legal',
      error: process.env.NODE_ENV === 'local' ? error.message : undefined
    });
  }
};


module.exports = {
  registrarMarcoLegal,
  obtenerMarcosLegales,
  obtenerDetalleMarcoLegal,
  eliminarMarcoLegal
};
