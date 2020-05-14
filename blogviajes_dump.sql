-- MariaDB dump 10.17  Distrib 10.4.11-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: blogviajes
-- ------------------------------------------------------
-- Server version	10.4.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `blogviajes`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `blogviajes` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `blogviajes`;

--
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `pseudonimo` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'mhernan157@hotmail.com','123456','Miguel','1.png'),(2,'yobaenf@hotmail.com','123456','yoba','2.png'),(3,'mhmendozat@gmail.com','dohimihe17V','mhmt',NULL);
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicaciones`
--

DROP TABLE IF EXISTS `publicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publicaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `resumen` varchar(255) NOT NULL,
  `contenido` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `votos` int(11) DEFAULT 0,
  `fecha_hora` timestamp NULL DEFAULT NULL,
  `autor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`autor_id`),
  KEY `fk_publicaciones_autores_idx` (`autor_id`),
  CONSTRAINT `fk_publicaciones_autores` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicaciones`
--

LOCK TABLES `publicaciones` WRITE;
/*!40000 ALTER TABLE `publicaciones` DISABLE KEYS */;
INSERT INTO `publicaciones` VALUES (1,'Perú','Buen viaje a Perú','<p><strong>Perú</strong> es un país de Sudamérica que abarca una sección del bosque del <i><strong>Amazonas</strong></i> y <i><strong>Machu Picchu</strong></i>, una antigua ciudad inca en las alturas de los Andes.</p>',NULL,4,'2020-05-12 05:00:00',1),(2,'Chile','Buen viaje a Chile','<p><strong>Chile</strong> es un país largo y angosto que se extiende por el borde occidental de Sudamérica, con más de 6,000 km de costa en el océano Pacífico.</p>',NULL,1,'2020-05-12 05:00:00',3),(3,'Colombia','Buen viaje a Colombia','<p>Colombia es un país del extremo norte de Sudamérica. Su paisaje cuenta con bosques tropicales, las montañas de los Andes y varias plantaciones de café.</p>',NULL,6,'2020-05-12 05:00:00',3),(4,'Argentina','Buen Viaje a Argentina','<p><i>Argentina</i> es un país sudamericano de gran envergadura con un terreno que incluye las montañas de los Andes, lagos glaciales y praderas en las Pampas, la tierra tradicional de pastoreo de su famoso ganado.</p>',NULL,4,'2020-05-12 05:00:00',3),(5,'Perú','Buen País','<p><strong>Lo mejor es su gente y su comida</strong></p>',NULL,7,'2020-05-12 05:00:00',2),(6,'Chile','Buen viaje a Chile','<p>Buena Música como la de <strong>Illapu</strong> e Inti <strong>Illimani</strong></p>',NULL,2,'2020-05-12 05:00:00',2),(7,'Bolivia','viaje feliz a Bolivia','<p><i>Bolivia</i> es un país del centro de Sudamérica, con un terreno variado desde los Andes, el Desierto de Atacama y el bosque pluvial en la cuenca del Amazonas.&nbsp;</p>',NULL,6,'2020-05-12 05:00:00',1),(8,'Argentina','Buen viaje a Argentina','<p>El país es conocido por el baile y la música del tango.</p>',NULL,2,'2020-05-12 05:00:00',1),(9,'Ecuador','Feliz en Ecuador','<p>Ecuador es un país que se extiende por el ecuador en la costa oeste de Sudamérica. Sus diversos paisajes abarcan la selva del Amazonas, las zonas altas andinas y las islas Galápagos de abundante fauna.</p>',NULL,1,'2020-05-12 05:00:00',1),(10,'Brasil','Buen viaje a Brasil','<p>Brasil es un vasto país de Sudamérica que se extiende desde la Cuenca del Amazonas en el norte hasta los viñedos y las enormes cataratas del Iguazú en el sur.</p>',NULL,0,'2020-05-12 05:00:00',1);
/*!40000 ALTER TABLE `publicaciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-13  0:00:22
