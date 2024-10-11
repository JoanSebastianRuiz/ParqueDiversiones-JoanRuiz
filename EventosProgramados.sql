-- 1. Evento para realizar un chequeo de mantenimiento semanal de una atracción.

DROP FUNCTION IF EXISTS idMantenimiento;
DELIMITER //
CREATE FUNCTION idMantenimiento()
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE id INT;
    
	SELECT COUNT(*)+1 INTO id 
    FROM Maintenance;
    
    RETURN id;
END //
DELIMITER ;

DROP EVENT IF EXISTS mantenimientoSemanalCarrusel;

CREATE EVENT mantenimientoSemanalCarrusel
ON SCHEDULE EVERY 1 WEEK
DO
	INSERT INTO Maintenance(MaintenanceId,AttractionId,EmployeeId,MaintenanceDate,Details)
    VALUES (idMantenimiento(),4,3,NOW(),"Mantenimiento preventivo");


-- 2. Evento para actualizar los precios de los tickets VIP en un 5% al inicio de cada mes.

DROP EVENT IF EXISTS actualizarPrecioTicketsVIP;

CREATE EVENT actualizarPrecioTicketsVIP
ON SCHEDULE EVERY 1 MONTH
STARTS "2024-11-01 00:00:00"
DO
	UPDATE Ticket SET Price=Price+Price*0.05 WHERE TicketType="VIP";


-- 3. Evento para eliminar a los visitantes que no han hecho ninguna visita en los últimos 2 años.
-- 4. Evento para enviar un reporte semanal del número de visitantes.

DELIMITER //
CREATE FUNCTION numeroVisitantesSemanal()
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE visitantes INT;
    
	SELECT COUNT(*) INTO visitantes 
    FROM Visit WHERE VisitDate>(NOW()- INTERVAL 1 WEEK);
    
    RETURN visitantes;
END //
DELIMITER ;

DROP TABLE IF EXISTS reporteVisitas;

CREATE TABLE IF NOT EXISTS reporteVisitas(
IdReporteVisitas INT PRIMARY KEY AUTO_INCREMENT,
fecha DATETIME NOT NULL,
visitas INT NOT NULL);

DROP EVENT IF EXISTS reporteVisitantes;

CREATE EVENT reporteVisitantes
ON SCHEDULE EVERY 1 WEEK
DO
	INSERT INTO reporteVisitas(fecha,visitas)
    VALUES(NOW(), numeroVisitantesSemanal());


-- 5. Evento para realizar un mantenimiento automático a las atracciones más visitadas cada trimestre.