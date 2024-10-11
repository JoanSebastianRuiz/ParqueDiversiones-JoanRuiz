-- PROCEDMIENTOS ALMACENADOS

-- 1. Agregar un nuevo visitante.

DROP PROCEDURE IF EXISTS agregarVisitante;

DELIMITER //
CREATE PROCEDURE agregarVisitante(IN _VisitorId INT, IN _FirstName VARCHAR(40), IN _LastName VARCHAR(40), IN _BirthDate DATETIME, IN _Email VARCHAR(60), IN _Phone VARCHAR(24), 
IN _Address VARCHAR(70), IN _City VARCHAR(40), IN _State VARCHAR(40), IN _Country VARCHAR(40), IN _PostalCode VARCHAR(10))
BEGIN
	INSERT INTO Visitor(VisitorId,FirstName,LastName,BirthDate,Email,Phone,Address,City,State,Country,PostalCode)
    VALUES (_VisitorId,_FirstName, _LastName,_BirthDate,_Email,_Phone,_Address,_City,_State,_Country,_PostalCode);
END //
DELIMITER ;

CALL agregarVisitante(11, 'Jose', 'Pérez', '1985-07-12', 'carlos.perez@example.com', '123456789', 'Calle 123', 'Bogotá', 'Cundinamarca', 'Colombia', '110111');


-- 2. Registrar un nuevo mantenimiento para una atracción.

DROP PROCEDURE IF EXISTS registrarMantenimiento;

DELIMITER //
CREATE PROCEDURE registrarMantenimiento(IN _MaintenanceId INT, IN _AttractionId INT, IN _EmployeeId INT, IN _MaintenanceDate DATETIME, IN _Details VARCHAR(500))
BEGIN
	INSERT INTO Maintenance(MaintenanceId,AttractionId,EmployeeId,MaintenanceDate,Details)
    VALUES (_MaintenanceId,_AttractionId,_EmployeeId,_MaintenanceDate,_Details) ;
END //
DELIMITER ;

CALL registrarMantenimiento(1,1,1,"2024-01-01 12:00:00","Mantenimiento preventivo");


-- 3. Actualizar el precio de los tickets de un tipo específico.

DROP PROCEDURE IF EXISTS actualizarTickets;

DELIMITER //
CREATE PROCEDURE actualizarTickets(IN _Price DECIMAL(10,2), IN _TicketType VARCHAR(40))
BEGIN
	UPDATE Ticket SET Price=_Price WHERE TicketType=_TicketType;
END //
DELIMITER ;

CALL actualizarTickets(60, "General");


-- 4. Eliminar un visitante por su ID.

DROP PROCEDURE IF EXISTS eliminarVisitante;

DELIMITER //
CREATE PROCEDURE eliminarVisitante(IN _VisitorId INT)
BEGIN
	DELETE FROM Visitor WHERE VisitorId=_VisitorId;
END //
DELIMITER ;

CALL eliminarVisitante(11);


-- 5. Registrar una nueva visita de un visitante a una atracción.

DROP PROCEDURE IF EXISTS registrarVisitaAtraccion;

DELIMITER //
CREATE PROCEDURE registrarVisitaAtraccion(IN _VisitId INT, IN _VisitorId INT, IN _AttractionId INT, IN _VisitDate DATETIME, IN _Rating INT, IN _Comment VARCHAR(500))
BEGIN
	INSERT INTO Visit(VisitId,VisitorId,AttractionId,VisitDate,Rating,Comment)
    VALUES (_VisitId,_VisitorId,_AttractionId,_VisitDate,_Rating,_Comment);
END //
DELIMITER ;

CALL registrarVisitaAtraccion(1,1,1,"2024-01-01 12:00:00",5,"Muy divertida");


-- FUNCIONES

-- 1. Calcular el total de visitas a una atracción específica.

DROP FUNCTION IF EXISTS totalVisitas;

DELIMITER //
CREATE FUNCTION totalVisitas(idAtraccion INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE cantidad INT;
    
	SELECT COUNT(AttractionId) INTO cantidad
    FROM Visit
    WHERE AttractionId=idAtraccion;
    
    RETURN cantidad;
END //
DELIMITER ;

SELECT AttractionId, totalVisitas(AttractionId) FROM Attraction;


-- 2. Calcular el número de días desde el último mantenimiento de una atracción.

DROP FUNCTION IF EXISTS diasUltimoMantenimiento;

DELIMITER //
CREATE FUNCTION diasUltimoMantenimiento(idAtraccion INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE dias INT;
    
	SELECT (CURDATE()-DATE(MAX(MaintenanceDate))) INTO dias FROM Maintenance WHERE AttractionId=idAtraccion;
    
    RETURN dias;
END //
DELIMITER ;

SELECT AttractionId, diasUltimoMantenimiento(AttractionId) FROM Attraction; 


-- 3. Obtener la capacidad total del parque (suma de las capacidades de todas las atracciones).

DROP FUNCTION IF EXISTS capacidadTotal;

DELIMITER //
CREATE FUNCTION capacidadTotal()
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE capacidad INT;
    
	SELECT SUM(MaxCapacity) INTO capacidad FROM Attraction;
    
    RETURN capacidad;
END //
DELIMITER ;

SELECT capacidadTotal(); 


-- 4. Calcular el ingreso total generado por los tickets vendidos en un evento.

DROP FUNCTION IF EXISTS ingresoTotalEvento;

DELIMITER //
CREATE FUNCTION ingresoTotalEvento(idEvento INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE total DECIMAL(10,2);
    
	SELECT SUM(T.Price) INTO total 
    FROM VisitorEvent VE
    JOIN Ticket T ON VE.TicketId=T.TicketId
    WHERE VE.EventId=idEvento;
    
    RETURN capacidad;
END //
DELIMITER ;

SELECT ingresoTotalEvento(1); 



-- 5. Obtener el número total de empleados contratados en un año específico.

DROP FUNCTION IF EXISTS empleadosContratados;

DELIMITER //
CREATE FUNCTION empleadosContratados(anio VARCHAR(4))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE empleados DECIMAL(10,2);
    
	SELECT COUNT(EmployeeId) INTO empleados 
    FROM Employee
    WHERE YEAR(HireDate)=anio;
    
    RETURN empleados;
END //
DELIMITER ;

SELECT empleadosContratados("2018"); 