-- Conectar a base de datos colegio
USE COLEGIO;

-- Mostrar todas las tablas de colegio
SHOW tables;

-- Query 1
-- Seleccionar todos los datos de la tabla Alumno
-- Los resultados de las consultas 1 a la 6 son la totalidad de datos de cada tabla.
select * from alumno;

-- Query 2
-- Seleccionar todos los datos de la tabla Asignatura
select * from asignatura;

-- Query 3
-- Seleccionar todos los datos de la tabla Clase
select * from clase;

-- Query 4
-- Seleccionar todos los datos de la tabla Comuna
select * from comuna;

-- Query 5
-- Seleccionar todos los datos de la tabla Curso
select * from curso;

-- Query 6
-- Seleccionar todos los datos de la tabla Profesor
select * from profesor;

-- Query 7
-- Seleccionar a los alumnos de apellidos que comienzan con R
select * from alumno
where apellido like 'R%';

-- Query 8
-- Seleccionar a los alumnos de apellidos que comienzan con R y nombre termine con O
select * from alumno
where apellido like 'R%'and nombre like '%O';

-- Query 9
-- Seleccionar a los profesores de Lenguaje (2), Historia (4) e Inglés (7)
select * from profesor
where ID_Asignatura in (2,4,7);

-- Query 10
-- Seleccionar a todos los profesores excepto de las asignaturas Lenguaje (2) e Inglés (7)
select * from profesor
where ID_Asignatura not in (2,7);

-- Query 11
/* Seleccionar a los alumnos nacidos entre los años 80 y 90, mostrando nombre, apellido y fecha
de nacimiento
Ordenados por fecha ascendente */
select Nombre, Apellido, Fecha_Nac as Fecha_Nacimiento from alumno
where Fecha_Nac between '1980-01-01' and '1990-01-31'
order by Fecha_Nac ASC;

-- Query 12
/* Seleccionar a los alumnos de los cursos "B"(2,4,6,8) que tengan información en su dirección
Mostrando nombre, apellido, dirección, comuna y curso del alumno
ordenados por ID curso descendente */
select a.Nombre, a.Apellido, a.Direccion,a.ID_Comuna, a.ID_Curso from alumno as a 
where a.ID_Curso in (2,4,6,8) and
a.Direccion is not null
order by a.ID_Curso desc;

-- Query 13
/* Seleccionar a los alumnos de los cursos 1°A (1) y 2°A (3) que no tengan dirección
-- Mostrando nombre, apellido, dirección y comuna del alumno */
select Nombre, Apellido, Direccion , ID_Comuna from alumno
where ID_Curso in (1,3) and direccion is null;

-- //JOIN Y LEFT JOIN//
-- Query 14
/* Seleccionar cuantos alumnos hay en cada curso,
sólo mostrando el nombre del curso y su cantidad de alumnos */
select c.Nombre, count(a.ID_Curso) as Cantidad_alumnos from curso as c
inner join alumno as a on c.ID=a.ID_Curso
group by c.Nombre;


-- Query 15
-- Seleccionar Profesores que no han tenido clases con algún curso
select p.ID, p.RUN, p.Nombre, p.Apellido, p.Fecha_Nac, p.ID_Asignatura, p.Direccion, p.ID_Comuna, p.email, p.Telefono, cl.ID, cl.ID_Profesor, cl.ID_Alumno from profesor as p
left join clase as cl
on p.ID=cl.ID_Profesor
where cl.ID is null;

-- Query 16
/* Seleccionar a los alumnos mostrando Apellido, Nombre y curso (con su nombre)
Solamente de los cursos A, excepto el 1 A
Poner Alias a la columna del Curso para que no aparezca como "Nombre"
Ordenar por Curso, luego por Apellido del Alumno ambos ascendentes */
select a.Apellido, a.Nombre, cu.Nombre from alumno as a
inner join curso as cu
on a.ID_Curso=cu.ID
where cu.Nombre like '%A%' and cu.Nombre not like '1 A'
order by cu.Nombre, a.apellido ASC;

-- Query 17
/* Seleccionar el nombre, el apellido, la asignatura (como nombre),
la dirección y comuna (como nombre) de los Profesores
pero debe mostrar todos los profesores, aunque no tengan dirección
Poner alias a las columnas de comuna y asignatura */
select p.Nombre, p.Apellido, asg.Nombre as Asignatura, p.Direccion, co.Nombre as Comunac from profesor as p
left join asignatura as asg on p.ID_Asignatura = asg.ID
left join comuna as co on p.ID_Comuna = co.ID;

-- Query 18
/* Seleccionar a los alumnos mostrando Apellido, Nombre y curso (con su nombre)
Ordenar por ID Curso, luego por Apellido del Alumno ambos ascendentes*/
select a.Apellido, a.Nombre, cu.Nombre as curso from alumno as a 
inner join curso as cu 
on a.ID_Curso=cu.ID
order by cu.ID, a.Apellido ASC;
