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


