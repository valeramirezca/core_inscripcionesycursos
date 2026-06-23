CREATE DATABASE inscripcionescursos2026;
USE inscripcionescursos2026;

CREATE TABLE estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    edad INT
);

CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    duracion INT
);

CREATE TABLE inscripciones (
    id_estudiante INT,
    id_curso INT,
    PRIMARY KEY (id_estudiante, id_curso),
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id),
    FOREIGN KEY (id_curso) REFERENCES cursos (id)
);

INSERT INTO estudiantes (nombre, edad) VALUES ("Ana Torres", 21);
INSERT INTO estudiantes (nombre, edad) VALUES ("Bruno Lara", 19);
INSERT INTO estudiantes (nombre, edad) VALUES ("Carla Núñez", 23);
INSERT INTO estudiantes (nombre, edad) VALUES ("Diego Fuentes", 20);
INSERT INTO estudiantes (nombre, edad) VALUES ("Elena Rojas", 22);

INSERT INTO cursos (nombre, duracion) VALUES ("MySQL Básico", 4);
INSERT INTO cursos (nombre, duracion) VALUES ("JavaScript desde Cero", 8);
INSERT INTO cursos (nombre, duracion) VALUES ("Python para Datos", 6);
INSERT INTO cursos (nombre, duracion) VALUES ("Diseño UX/UI", 5);

INSERT INTO inscripciones (id_estudiante, id_curso) VALUES (1, 1);
INSERT INTO inscripciones (id_estudiante, id_curso) VALUES (1, 2);
INSERT INTO inscripciones (id_estudiante, id_curso) VALUES (2, 1);
INSERT INTO inscripciones (id_estudiante, id_curso) VALUES (2, 3);
INSERT INTO inscripciones (id_estudiante, id_curso) VALUES (3, 2);
INSERT INTO inscripciones (id_estudiante, id_curso) VALUES (3, 4);
INSERT INTO inscripciones (id_estudiante, id_curso) VALUES (4, 1);
INSERT INTO inscripciones (id_estudiante, id_curso) VALUES (4, 4);

SELECT
    e.nombre AS estudiante,
    c.nombre AS curso
FROM estudiantes e
    LEFT JOIN inscripciones i ON i.id_estudiante = e.id
    LEFT JOIN cursos c ON c.id = i.id_curso
ORDER BY e.id;

SELECT
    e.nombre AS estudiante,
    e.edad,
    c.nombre AS curso
FROM estudiantes e
    JOIN inscripciones i ON i.id_estudiante = e.id
    JOIN cursos c ON c.id = i.id_curso
WHERE
    c.nombre = "MySQL Básico";

SELECT
    e.nombre AS estudiante,
    c.nombre AS curso,
    c.duracion
FROM estudiantes e
    JOIN inscripciones i ON i.id_estudiante = e.id
    JOIN cursos c ON c.id = i.id_curso
WHERE
    e.nombre = "Ana Torres";

SELECT
    c.nombre AS curso,
    count(i.id_estudiante) AS estudiantes_inscritos
FROM cursos c
    LEFT JOIN inscripciones i ON i.id_curso = c.id
GROUP BY c.id, c.nombre
ORDER BY estudiantes_inscritos DESC;

SELECT e.id, e.nombre, e.edad
FROM estudiantes e
    LEFT JOIN inscripciones i ON i.id_estudiante = e.id
WHERE
    i.id_estudiante IS NULL;
