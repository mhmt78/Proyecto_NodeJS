const express = require('express')
const aplicacion = express()
const mysql = require('mysql')
const bodyParser = require('body-parser')
const flash = require('express-flash')
const session = require('express-session')
aplicacion.use(session({ secret: 'token-muy-secreto', resave: true, saveUninitialized: true }));
aplicacion.use(flash())

var pool = mysql.createPool({
  connectionLimit: 20,
  host: 'localhost',
  user: 'root',
  password: "",
  database: 'blogviajes'
})

aplicacion.use(bodyParser.json())
aplicacion.use(bodyParser.urlencoded({ extended: true }))

aplicacion.get('/', function(peticion, respuesta){
  pool.getConnection(function(err, connection){

  })
})

// GET /api/v1/publicaciones
// GET /api/v1/publicaciones?busqueda=<palabra>
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

//GET /api/v1/publicaciones/<id>
aplicacion.get('/api/v1/publicaciones/:id', function (peticion, respuesta) {
  pool.getConnection(function(err, connection) {
    const query = `SELECT * FROM publicaciones WHERE id=${connection.escape(peticion.params.id)}`
    connection.query(query, function (error, filas, campos) {
      if (filas.length > 0){
        respuesta.json({data: filas[0]})
      }
      else{
        respuesta.status(404)
        respuesta.send({errors: ["No se encuentra esa publicación"]})
      }
    })
    connection.release()
  })
})

//GET /api/v1/autores
aplicacion.get('/api/V1/autores', function (peticion, respuesta) {
  pool.getConnection(function(err, connection) {
    const query = `SELECT * FROM autores`
    connection.query(query, function (error, filas, campos) {
      respuesta.json({data: filas})
    })
    connection.release()
  })
})

// GET /api/v1/autores/<id>
aplicacion.get('/api/v1/autores/:id', function (peticion, respuesta) {
  pool.getConnection(function(err, connection) {
    const query = `SELECT * FROM autores WHERE id=${connection.escape(peticion.params.id)}`
    connection.query(query, function (error, filas, campos) {
      if (filas.length > 0){
        respuesta.json({data: filas[0]})
      }
      else{
        respuesta.status(404)
        respuesta.send({errors: ["No se encuentra el autor"]})
      }
    })
    connection.release()
  })
})

// POST /api/v1/autores
aplicacion.post('/api/v1/autores', function (peticion, respuesta) {
  pool.getConnection(function(err, connection) {
    const email = peticion.body.email.toLowerCase().trim()
    const pseudonimo = peticion.body.pseudonimo.trim()
    const contrasena = peticion.body.contrasena

    const consultaEmail = `
      SELECT *
      FROM autores
      WHERE email = ${connection.escape(email)}
    `
    connection.query(consultaEmail, function (error, filas, campos) {
      if (filas.length > 0) {
        respuesta.status(201)
        respuesta.json({data: filas[0]})
      }
      else {
        const consultaPseudonimo = `
          SELECT *
          FROM autores
          WHERE pseudonimo = ${connection.escape(pseudonimo)}
        `
        connection.query(consultaPseudonimo, function (error, filas, campos) {
          if (filas.length > 0) {
            respuesta.status(201)
            respuesta.json({data: filas[0]})
          }
          else {
            const consulta = `
                                INSERT INTO
                                autores
                                (email, contrasena, pseudonimo)
                                VALUES (
                                  ${connection.escape(email)},
                                  ${connection.escape(contrasena)},
                                  ${connection.escape(pseudonimo)}
                                )
                              `
            connection.query(consulta, function (error, filas, campos) {
              respuesta.status(201)
              respuesta.json({data: filas[0]})
            })
          }
        })
      }
    })
    connection.release()
  })
})

aplicacion.listen(8080, function(){
  console.log("Servidor iniciado")
})

