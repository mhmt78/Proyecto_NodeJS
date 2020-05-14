const express = require('express')
const aplicacion = express()
const mysql = require('mysql')
const bodyParser = require('body-parser')

var pool = mysql.createPool({
  connectionLimit: 20,
  host: 'localhost',
  user: 'root',
  password: "",
  database: 'blogviajes'
})

aplicacion.use(bodyParser.json())
aplicacion.use(bodyParser.urlencoded({ extended: true }))

aplicacion.get('/api/v1/publicaciones/', function(peticion, respuesta) {
  pool.getConnection(function(err, connection) {
  let query
  const busqueda = (peticion.query.busqueda) ? peticion.query.busqueda : ""
  if (busqueda == "") {
  query = `SELECT * FROM publicaciones`
  } else {
  query = ` SELECT * FROM publicaciones WHERE
  titulo LIKE '%${busqueda}%' OR
  resumen LIKE '%${busqueda}%' OR
  contenido LIKE '%${busqueda}%'
  `
  }
  connection.query(query, function(error, filas, campos) {
  if (filas.length > 0) {
  respuesta.json({ data: filas })
  } else {
  respuesta.status(404)
  respuesta.send({ errors: ["No se encuentra esa publicacion"] })
  }
  })
  connection.release()
  })
  })

aplicacion.get('/api/v1/publicaciones/:id', function (peticion, respuesta) {

  pool.getConnection(function(err, connection) {

    const query = `SELECT * FROM publicaciones WHERE id=${connection.escape(peticion.params.id)}`
    connection.query(query, function (error, filas, campos) {
      if (filas.length > 0){
        respuesta.json({data: filas[0]})
      }
      else{
        respuesta.status(404)
        respuesta.send({errors: ["No se encuentra esa tarea"]})
      }

    })
    connection.release()

  })

})

aplicacion.listen(8080, function(){
  console.log("Servidor iniciado")
})

