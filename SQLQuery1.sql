--1. Selecciona las columnas DisplayName, Location y Reputation de los usuarios con mayor reputaci�n.
SELECT TOP 200 DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC; 



/*2. Selecciona la columna Title de la tabla Posts junto con el DisplayName de los usuarios
que lo publicaron para aquellos posts que tienen un propietario.
Para lograr esto une las tablas Posts y Users utilizando OwnerUserId para obtener el
nombre del usuario que public� cada post. Presenta los resultados en una tabla
mostrando las columnas Title y DisplayName */
SELECT p.Title, u.DisplayName
FROM Posts p
INNER JOIN Users u ON OwnerUserId = u.Id
WHERE OwnerUserId IS NOT NULL;



/*3. Calcula el promedio de Score de los Posts por cada usuario y muestra el DisplayName
del usuario junto con el promedio de Score.
Para esto agrupa los posts por OwnerUserId, calcula el promedio de Score para cada
usuario y muestra el resultado junto con el nombre del usuario. Presenta los resultados
en una tabla mostrando las columnas DisplayName y el promedio de Score*/

SELECT u.DisplayName, AVG(p.Score) AS AverageScore
FROM Posts p
JOIN Users u ON p.OwnerUserId = u.Id
GROUP BY u.DisplayName;



/*4. Encuentra el DisplayName de los usuarios que han realizado m�s de 100 comentarios
en total. Para esto utiliza una subconsulta para calcular el total de comentarios por
usuario y luego filtra aquellos usuarios que hayan realizado m�s de 100 comentarios en
total. Presenta los resultados en una tabla mostrando el DisplayName de los usuarios*/
SELECT u.DisplayName
FROM Users u
WHERE (
SELECT COUNT (*)
FROM Comments
WHERE Comments.UserId = UserId
) > 100;


/*5. Actualiza la columna Location de la tabla Users cambiando todas las ubicaciones vac�as
por "Desconocido". Utiliza una consulta de actualizaci�n para cambiar las ubicaciones
vac�as. Muestra un mensaje indicando que la actualizaci�n se realiz� correctamente.*/

UPDATE Users
SET Location = 'Desconocido'
WHERE Location = ' ';

PRINT 'La actualizacion se realizo con exito'


/*6. Elimina todos los comentarios realizados por usuarios con menos de 100 de reputaci�n.
Utiliza una consulta de eliminaci�n para eliminar todos los comentarios realizados y
muestra un mensaje indicando cu�ntos comentarios fueron eliminados */

DELETE Comments
FROM Comments
JOIN Users ON Comments.UserId = UserId
WHERE Users.Reputation < 100;

-- Mostrar mensaje
PRINT 'Numero de comentarios eliminados ' + CAST (@@ROWCOUNT AS NVARCHAR(10));


/*8. Muestra las 10 publicaciones m�s populares basadas en la puntuaci�n (Score) de la
tabla Posts. Ordena las publicaciones por puntuaci�n de forma descendente y
selecciona solo las 10 primeras. Presenta los resultados en una tabla mostrando el Title
de la publicaci�n y su puntuaci�n*/

SELECT TOP (10) Title, Score
FROM Posts
ORDER BY Score DESC;


/*9. Muestra los 5 comentarios m�s recientes de la tabla Comments. Ordena los comentarios
por fecha de creaci�n de forma descendente y selecciona solo los 5 primeros. Presenta
los resultados en una tabla mostrando el Text del comentario y la fecha de creaci�n*/

SELECT TOP(5) Text, CreationDate
FROM Comments
ORDER BY CreationDate DESC;
