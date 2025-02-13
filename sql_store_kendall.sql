-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tienda_p1
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargos` (
  `cargo_id` int NOT NULL AUTO_INCREMENT,
  `nombre_cargo` varchar(50) NOT NULL,
  PRIMARY KEY (`cargo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` VALUES (1,'Jefe'),(2,'Cajero'),(3,'Bodega'),(4,'Carnicero');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `categoria_id` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(50) NOT NULL,
  PRIMARY KEY (`categoria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Bebidas'),(2,'Panes'),(3,'Cafe'),(4,'Galletas');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `cedula` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` int NOT NULL,
  `correo` varchar(100) NOT NULL,
  PRIMARY KEY (`cedula`),
  UNIQUE KEY `telefono` (`telefono`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=202220223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (201110111,'Kendall','Doe',83838383,'kendall@test.com'),(202220222,'Justin','Dh',84848484,'justin@test.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_producto`
--

DROP TABLE IF EXISTS `detalle_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_producto` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `producto_id` int NOT NULL,
  `numero_factura` int NOT NULL,
  `cantidad_producto` int NOT NULL,
  `descuento` int DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `producto_id` (`producto_id`),
  KEY `numero_factura` (`numero_factura`),
  CONSTRAINT `detalle_producto_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`),
  CONSTRAINT `detalle_producto_ibfk_2` FOREIGN KEY (`numero_factura`) REFERENCES `encabezado` (`numero_factura`),
  CONSTRAINT `chk_cantidad_producto` CHECK ((`cantidad_producto` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_producto`
--

LOCK TABLES `detalle_producto` WRITE;
/*!40000 ALTER TABLE `detalle_producto` DISABLE KEYS */;
INSERT INTO `detalle_producto` VALUES (23,1,16,4,5),(25,1,2,4,0),(26,1,17,4,0),(27,1,18,4,5),(28,2,18,2,5),(29,1,19,4,5),(30,2,19,2,5),(31,1,20,2,0),(32,2,20,2,0);
/*!40000 ALTER TABLE `detalle_producto` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_stock` AFTER INSERT ON `detalle_producto` FOR EACH ROW BEGIN
    declare stock int;
    SELECT cantidad_stock into stock from productos where producto_id = new.producto_id;
    
    
    if new.cantidad_producto > 0 and stock >= new.cantidad_producto THEN
    
    UPDATE productos
    SET productos.cantidad_stock = productos.cantidad_stock - new.cantidad_producto
    where producto_id = new.producto_id;
    
    ELSE 
    -- If there is not enough stock, throw an error
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: There is not enough stock available';
        
    END IF;


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calcular_total` AFTER INSERT ON `detalle_producto` FOR EACH ROW BEGIN
	
    declare v_precio double;
    declare v_total_actual double;
    declare v_descuento int;
    declare v_descuento_calculo double;
    declare total_con_descuento double;
    
    SELECT precio INTO v_precio 
    from productos 
    where producto_id = new.producto_id;
    
    SELECT descuento into v_descuento
    from detalle_producto
    where producto_id = new.producto_id
    AND numero_factura = new.numero_factura;
    
    SELECT sum(1 - (descuento / 100)) into v_descuento_calculo 
    from detalle_producto
    where producto_id = new.producto_id
    AND numero_factura = new.numero_factura;

    if new.cantidad_producto > 0 THEN
    SELECT total_pagar INTO v_total_actual from encabezado
	where numero_factura = new.numero_factura;
    
		if v_descuento < 1 THEN
			
            -- v_total_actual adds the current price of each receipt and this adds the new amount * price + the old value
            -- this so that it does not overwrite the existing value
			SET v_total_actual = ( new.cantidad_producto * v_precio ) + v_total_actual;
            -- set the total_pay to this value where the invoice matches			
            UPDATE encabezado
			SET total_pagar = v_total_actual
			where numero_factura = new.numero_factura;
			
		ELSE
			
            -- this brings me the quantity * price and then applies the discount that it has to the product
            SET total_con_descuento = ( new.cantidad_producto * v_precio ) * v_descuento_calculo;
            -- I set the current total with the existing current_total and then add the new total with the discount of the specific product
            SET v_total_actual = total_con_descuento + v_total_actual;
			UPDATE encabezado
			SET total_pagar = v_total_actual
			where numero_factura = new.numero_factura;
            
            END IF;
    
    ELSE 
    -- If there is not enough stock, throw an error
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Could not assign a total to the order';
        
    END IF;


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `cedula` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` int NOT NULL,
  `fecha_contratado` date DEFAULT (curdate()),
  `tienda_id` int NOT NULL,
  `cargo_id` int NOT NULL,
  PRIMARY KEY (`cedula`),
  UNIQUE KEY `telefono` (`telefono`),
  KEY `tienda_id` (`tienda_id`),
  KEY `cargo_id` (`cargo_id`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`tienda_id`) REFERENCES `tienda` (`tienda_id`),
  CONSTRAINT `empleados_ibfk_2` FOREIGN KEY (`cargo_id`) REFERENCES `cargos` (`cargo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102220223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (101110111,'Stephanie','Vargas',89898989,'2024-03-24',1,2),(102220222,'Glenda','Barrantes',87898789,'2024-01-12',2,2);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encabezado`
--

DROP TABLE IF EXISTS `encabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encabezado` (
  `numero_factura` int NOT NULL AUTO_INCREMENT,
  `fecha_compra` datetime DEFAULT (curdate()),
  `cedula_comprador` int NOT NULL,
  `cedula_empleado` int NOT NULL,
  `tienda_id` int NOT NULL,
  `total_pagar` double DEFAULT '0',
  `fecha_entrega` datetime DEFAULT (curdate()),
  `estado_factura_id` int NOT NULL,
  PRIMARY KEY (`numero_factura`),
  KEY `cedula_comprador` (`cedula_comprador`),
  KEY `cedula_empleado` (`cedula_empleado`),
  KEY `tienda_id` (`tienda_id`),
  KEY `estado_factura_id` (`estado_factura_id`),
  CONSTRAINT `encabezado_ibfk_1` FOREIGN KEY (`cedula_comprador`) REFERENCES `cliente` (`cedula`),
  CONSTRAINT `encabezado_ibfk_2` FOREIGN KEY (`cedula_empleado`) REFERENCES `empleados` (`cedula`),
  CONSTRAINT `encabezado_ibfk_3` FOREIGN KEY (`tienda_id`) REFERENCES `tienda` (`tienda_id`),
  CONSTRAINT `encabezado_ibfk_4` FOREIGN KEY (`estado_factura_id`) REFERENCES `estados_factura` (`estado_factura_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encabezado`
--

LOCK TABLES `encabezado` WRITE;
/*!40000 ALTER TABLE `encabezado` DISABLE KEYS */;
INSERT INTO `encabezado` VALUES (2,'2025-02-12 00:00:00',202220222,102220222,2,8400,'2025-02-21 00:00:00',1),(16,'2025-02-12 00:00:00',201110111,101110111,1,42000,'2025-02-21 00:00:00',1),(17,'2025-02-12 00:00:00',202220222,102220222,2,8400,'2025-02-21 00:00:00',1),(18,'2025-02-12 00:00:00',201110111,101110111,1,12141,'2025-02-21 00:00:00',1),(19,'2025-02-12 00:00:00',202220222,102220222,2,12540,'2025-02-21 00:00:00',1),(20,'2025-02-12 00:00:00',201110111,101110111,1,9000,'2025-02-21 00:00:00',1);
/*!40000 ALTER TABLE `encabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados_factura`
--

DROP TABLE IF EXISTS `estados_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados_factura` (
  `estado_factura_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`estado_factura_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados_factura`
--

LOCK TABLES `estados_factura` WRITE;
/*!40000 ALTER TABLE `estados_factura` DISABLE KEYS */;
INSERT INTO `estados_factura` VALUES (1,'Pendiente'),(2,'Pagada'),(3,'Anulada');
/*!40000 ALTER TABLE `estados_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcas` (
  `marca_id` int NOT NULL AUTO_INCREMENT,
  `nombre_marca` varchar(50) NOT NULL,
  PRIMARY KEY (`marca_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES (1,'Coca-Cola'),(2,'Bimbo'),(3,'NesCafe'),(4,'Oreo');
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `producto_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `precio` double NOT NULL,
  `cantidad_stock` int NOT NULL,
  `marca_id` int NOT NULL,
  `categoria_id` int NOT NULL,
  PRIMARY KEY (`producto_id`),
  KEY `marca_id` (`marca_id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`marca_id`),
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`categoria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Coca Cola 3L',2100,66,1,1),(2,'Pan cuadrado XL',2400,170,2,2),(3,'NesCafe',1400,128,3,3),(4,'Oreo',1200,80,4,4);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tienda`
--

DROP TABLE IF EXISTS `tienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tienda` (
  `tienda_id` int NOT NULL AUTO_INCREMENT,
  `nombre_tienda` varchar(50) NOT NULL,
  `telefono` int NOT NULL,
  `correo` varchar(50) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`tienda_id`),
  UNIQUE KEY `telefono` (`telefono`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tienda`
--

LOCK TABLES `tienda` WRITE;
/*!40000 ALTER TABLE `tienda` DISABLE KEYS */;
INSERT INTO `tienda` VALUES (1,'Mario Super',86848345,'mario@gmail.com','Central Ave 23'),(2,'Chino Super',86434234,'chino@gmail.com','Ave 45');
/*!40000 ALTER TABLE `tienda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tienda_p1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-12 21:13:23
