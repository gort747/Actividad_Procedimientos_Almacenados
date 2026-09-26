-- Procedimiento CONCAT: Une el nombre y apellido de cliente en una columna
DELIMITER //
CREATE PROCEDURE sp_consultar_nombre_completo ()
BEGIN
    SELECT 
        cli_id_cliente, 
        CONCAT(cli_nombre, ' ', cli_apellido) AS Nombre_Completo, 
        cli_correo 
    FROM cliente;
END//
DELIMITER ;

-- Procedimiento FIELD: Devuelve el tipo de canal indicado en (1.Red Social, 2.Buscador, 3.Email)
DELIMITER //
CREATE PROCEDURE sp_consultar_indice_canal ()
BEGIN
    SELECT 
        can_nombre, 
        can_tipo, 
        FIELD(can_tipo, 'Red Social', 'Buscador', 'Email') AS Indice_Tipo 
    FROM canal;
END//
DELIMITER ;

-- Procedimiento FORMAT: Toma el valor numerico y agrega separadores de miles al presupuesto
DELIMITER //
CREATE PROCEDURE sp_consultar_presupuesto_formateado ()
BEGIN
    SELECT 
        cam_nombre, 
        FORMAT(cam_presupuesto, 0) AS Presupuesto_Moneda, 
        cam_fecha_inicio 
    FROM campania;
END//
DELIMITER ;

-- Procedimiento LCASE y LOWER: Cambia los correos electronicos de los clientes a todas minusculas. Tanto LCASE como LOWER hacen lo mismo.
DELIMITER //
CREATE PROCEDURE sp_consultar_correo_minusculas ()
BEGIN
    SELECT 
        cli_nombre, 
        LCASE(cli_correo) AS Correo_LCASE, 
        LOWER(cli_correo) AS Correo_LOWER 
    FROM cliente;
END//
DELIMITER ;

-- Procedimiento para Consultar Campañas y Canales: Se toma los datos de campania y en lugar de aparecer el numero de canal se muestra el texto de la tabla canal
DELIMITER //
CREATE PROCEDURE sp_consultar_campanias ()
BEGIN
    SELECT 
        cam_id_campania AS ID, 
        cam_presupuesto AS Presupuesto, 
        cam_fecha_inicio AS Fecha_inicio, 
        cam_fecha_final AS Fecha_Final, 
        can_nombre AS canal
    FROM campania 
    LEFT JOIN canal
        ON campania.canal_can_id_canal = canal.can_id_canal;
END//
DELIMITER ;

-- Procedimiento LENGTH: Cuenta la cantidad exacta de letras, numeros y espacios que tiene el nombre de cada campaña
DELIMITER //
CREATE PROCEDURE sp_consultar_longitud_campania ()
BEGIN
    SELECT 
        cam_nombre, 
        LENGTH(cam_nombre) AS Longitud_Del_Nombre 
    FROM campania;
END//
DELIMITER ;

-- Procedimiento REPEAT: Repite la palabra prioridad tres veces consecutivas junto al nombre de cada campaña, se puede realizar tambien con simbolos y emojis.
DELIMITER //
CREATE PROCEDURE sp_consultar_nivel_campania ()
BEGIN
    SELECT 
        cam_nombre, 
        REPEAT('Prioridad ', 3) AS Nivel_Prioridad 
    FROM campania;
END//
DELIMITER ;