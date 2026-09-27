-- REPLACE: Reemplaza una cadena de texto por otra dentro de un campo para cambiar el dominio del correo de los clientes.
DELIMITER //

CREATE PROCEDURE sp_actualizar_dominio_correo(IN p_dominio_viejo VARCHAR(50), IN p_dominio_nuevo VARCHAR(50))
BEGIN
    UPDATE cliente
    SET cli_correo = REPLACE(cli_correo, p_dominio_viejo, p_dominio_nuevo)
    WHERE cli_id_cliente > 0 
      AND REPLACE(cli_correo, p_dominio_viejo, p_dominio_nuevo) != cli_correo;
END //

DELIMITER ;

-- REVERSE: Invierte el orden de los caracteres de una cadena para devolver el nombre del canal en sentido inverso.
DELIMITER //

CREATE PROCEDURE sp_obtener_canal_invertido(IN p_id_canal INT)
BEGIN
    SELECT 
        can_id_canal,
        can_nombre,
        REVERSE(can_nombre) AS nombre_invertido
    FROM canal
    WHERE can_id_canal = p_id_canal;
END //

DELIMITER ;


-- RIGHT: Extrae los últimos caracteres de una cadena para obtener el dominio del correo del cliente asociado a una conversión
DELIMITER //

CREATE PROCEDURE sp_obtener_conversion_dominio_cliente(IN p_id_conversion INT)
BEGIN
    SELECT 
        cnv.con_id_conversion,
        cnv.con_valor,
        cnv.con_fecha,
        CONCAT(cli.cli_nombre, ' ', cli.cli_apellido) AS cliente_nombre_completo,
        cli.cli_correo,
        RIGHT(cli.cli_correo, 9) AS dominio_correo
    FROM conversion cnv
    INNER JOIN cliente cli ON cnv.cliente_cli_id_cliente = cli.cli_id_cliente
    WHERE cnv.con_id_conversion = p_id_conversion;
END //

DELIMITER ;


-- SPACE: Genera una cadena con espacios en blanco para concatenar nombre y apellido insertando espacios de separación.
DELIMITER //

CREATE PROCEDURE sp_formatear_nombre_cliente(IN p_id_cliente INT, IN p_num_espacios INT)
BEGIN
    SELECT 
        cli_id_cliente,
        CONCAT(cli_nombre, SPACE(p_num_espacios), cli_apellido) AS nombre_completo_espaciado
    FROM cliente
    WHERE cli_id_cliente = p_id_cliente;
END //

DELIMITER ;


-- SUBSTR: Extrae una porción de texto según posición y longitud para obtener los primeros 3 caracteres del nombre de una campaña.
DELIMITER //

CREATE PROCEDURE sp_obtener_codigo_campania(IN p_id_campania INT)
BEGIN
    SELECT 
        cam_id_campania,
        cam_nombre,
        SUBSTR(cam_nombre, 1, 3) AS prefijo_campania
    FROM campania
    WHERE cam_id_campania = p_id_campania;
END //

DELIMITER ;


-- SUBSTRING: Extrae una subcadena a partir de una posición para obtener el usuario del correo antes del símbolo @.
DELIMITER //

CREATE PROCEDURE sp_obtener_usuario_correo(IN p_id_cliente INT)
BEGIN
    SELECT 
        cli_id_cliente,
        cli_correo,
        SUBSTRING(cli_correo, 1, INSTR(cli_correo, '@') - 1) AS usuario_correo
    FROM cliente
    WHERE cli_id_cliente = p_id_cliente;
END //

DELIMITER ;


-- UPPER: Transforma una cadena de texto a mayúsculas para formatear los datos de nombre y ciudad del cliente.
DELIMITER //

CREATE PROCEDURE sp_obtener_clientes_ciudad_mayusculas(IN p_ciudad VARCHAR(45))
BEGIN
    SELECT 
        cli_id_cliente,
        UPPER(cli_nombre) AS nombre_mayus,
        UPPER(cli_apellido) AS apellido_mayus,
        UPPER(cli_ciudad) AS ciudad_mayus
    FROM cliente
    WHERE LOWER(cli_ciudad) = LOWER(p_ciudad);
END //

DELIMITER ;
