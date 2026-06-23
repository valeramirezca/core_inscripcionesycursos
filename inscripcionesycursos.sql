SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema inscripcionesCursos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inscripcionesCursos` DEFAULT CHARACTER SET utf8 ;
USE `inscripcionesCursos` ;

-- -----------------------------------------------------
-- Table `inscripcionesCursos`.`estudiantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inscripcionesCursos`.`estudiantes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `edad` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inscripcionesCursos`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inscripcionesCursos`.`cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `duracion` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inscripcionesCursos`.`inscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inscripcionesCursos`.`inscripciones` (
  `id_estudiante` INT NOT NULL,
  `id_curso` INT NOT NULL,
  PRIMARY KEY (`id_estudiante`, `id_curso`),
  INDEX `fk_inscripciones_cursos1_idx` (`id_curso` ASC) VISIBLE,
  INDEX `fk_inscripciones_estudiantes1_idx` (`id_estudiante` ASC) VISIBLE,
  CONSTRAINT `fk_inscripciones_estudiantes1`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `inscripcionesCursos`.`estudiantes` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscripciones_cursos1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `inscripcionesCursos`.`cursos` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `inscripcionesCursos`.`estudiantes` (`nombre`, `edad`) VALUES
('Valentina Ramirez',     31),
('Ariel Vidal',      19),
('Federico Vidal',    23),
('Clara Vidal',  20),
('Max Ramirez',    22);

INSERT INTO `inscripcionesCursos`.`cursos` (`nombre`, `duracion`) VALUES
('Matematica',        4),
('Lenguaje', 8),
('Ingles',   6),
('Artes',        5);

INSERT INTO `inscripcionesCursos`.`inscripciones` (`id_estudiante`, `id_curso`) VALUES
(1, 1), 
(1, 2), 
(2, 1), 
(2, 3), 
(3, 2), 
(3, 4),
(4, 1),
(4, 4); 


SELECT
    e.id        AS id_estudiante,
    e.nombre    AS estudiante,
    c.nombre    AS curso
FROM estudiantes e
LEFT JOIN inscripciones i ON i.id_estudiante = e.id
LEFT JOIN cursos c        ON c.id = i.id_curso
ORDER BY e.id;

SELECT
    e.nombre    AS estudiante,
    e.edad,
    c.nombre    AS curso
FROM estudiantes e
JOIN inscripciones i ON i.id_estudiante = e.id
JOIN cursos c        ON c.id = i.id_curso
WHERE c.nombre = 'Matematica';


SELECT
    e.nombre    AS estudiante,
    c.nombre    AS curso,
    c.duracion
FROM estudiantes e
JOIN inscripciones i ON i.id_estudiante = e.id
JOIN cursos c        ON c.id = i.id_curso
WHERE e.nombre = 'Valentina Ramirez';

SELECT
    c.nombre              AS curso,
    COUNT(i.id_estudiante) AS estudiantes_inscritos
FROM cursos c
LEFT JOIN inscripciones i ON i.id_curso = c.id
GROUP BY c.id, c.nombre
ORDER BY estudiantes_inscritos DESC;

SELECT
    e.id,
    e.nombre,
    e.edad
FROM estudiantes e
LEFT JOIN inscripciones i ON i.id_estudiante = e.id
WHERE i.id_estudiante IS NULL;
