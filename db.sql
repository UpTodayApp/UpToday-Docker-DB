DROP DATABASE IF EXISTS uptoday;
DROP USER IF EXISTS administrador@127.0.0.1;
DROP USER IF EXISTS moderador@127.0.0.1;
DROP USER IF EXISTS usuario@127.0.0.1;
CREATE DATABASE uptoday;
USE uptoday;

CREATE TABLE usuario (
  id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(50) not null unique,
  contrasenia varchar(255),
  correo varchar(255), 
  nacimiento date,
  genero varchar(9),
  fecha_notificacion date,
  contenido_notificacion varchar(50),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at datetime DEFAULT NULL,
  CHECK (CHAR_LENGTH(contrasenia) >= 8 AND CHAR_LENGTH(contrasenia) <= 255),
  CHECK (correo LIKE '%@%'),
  CHECK (updated_at <= sysdate()),
  CHECK (updated_at >= created_at)
);

create table chat (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
contenido varchar(500), 
visto boolean,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at)
);

create table grupo (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
nombre varchar(50), 
descripcion varchar(255), 
foto varchar(50),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at)
);

create table comentario (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
contenido varchar(255), 
megusta varchar(4),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at)
);

create table post (
id int  UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
contenido varchar(255),  
megusta varchar(4), 
etiquetas varchar(30),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at)
);

create table perfil (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
estado varchar(25), 
pais varchar(50),
ciudad varchar(58), 
biografia varchar(255), 
redes varchar(255),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at) 
);

create table evento (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre varchar(255) not null, 
participan int, 
detalles varchar(255), 
fecha date not null, 
ubicacion varchar(184) not null, 
etiquetas varchar(30),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at)
);

create table lugar (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre varchar(255) not null, 
pais varchar(50), 
ciudad varchar(58), 
calle varchar(70), 
numero int, 
etiquetas varchar(30), 
multimedia varchar(255),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL, 
verificado boolean,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at)
);

CREATE TABLE megusta (
  id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  usuario_id int UNSIGNED NOT NULL,
  post_id int UNSIGNED,
  comentario_id int UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at datetime DEFAULT NULL,
  CHECK (updated_at <= sysdate()),
  CHECK (updated_at >= created_at),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id),
  FOREIGN KEY (post_id) REFERENCES post(id),
  FOREIGN KEY (comentario_id) REFERENCES comentario(id)
);

create table g_admin(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
grupo_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, grupo_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id)
);

create table g_crea(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
grupo_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, grupo_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id)
);

create table participa(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
grupo_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, grupo_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id)
);

create table tiene(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
grupo_id int UNSIGNED,
chat_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (grupo_id, chat_id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id),
FOREIGN KEY (chat_id) REFERENCES chat(id)
);

create table interactua(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id1 int UNSIGNED,
usuario_id2 int UNSIGNED,
chat_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id1, usuario_id2, chat_id),
FOREIGN KEY (usuario_id1) REFERENCES usuario(id),
FOREIGN KEY (usuario_id2) REFERENCES usuario(id),
FOREIGN KEY (chat_id) REFERENCES chat(id)
);

create table p_grupo(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
post_id int UNSIGNED,
grupo_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (post_id, grupo_id),
FOREIGN KEY (post_id) REFERENCES post(id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id)
);

create table p_evento(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
post_id int UNSIGNED,
evento_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (post_id, evento_id),
FOREIGN KEY (post_id) REFERENCES post(id),
FOREIGN KEY (evento_id) REFERENCES evento(id)
);

create table realiza(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
post_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, post_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (post_id) REFERENCES post(id)
);

create table publica(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
comentario_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, comentario_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (comentario_id) REFERENCES comentario(id)
);

create table c_evento(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
comentario_id int UNSIGNED,
evento_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (comentario_id, evento_id),
FOREIGN KEY (comentario_id) REFERENCES comentario(id),
FOREIGN KEY (evento_id) REFERENCES evento(id)
);

create table c_lugar(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
comentario_id int UNSIGNED,
lugar_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (comentario_id, lugar_id),
FOREIGN KEY (comentario_id) REFERENCES comentario(id),
FOREIGN KEY (lugar_id) REFERENCES lugar(id)
);

create table c_post(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
comentario_id int UNSIGNED,
post_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (comentario_id, post_id),
FOREIGN KEY (comentario_id) REFERENCES comentario(id),
FOREIGN KEY (post_id) REFERENCES post(id)
);

create table posee(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
perfil_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, perfil_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (perfil_id) REFERENCES perfil(id)
);

create table busca(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
lugar_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, lugar_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (lugar_id) REFERENCES lugar(id)
);

create table sugiere(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
lugar_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, lugar_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (lugar_id) REFERENCES lugar(id)
);

create table asiste(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
evento_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, evento_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (evento_id) REFERENCES evento(id)
);

create table e_crea(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id int UNSIGNED,
evento_id int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id, evento_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (evento_id) REFERENCES evento(id)
);

create table sigue(
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
usuario_id1 int UNSIGNED,
usuario_id2 int UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (updated_at <= sysdate()),
CHECK (updated_at >= created_at),
UNIQUE (usuario_id1, usuario_id2),
FOREIGN KEY (usuario_id1) REFERENCES usuario(id),
FOREIGN KEY (usuario_id2) REFERENCES usuario(id)
);


CREATE USER "administrador"@"127.0.0.1" IDENTIFIED BY 'contrasenia';
CREATE USER "moderador"@"127.0.0.1" IDENTIFIED BY 'contrasenia';
CREATE USER "usuario"@"127.0.0.1" IDENTIFIED BY 'contrasenia';

GRANT ALL PRIVILEGES ON uptoday.* TO "administrador"@"127.0.0.1";

grant select on uptoday.usuario to "usuario"@"127.0.0.1";
grant create, select on uptoday.chat to "usuario"@"127.0.0.1";
grant create, select on uptoday.grupo to "usuario"@"127.0.0.1";
grant create, select on uptoday.comentario to "usuario"@"127.0.0.1";
grant create, select on uptoday.post to "usuario"@"127.0.0.1";
grant select, create on uptoday.perfil to "usuario"@"127.0.0.1";
grant create, select on uptoday.evento to "usuario"@"127.0.0.1";

grant select on uptoday.lugar to "usuario"@"127.0.0.1";
grant select on uptoday.g_admin to "usuario"@"127.0.0.1";
grant select on uptoday.g_crea to "usuario"@"127.0.0.1";
grant select on uptoday.participa to "usuario"@"127.0.0.1";
grant select on uptoday.tiene to "usuario"@"127.0.0.1";
grant select on uptoday.p_grupo to "usuario"@"127.0.0.1";
grant select on uptoday.p_evento to "usuario"@"127.0.0.1";
grant select on uptoday.publica to "usuario"@"127.0.0.1";
grant select on uptoday.realiza to "usuario"@"127.0.0.1";
grant select on uptoday.c_evento to "usuario"@"127.0.0.1";
grant select on uptoday.c_post to "usuario"@"127.0.0.1";
grant select on uptoday.c_lugar to "usuario"@"127.0.0.1";
grant select on uptoday.posee to "usuario"@"127.0.0.1";
grant select on uptoday.busca to "usuario"@"127.0.0.1";
grant select on uptoday.asiste to "usuario"@"127.0.0.1";
grant select on uptoday.e_crea to "usuario"@"127.0.0.1";
grant select on uptoday.sigue to "usuario"@"127.0.0.1";

grant select on uptoday.usuario to "moderador"@"127.0.0.1";
grant select on uptoday.chat to "moderador"@"127.0.0.1";
grant select on uptoday.grupo to "moderador"@"127.0.0.1";
grant select on uptoday.comentario to "moderador"@"127.0.0.1";
grant select on uptoday.post to "moderador"@"127.0.0.1";
grant select on uptoday.perfil to "moderador"@"127.0.0.1";
grant select on uptoday.evento to "moderador"@"127.0.0.1";
grant select on uptoday.lugar to "moderador"@"127.0.0.1";
grant select on uptoday.g_admin to "moderador"@"127.0.0.1";
grant select on uptoday.g_crea to "moderador"@"127.0.0.1";
grant select on uptoday.participa to "moderador"@"127.0.0.1";
grant select on uptoday.tiene to "moderador"@"127.0.0.1";
grant select on uptoday.p_grupo to "moderador"@"127.0.0.1";
grant select on uptoday.p_evento to "moderador"@"127.0.0.1";
grant select on uptoday.publica to "moderador"@"127.0.0.1";
grant select on uptoday.realiza to "moderador"@"127.0.0.1";
grant select on uptoday.c_evento to "moderador"@"127.0.0.1";
grant select on uptoday.c_post to "moderador"@"127.0.0.1";
grant select on uptoday.c_lugar to "moderador"@"127.0.0.1";
grant select on uptoday.posee to "moderador"@"127.0.0.1";
grant select on uptoday.busca to "moderador"@"127.0.0.1";
grant select on uptoday.asiste to "moderador"@"127.0.0.1";
grant select on uptoday.e_crea to "moderador"@"127.0.0.1";

grant delete on uptoday.usuario to "moderador"@"127.0.0.1";
grant delete on uptoday.chat to "moderador"@"127.0.0.1";
grant delete on uptoday.grupo to "moderador"@"127.0.0.1";
grant delete on uptoday.comentario to "moderador"@"127.0.0.1";
grant delete on uptoday.post to "moderador"@"127.0.0.1";
grant delete on uptoday.perfil to "moderador"@"127.0.0.1";
grant delete on uptoday.evento to "moderador"@"127.0.0.1";
grant delete on uptoday.lugar to "moderador"@"127.0.0.1";
grant delete on uptoday.g_admin to "moderador"@"127.0.0.1";
grant delete on uptoday.g_crea to "moderador"@"127.0.0.1";
grant delete on uptoday.participa to "moderador"@"127.0.0.1";
grant delete on uptoday.tiene to "moderador"@"127.0.0.1";
grant delete on uptoday.p_grupo to "moderador"@"127.0.0.1";
grant delete on uptoday.p_evento to "moderador"@"127.0.0.1";
grant delete on uptoday.publica to "moderador"@"127.0.0.1";
grant delete on uptoday.realiza to "moderador"@"127.0.0.1";
grant delete on uptoday.c_evento to "moderador"@"127.0.0.1";
grant delete on uptoday.c_post to "moderador"@"127.0.0.1";
grant delete on uptoday.c_lugar to "moderador"@"127.0.0.1";
grant delete on uptoday.posee to "moderador"@"127.0.0.1";
grant delete on uptoday.busca to "moderador"@"127.0.0.1";
grant delete on uptoday.asiste to "moderador"@"127.0.0.1";
grant delete on uptoday.e_crea to "moderador"@"127.0.0.1";

START TRANSACTION;


INSERT INTO usuario (nombre, contrasenia, correo, nacimiento, fecha_notificacion, contenido_notificacion)
VALUES ('Carlos', 'password123', 'carlos@example.com', '1980-01-01', sysdate(), 'Notificación de prueba');

INSERT INTO usuario (nombre, contrasenia, correo, nacimiento, fecha_notificacion, contenido_notificacion)
VALUES ('Juan', 'password123', 'Juan@example.com', '1980-01-01', sysdate(), 'Notificación de prueba');

INSERT INTO chat (contenido, visto)
VALUES ('Hola, ¿cómo estás?', true);

INSERT INTO grupo (nombre, descripcion, foto)
VALUES ('Grupo de Prueba', 'Este es un grupo de prueba.', 'foto.png');

INSERT INTO comentario (contenido, megusta)
VALUES ('Este es un comentario de prueba', '10');

INSERT INTO post (contenido, created_at, megusta, etiquetas)
VALUES ('Este es un post de prueba', sysdate(), '5', 'prueba,post');

INSERT INTO perfil (estado, pais, ciudad, biografia, redes)
VALUES ('Activo', 'Uruguay', 'Montevideo', 'Biografía de prueba', 'Twitter, Facebook');

INSERT INTO evento (nombre, participan, detalles, fecha, ubicacion, etiquetas)
VALUES ('Evento de Prueba', 100, 'Detalles del evento', sysdate(), 'Montevideo', 'evento,prueba');

INSERT INTO lugar (nombre, pais, ciudad, calle, numero, etiquetas, multimedia, verificado)
VALUES ('Lugar de Prueba', 'Uruguay', 'Montevideo', 'Calle Falsa', 123, 'prueba,lugar', 'foto_lugar.png', true);


INSERT INTO g_admin (usuario_id, grupo_id)
VALUES (1, 1);

INSERT INTO g_crea (usuario_id, grupo_id)
VALUES (1, 1);

INSERT INTO participa (usuario_id, grupo_id)
VALUES (1, 1);

INSERT INTO tiene (grupo_id, chat_id)
VALUES (1, 1);

INSERT INTO interactua (usuario_id1,usuario_id2, chat_id)
VALUES (1, 2, 1);

INSERT INTO p_grupo (post_id, grupo_id)
VALUES (1, 1);

INSERT INTO p_evento (post_id, evento_id)
VALUES (1, 1);

INSERT INTO realiza (usuario_id, post_id)
VALUES (1, 1);

INSERT INTO publica (usuario_id, comentario_id)
VALUES (1, 1);

INSERT INTO c_evento (comentario_id, evento_id)
VALUES (1, 1);

INSERT INTO c_lugar (comentario_id, lugar_id)
VALUES (1, 1);

INSERT INTO c_post (comentario_id, post_id)
VALUES (1, 1);

INSERT INTO posee (usuario_id, perfil_id)
VALUES (1, 1);

INSERT INTO busca (usuario_id, lugar_id)
VALUES (1, 1);

INSERT INTO sugiere (usuario_id, lugar_id)
VALUES (1, 1);

INSERT INTO asiste (usuario_id, evento_id)
VALUES (1, 1);

INSERT INTO e_crea (usuario_id, evento_id)
VALUES (1, 1);

INSERT INTO sigue (usuario_id1, usuario_id2)
VALUES (1, 1);

COMMIT;

ROLLBACK;

 CREATE TABLE `admin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
);


INSERT INTO `admin`(id, name, email, email_verified_at, password,  remember_token, created_at, updated_at) VALUES (1,'usuario','usuario@usuario.com',NULL,'$2y$10$om5sEc.3.Gi9Uf6S9NU0DeY7u6rJO9YQDud3L9rC46TtD/ON35/6G',NULL,'2024-08-13 02:25:25','2024-08-13 02:25:25');

use uptoday;

-- vista para ver los post de usuarios

CREATE VIEW post_de_usuarios AS
SELECT 
    p.id AS post_id,
    p.contenido AS post_contenido,
    p.megusta AS post_megusta,
    p.etiquetas AS post_etiquetas,
    p.created_at AS post_creado_en,
    u.nombre AS usuario_nombre,
    u.correo AS usuario_correo
FROM 
    post AS p
JOIN 
    realiza AS r ON p.id = r.post_id
JOIN 
    usuario AS u ON r.usuario_id = u.id
ORDER BY 
    p.created_at DESC;
        
-- vista para ver los post de grupos
    
    CREATE VIEW post_de_grupo AS
SELECT 
    p.id AS post_id,
    p.contenido AS post_contenido,
    p.megusta AS post_megusta,
    p.etiquetas AS post_etiquetas,
    p.created_at AS post_creado_en,
    g.nombre AS grupo_nombre,
    g.descripcion AS grupo_descripcion
FROM 
    post AS p
JOIN 
    p_grupo AS pg ON p.id = pg.post_id
JOIN 
    grupo AS g ON pg.grupo_id = g.id
ORDER BY 
    p.created_at DESC;
    
    
    -- vista de los comentarios de un post
    
    CREATE VIEW comentario_de_post AS
SELECT 
    c.id AS comentario_id,
    c.contenido AS comentario_contenido,
    c.megusta AS comentario_megusta,
    c.created_at AS comentario_creado_en,
    u.nombre AS usuario_nombre,
    u.correo AS usuario_correo,
    p.contenido AS post_contenido,
    p.id AS post_id
FROM 
    comentario AS c
JOIN 
    publica AS pub ON c.id = pub.comentario_id
JOIN 
    usuario AS u ON pub.usuario_id = u.id
JOIN 
    c_post AS cp ON c.id = cp.comentario_id
JOIN 
    post AS p ON cp.post_id = p.id
ORDER BY 
    c.created_at DESC;