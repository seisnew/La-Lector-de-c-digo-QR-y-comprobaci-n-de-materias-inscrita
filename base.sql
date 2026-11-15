-- ==========================================
-- 1. CREACIÓN DE TABLAS PRINCIPALES
-- ==========================================

CREATE TABLE materias (
    codigo VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    semestre INT NOT NULL,
    uc INT NOT NULL
);

CREATE TABLE prelaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    materia_codigo VARCHAR(20),
    requisito_codigo VARCHAR(20),
    FOREIGN KEY (materia_codigo) REFERENCES materias(codigo),
    FOREIGN KEY (requisito_codigo) REFERENCES materias(codigo)
);

CREATE TABLE correquisitos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    materia_a VARCHAR(20),
    materia_b VARCHAR(20),
    FOREIGN KEY (materia_a) REFERENCES materias(codigo),
    FOREIGN KEY (materia_b) REFERENCES materias(codigo)
);

CREATE TABLE historial_estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL,
    materia_codigo VARCHAR(20),
    estatus ENUM('APROBADA', 'REPROBADA') DEFAULT 'APROBADA',
    FOREIGN KEY (materia_codigo) REFERENCES materias(codigo)
);


-- ==========================================
-- 2. INSERCIÓN DE CATÁLOGO DE MATERIAS (1.ER AL 8.VO SEMESTRE)
-- ==========================================

-- 1er Semestre
INSERT INTO materias (codigo, nombre, semestre, uc) VALUES
('ADG25132', 'Educación Ambiental', 1, 2),
('ADG25123', 'Hombre, Sociedad, Ciencia y Tecnología', 1, 3),
('IDM24113', 'Inglés I', 1, 3),
('MAT21212', 'Dibujo', 1, 2),
('MAT21215', 'Matemática I', 1, 5),
('MAT21524', 'Geometría Analítica', 1, 4),
('ADG25131', 'Seminario I', 1, 1),
('DIN21113', 'Instrucción Militar I', 1, 0),
('ADO10101', 'Actividades Complementarias I', 1, 0);

-- 2do Semestre
INSERT INTO materias (codigo, nombre, semestre, uc) VALUES
('IDM24123', 'Inglés II', 2, 3),
('QUF22014', 'Química General', 2, 4),
('QUF23015', 'Física I', 2, 5),
('MAT21225', 'Matemática II', 2, 5),
('MAT21114', 'Álgebra Lineal', 2, 4),
('ADG25141', 'Seminario II', 2, 1),
('DIN21123', 'Instrucción Militar II', 2, 0),
('ADO10102', 'Actividades Complementarias II', 2, 0);

-- 3er Semestre
INSERT INTO materias (codigo, nombre, semestre, uc) VALUES
('QUF23025', 'Física II', 3, 5),
('MAT21235', 'Matemática III', 3, 5),
('MAT21414', 'Probabilidades y Estadística', 3, 4),
('SYC22113', 'Programación', 3, 3),
('MAT21224', 'Transformadas Integrales', 3, 4),
('DIN21133', 'Instrucción Militar III', 3, 0),
('ADO10103', 'Actividades Complementarias III', 3, 0);

-- 4to Semestre
INSERT INTO materias (codigo, nombre, semestre, uc) VALUES
('TLC31115', 'Redes Eléctricas I', 4, 5),
('ELN35135', 'Señales y Sistemas', 4, 5),
('QUF33013', 'Física III', 4, 3),
('ELN35114', 'Teoría Electromagnética', 4, 4),
('CJU37314', 'Marco Legal para el Ejercicio de la Ingeniería', 4, 4),
('AGL35410', 'Seminario de Telecomunicaciones I', 4, 3),
('DIN31143', 'Instrucción Militar IV', 4, 0),
('ADO10104', 'Actividades Complementarias IV', 4, 0);

-- 5to Semestre
INSERT INTO materias (codigo, nombre, semestre, uc) VALUES
('TLC31125', 'Redes Eléctricas II', 5, 5),
('TLC31225', 'Electrónica I', 5, 5),
('TLC32125', 'Sistemas Digitales', 5, 5),
('TLC35215', 'Comunicaciones I', 5, 5),
('TLC35314', 'Líneas de Transmisión', 5, 4),
('ENT31613', 'Electiva No Técnica', 5, 3),
('DIN31153', 'Instrucción Militar V', 5, 0),
('ADO10105', 'Actividades Complementarias V', 5, 0);

-- 6to Semestre
INSERT INTO materias (codigo, nombre, semestre, uc) VALUES
('TLC31235', 'Electrónica II', 6, 5),
('ELN32225', 'Microprocesadores', 6, 5),
('TLC35225', 'Comunicaciones II', 6, 5),
('ELN35325', 'Microondas', 6, 5),
('TLC31514', 'Instrumentación de las Comunicaciones', 6, 4),
('SYC32315', 'Computación Avanzada', 6, 5),
('DIN31163', 'Instrucción Militar VI', 6, 0),
('ADO10106', 'Actividades Complementarias VI', 6, 0),
('TLC31325', 'Electrónica de las Comunicaciones', 6, 5),
('AGM30314', 'Mantenimiento General', 6, 4);

-- 7mo Semestre
INSERT INTO materias (codigo, nombre, semestre, uc) VALUES
('TLC35414', 'Sistemas de Comunicaciones I', 7, 4),
('ELN35344
