CREATE TABLE db_profesor(
    profesor_id SERIAL PRIMARY KEY,
    nombre_prof varchar(60) NOT NULL,
    direccion_prof varchar(120),
    activo boolean default True 
);

CREATE TABLE db_asignatura(
    asignatura_id SERIAL PRIMARY KEY,
    profesor_id int NOT NULL,
    prerrequisitos TEXT,
    objetivo_asig TEXT,
    descripcion_asig TEXT,
    nombre_asig varchar(90),
    creditos int,
    FOREIGN KEY (profesor_id) REFERENCES db_profesor(profesor_id) 	
);

CREATE TABLE db_modulo(
    modulo_id SERIAL PRIMARY KEY,
    asignatura_id int NOT NULL,
    nombre_mod varchar(80) NOT NULL,
    objetivo_mod TEXT,
    descripcion_mod TEXT,
    FOREIGN KEY (asignatura_id) REFERENCES db_asignatura(asignatura_id)	
);

CREATE TABLE db_bootcamps(
    bootcamp_id SERIAL PRIMARY KEY,
    finicio timestamp,
    ffin timestamp,
    nombre_bt varchar(90),
    descripcion_bt TEXT,
    precio float
);

CREATE TABLE db_rel_boot_asig(
    rel_boot_asig SERIAL PRIMARY KEY,
    asignatura_id INT NOT NULL, 
    bootcamp_id INT NOT NULL,
    FOREIGN KEY (asignatura_id) REFERENCES db_asignatura(asignatura_id),
    FOREIGN KEY (bootcamp_id) REFERENCES db_bootcamps(bootcamp_id) -- Cambiado db_db_bootcamps a db_bootcamps
);

CREATE TABLE db_usuario(
    usuario_id SERIAL PRIMARY KEY,
    nombre_cl char(50) NOT NULL,
    apellido_cl varchar(90),
    correo varchar(90),
    activo boolean,
    sexo char(10) NOT NULL
);

CREATE TABLE db_rel_cl_boot(
    rel_cl_boot SERIAL PRIMARY KEY,
    bootcamp_id INT NOT NULL, 
    usuario_id INT NOT NULL, 
    finscripcion timestamp DEFAULT NOW(),
    FOREIGN KEY (bootcamp_id) REFERENCES db_bootcamps(bootcamp_id), -- Cambiado db_db_bootcamps a db_bootcamps
    FOREIGN KEY (usuario_id) REFERENCES db_usuario(usuario_id)
);


INSERT INTO db_profesor (nombre_prof, direccion_prof, activo) 
VALUES 
('Juan Pérez', 'Calle 123, Ciudad X', True),
('María López', 'Av. Principal 456, Ciudad Y', True),
('Carlos Gómez', 'Calle Secundaria 789, Ciudad Z', False);

INSERT INTO db_asignatura (profesor_id, prerrequisitos, objetivo_asig, descripcion_asig, nombre_asig, creditos) 
VALUES 
(1, 'Ninguno', 'Introducción a las ciencias', 'Asignatura introductoria', 'Ciencias Básicas', 4),
(1, 'Matemáticas Básicas', 'Profundizar en ciencias', 'Descripción de la asignatura de ciencias avanzadas', 'Ciencias Avanzadas', 5),
(2, 'Conocimiento básico', 'Desarrollar habilidades de comunicación', 'Descripción de comunicación efectiva', 'Comunicación Efectiva', 3);

INSERT INTO db_modulo (asignatura_id, nombre_mod, objetivo_mod, descripcion_mod) 
VALUES 
(1, 'Módulo 1: Introducción', 'Introducir los conceptos básicos', 'Descripción del módulo 1 de ciencias básicas'),
(1, 'Módulo 2: Profundización', 'Profundizar en los conceptos', 'Descripción del módulo 2 de ciencias básicas'),
(3, 'Módulo 1: Técnicas de comunicación', 'Desarrollar habilidades de comunicación', 'Descripción del módulo 1 de comunicación efectiva');

INSERT INTO db_bootcamps (finicio, ffin, nombre_bt, descripcion_bt, precio) 
VALUES 
('2024-09-01 09:00:00', '2024-09-10 18:00:00', 'Bootcamp de Ciencias', 'Bootcamp intensivo de ciencias', 500.00),
('2024-10-01 09:00:00', '2024-10-07 18:00:00', 'Bootcamp de Comunicación', 'Bootcamp para mejorar la comunicación', 300.00);

INSERT INTO db_rel_boot_asig (asignatura_id, bootcamp_id) 
VALUES 
(1, 1),
(3, 2);

INSERT INTO db_usuario (nombre_cl, apellido_cl, correo, activo, sexo) 
VALUES 
('Pedro', 'García', 'pedro.garcia@mail.com', True, 'M'),
('Ana', 'Rodríguez', 'ana.rodriguez@mail.com', True, 'F'),
('Luis', 'Martínez', 'luis.martinez@mail.com', False, 'M');

INSERT INTO db_rel_cl_boot (bootcamp_id, usuario_id, finscripcion) 
VALUES 
(1, 1, '2024-08-15 10:00:00'),
(2, 2, '2024-08-20 14:00:00');