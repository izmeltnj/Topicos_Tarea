```sql
-- ====================================================
-- CREACIÓN DE LA BASE DE DATOS UNIVERSIDAD
-- ====================================================
CREATE DATABASE IF NOT EXISTS Universidad;
USE Universidad;

-- ====================================================
-- CREACIÓN DE TABLAS
-- ====================================================
CREATE TABLE IF NOT EXISTS Estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    matricula VARCHAR(20) UNIQUE,
    carrera VARCHAR(50),
    semestre INT
);

CREATE TABLE IF NOT EXISTS Profesores (
    id_profesor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    departamento VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos INT,
    id_profesor INT,
    FOREIGN KEY (id_profesor) REFERENCES Profesores(id_profesor)
);

CREATE TABLE IF NOT EXISTS Inscripciones (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    fecha DATE,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

-- ====================================================
-- CREACIÓN DE ÍNDICES
-- ====================================================
CREATE INDEX idx_matricula ON Estudiantes(matricula);
CREATE INDEX idx_carrera ON Estudiantes(carrera);
CREATE INDEX idx_departamento ON Profesores(departamento);
CREATE INDEX idx_creditos ON Cursos(creditos);

-- ====================================================
-- INSERCIÓN DE DATOS DE EJEMPLO
-- ====================================================
INSERT INTO Estudiantes (nombre, matricula, carrera, semestre) VALUES
('Juan Pérez', 'A001', 'Ingeniería', 3),
('María López', 'A002', 'Derecho', 2),
('Carlos Ruiz', 'A003', 'Medicina', 1);

INSERT INTO Profesores (nombre, departamento) VALUES
('Dr. Ramírez', 'Ciencias'),
('Mtra. Gómez', 'Humanidades');

INSERT INTO Cursos (nombre, creditos, id_profesor) VALUES
('Matemáticas I', 6, 1),
('Derecho Civil', 5, 2);

INSERT INTO Inscripciones (id_estudiante, id_curso, fecha) VALUES
(1, 1, '2025-09-01'),
(2, 2, '2025-09-01');

-- ====================================================
-- PROCEDIMIENTOS ALMACENADOS BÁSICOS
-- ====================================================
DELIMITER //
CREATE PROCEDURE ListarEstudiantes()
BEGIN
    SELECT * FROM Estudiantes;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE InsertarEstudiante(IN p_nombre VARCHAR(100), IN p_matricula VARCHAR(20), IN p_carrera VARCHAR(50), IN p_semestre INT)
BEGIN
    INSERT INTO Estudiantes(nombre, matricula, carrera, semestre)
    VALUES(p_nombre, p_matricula, p_carrera, p_semestre);
END //
DELIMITER ;

-- ====================================================
-- PROCEDIMIENTOS CON ESTRUCTURA IF
-- ====================================================
DELIMITER //
CREATE PROCEDURE VerificarSemestre(IN p_id INT)
BEGIN
    DECLARE v_semestre INT;
    SELECT semestre INTO v_semestre FROM Estudiantes WHERE id_estudiante = p_id;

    IF v_semestre >= 6 THEN
        SELECT 'El estudiante está en un semestre avanzado.' AS mensaje;
    ELSE
        SELECT 'El estudiante está en semestres iniciales.' AS mensaje;
    END IF;
END //
DELIMITER ;

-- ====================================================
-- PROCEDIMIENTOS CON ESTRUCTURA CASE
-- ====================================================
DELIMITER //
CREATE PROCEDURE ClasificarCarrera(IN p_id INT)
BEGIN
    DECLARE v_carrera VARCHAR(50);
    SELECT carrera INTO v_carrera FROM Estudiantes WHERE id_estudiante = p_id;

    CASE v_carrera
        WHEN 'Ingeniería' THEN SELECT 'Carrera del área de Ciencias Exactas' AS mensaje;
        WHEN 'Derecho' THEN SELECT 'Carrera del área de Ciencias Sociales' AS mensaje;
        WHEN 'Medicina' THEN SELECT 'Carrera del área de Ciencias de la Salud' AS mensaje;
        ELSE SELECT 'Carrera de otra área' AS mensaje;
    END CASE;
END //
DELIMITER ;

-- ====================================================
-- EJEMPLOS DE EJECUCIÓN DE PROCEDIMIENTOS
-- ====================================================
CALL ListarEstudiantes();
CALL InsertarEstudiante('Laura Méndez', 'A004', 'Ingeniería', 4);
CALL VerificarSemestre(1);
CALL ClasificarCarrera(2);
```
