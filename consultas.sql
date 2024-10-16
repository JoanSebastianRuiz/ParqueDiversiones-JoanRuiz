-- 1. Obtener todas las atracciones operativas.

SELECT * FROM Attraction WHERE Status="Operativa";

-- 2. Listar todos los visitantes que se encuentran en la base de datos.
SELECT * FROM Visitor;

-- 3. Mostrar los eventos programados junto con su precio.

SELECT Name, Price FROM Event;

-- 4. Obtener el nombre y fecha de contratación de todos los empleados.
SELECT FirstName, LastName, HireDate FROM Employee;

-- 5. Listar todos los boletos vendidos y su tipo.
SELECT TicketId, TicketType FROM Ticket;

-- 6. Obtener el nombre de los visitantes y las atracciones que visitaron.
-- 7. Listar los empleados que participaron en eventos, junto con el nombre del evento.
-- 8. Mostrar los detalles de mantenimiento realizados por cada empleado, junto con la atracción.
-- 9. Obtener el nombre del visitante y la atracción que calificó junto con la puntuación.
-- 10. Listar los visitantes que asistieron a eventos, con el nombre del evento.
-- 11. Contar cuántas visitas ha tenido cada atracción.
-- 12. Obtener el precio promedio de los tickets vendidos por tipo.
-- 13. Contar cuántos empleados hay en cada ciudad.
-- 14. Listar el total de visitantes por país.
-- 15. Obtener el número total de eventos y su precio promedio.
-- 16. Obtener el nombre de las atracciones que tienen una capacidad máxima mayor que el promedio.
-- 17. Listar los empleados que han trabajado en más de un evento.
-- 18. Obtener las atracciones que no han sido visitadas en la última semana.
-- 19. Listar los visitantes que compraron un boleto VIP.
-- 20. Mostrar los empleados cuyo salario (de la tabla `EmployeeSalary`) es mayor al salario promedio.
-- 21. Actualizar el estado de una atracción a 'En Mantenimiento'.
-- 22. Eliminar visitantes que no han realizado ninguna visita.
-- 23. Insertar un nuevo evento en la base de datos.
-- 24. Aumentar el precio de los tickets VIP en un 10%.
-- 25. Cambiar la ciudad de todos los empleados en Bogotá a Medellín.