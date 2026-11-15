-- Creación de Tablas Principales
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
-- CATÁLOGO DE MATERIAS (SEMESTRE 1 AL 8)
-- ==========================================

INSERT INTO materias (codigo, nombre, semestre, uc) VALUES
-- 1er Semestre
('ADG25132', 'Educación Ambiental', 1, 2),
('ADG25123', 'Hombre, Sociedad, Ciencia y Tecnología', 1, 3),
('IDM24113', 'Inglés I', 1, 3),
('MAT21212', 'Dibujo', 1, 2),
('MAT21215', 'Matemática I', 1, 5),
('MAT21524', 'Geometría Analítica', 1, 4),
('ADG25131', 'Seminario I', 1, 1),
('DIN21113', 'Instrucción Militar I', 1, 0),
('ADO10101', 'Actividades Complementarias I', 1, 0),

-- 2do Semestre
('IDM24123', 'Inglés II', 2, 3),
('QUF22014', 'Química General', 2, 4),
('QUF23015', 'Física I', 2, 5),
('MAT21225', 'Matemática II', 2, 5),
('MAT21114', 'Álgebra Lineal', 2, 4),
('ADG25141', 'Seminario II', 2, 1),
('DIN21123', 'Instrucción Militar II', 2, 0),
('ADO10102', 'Actividades Complementarias II', 2, 0),

-- 3er Semestre
('QUF23025', 'Física II', 3, 5),
('MAT21235', 'Matemática III', 3, 5),
('MAT21414', 'Probabilidades y Estadística', 3, 4),
('SYC22113', 'Programación', 3, 3),
('MAT21224', 'Transformadas Integrales', 3, 4),
('DIN21133', 'Instrucción Militar III', 3, 0),
('ADO10103', 'Actividades Complementarias III', 3, 0),

-- 4to Semestre
('TLC31115', 'Redes Eléctricas I', 4, 5),
('ELN35135', 'Señales y Sistemas', 4, 5),
('QUF33013', 'Física III', 4, 3),
('ELN35114', 'Teoría Electromagnética', 4, 4),
('CJU37314', 'Marco Legal para el Ejercicio de la Ingeniería', 4, 4),
('AGL35410', 'Seminario de Telecomunicaciones I', 4, 3),
('DIN31143', 'Instrucción Militar IV', 4, 0),
('ADO10104', 'Actividades Complementarias IV', 4, 0),

-- 5to Semestre
('TLC31125', 'Redes Eléctricas II', 5, 5),
('TLC31225', 'Electrónica I', 5, 5),
('TLC32125', 'Sistemas Digitales', 5, 5),
('TLC35215', 'Comunicaciones I', 5, 5),
('TLC35314', 'Líneas de Transmisión', 5, 4),
('ENT31613', 'Electiva No Técnica', 5, 3), -- O Oratoria
('DIN31153', 'Instrucción Militar V', 5, 0),
('ADC10105', 'Actividades Complementarias V', 5, 0),

-- 6to Semestre
('TLC31235', 'Electrónica II', 6, 5),
('ELN32225', 'Microprocesadores', 6, 5),
('TLC35225', 'Comunicaciones II', 6, 5),
('ELN35325', 'Microondas', 6, 5),
('TLC31514', 'Instrumentación de las Comunicaciones', 6, 4),
('SYC32315', 'Computación Avanzada', 6, 5),
('DIN31163', 'Instrucción Militar VI', 6, 0),
('ADC10106', 'Actividades Complementarias VI', 6, 0),
('TLC31325', 'Electrónica de las Comunicaciones', 6, 5),
('AGM30314', 'Mantenimiento General', 6, 4),

-- 7mo Semestre
('TLC35414', 'Sistemas de Comunicaciones I', 7, 4),
('ELN35344', 'Antenas', 7, 4),
('ELN35323', 'Comunicaciones Ópticas', 7, 3),
('ADG30214', 'Metodología de la Investigación', 7, 4),
('ENT31713', 'Electiva No Técnica', 7, 3),
('DIN31173', 'Instrucción Militar VII', 7, 0),
('ADC10107', 'Actividades Complementarias VII', 7, 0),

-- 8vo Semestre
('TLC35424', 'Sistemas de Comunicaciones II', 8, 4),
('TLC35465', 'Redes de Telecomunicaciones', 8, 5),
('AGL35423', 'Seminario de Telecomunicaciones II', 8, 3),
('TLC31323', 'Transmisión de Datos', 8, 3),
('ELN_TEC1', 'Electiva Técnica', 8, 3),
('ELN_TEC2', 'Electiva Técnica', 8, 3),
('DIN31183', 'Instrucción Militar VIII', 8, 0),
('ADC10108', 'Actividades Complementarias VIII', 8, 0);


-- ==========================================
-- REGLAS DE CORREQUISITOS (CO.)
-- ==========================================
INSERT INTO correquisitos (materia_a, materia_b) VALUES
-- 1er Semestre
('MAT21215', 'MAT21524'),
('MAT21524', 'MAT21215'),
-- 4to Semestre
('ELN35135', 'TLC31115'),
('TLC31115', 'ELN35135'),
-- 6to Semestre
('TLC31514', 'TLC31235'),
('TLC31235', 'TLC31514'),
('TLC31325', 'TLC31235'),
('TLC31235', 'TLC31325'),
('TLC31325', 'TLC35225'),
('TLC35225', 'TLC31325'),
-- 7mo Semestre
('TLC35414', 'ELN35344'),
('ELN35344', 'TLC35414'),
-- 8vo Semestre
('TLC35465', 'TLC35424'),
('TLC35424', 'TLC35465'),
('TLC31323', 'TLC35465'),
('TLC35465', 'TLC31323');


-- ==========================================
-- REGLAS DE PRELACIONES PRINCIPALES
-- ==========================================
INSERT INTO prelaciones (materia_codigo, requisito_codigo) VALUES
-- 2do Semestre
('IDM24123', 'IDM24113'),
('QUF23015', 'MAT21215'),
('QUF23015', 'MAT21524'),
('MAT21225', 'MAT21215'),
('MAT21225', 'MAT21524'),
('MAT21114', 'MAT21215'),
('MAT21114', 'MAT21524'),
('ADG25141', 'ADG25131'),

-- 3er Semestre
('QUF23025', 'QUF23015'),
('QUF23025', 'MAT21225'),
('MAT21235', 'MAT21225'),
('MAT21414', 'MAT21225'),
('SYC22113', 'MAT21114'),
('MAT21224', 'MAT21235'),
('MAT21224', 'MAT21114'),

-- 4to Semestre
('TLC31115', 'MAT21235'),
('TLC31115', 'QUF23025'),
('ELN35135', 'MAT21224'),
('QUF33013', 'QUF23025'),
('QUF33013', 'MAT21235'),
('ELN35114', 'QUF23025'),
('ELN35114', 'MAT21235'),

-- 5to Semestre
('TLC31125', 'TLC31115'),
('TLC31225', 'QUF33013'),
('TLC32125', 'TLC31225'),
('TLC35215', 'ELN35135'),
('TLC35314', 'ELN35114'),

-- 6to Semestre
('TLC31235', 'TLC31225'),
('ELN32225', 'TLC32125'),
('ELN32225', 'TLC31225'),
('TLC35225', 'TLC35215'),
('ELN35325', 'TLC35314'),
('SYC32315', 'TLC32125'),
('AGM30314', 'TLC31235'),
('AGM30314', 'TLC35225'),

-- 7mo Semestre
('TLC35414', 'TLC35225'),
('ELN35344', 'ELN35325'),
('ELN35323', 'TLC35225'),

-- 8vo Semestre
('TLC35424', 'TLC35414'),
('TLC35465', 'TLC35424'),
('TLC31323', 'TLC35465');
