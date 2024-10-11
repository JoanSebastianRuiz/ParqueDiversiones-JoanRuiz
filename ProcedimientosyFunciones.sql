-- Agregar un nuevo visitante.

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


-- Registrar un nuevo mantenimiento para una atracción.

DROP PROCEDURE IF EXISTS registrarMantenimiento;

DELIMITER //
CREATE PROCEDURE registrarMantenimiento(IN _MaintenanceId INT, IN _AttractionId INT, IN _EmployeeId INT, IN _MaintenanceDate DATETIME, IN _Details VARCHAR(500))
BEGIN
	INSERT INTO Maintenance(MaintenanceId,AttractionId,EmployeeId,MaintenanceDate,Details)
    VALUES (_MaintenanceId,_AttractionId,_EmployeeId,_MaintenanceDate,_Details) ;
END //
DELIMITER ;

CALL registrarMantenimiento(1,1,1,"2024-01-01 12:00:00","Mantenimiento preventivo");


-- Actualizar el precio de los tickets de un tipo específico.

DROP PROCEDURE IF EXISTS actualizarTickets;

DELIMITER //
CREATE PROCEDURE actualizarTickets(IN _Price DECIMAL(10,2), IN _TicketType VARCHAR(40))
BEGIN
	UPDATE Ticket SET Price=_Price WHERE TicketType=_TicketType;
END //
DELIMITER ;

CALL actualizarTickets(60, "General");


-- Eliminar un visitante por su ID.

DROP PROCEDURE IF EXISTS eliminarVisitante;

DELIMITER //
CREATE PROCEDURE eliminarVisitante(IN _VisitorId INT)
BEGIN
	DELETE FROM Visitor WHERE VisitorId=_VisitorId;
END //
DELIMITER ;

CALL eliminarVisitante(11);


-- Registrar una nueva visita de un visitante a una atracción.

DROP PROCEDURE IF EXISTS registrarVisitaAtraccion;

DELIMITER //
CREATE PROCEDURE registrarVisitaAtraccion(IN _VisitId INT, IN _VisitorId INT, IN _AttractionId INT, IN _VisitDate DATETIME, IN _Rating INT, IN _Comment VARCHAR(500))
BEGIN
	INSERT INTO Visit(VisitId,VisitorId,AttractionId,VisitDate,Rating,Comment)
    VALUES (_VisitId,_VisitorId,_AttractionId,_VisitDate,_Rating,_Comment);
END //
DELIMITER ;

CALL registrarVisitaAtraccion(1,1,1,"2024-01-01 12:00:00",5,"Muy divertida");