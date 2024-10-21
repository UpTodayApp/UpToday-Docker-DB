DROP DATABASE IF EXISTS uptoday;
DROP USER IF EXISTS administrador@127.0.0.1;
DROP USER IF EXISTS moderador@127.0.0.1;
DROP USER IF EXISTS usuario@127.0.0.1;
CREATE DATABASE uptoday CHARSET df8mb4-0900_ai_ci;
USE uptoday;

create table usuario (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre varchar(15), 
contrasenia varchar(16),
correo varchar(255), 
nacimiento date, 
fecha_notificacion date,
contenido_notificacion varchar(50),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (nacimiento < sysdate() - INTERVAL 18 YEAR),
CHECK (CHAR_LENGTH(contrasenia) >= 8 AND CHAR_LENGTH(contrasenia) <= 16),
CHECK (fecha_notificacion = sysdate())
);

create table chat (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
contenido varchar(500), 
visto boolean,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (fecha = sysdate())
);

create table grupo (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
nombre varchar(50), 
descripcion varchar(255), 
foto varchar(50),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL
);

create table comentario (
id int UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
contenido varchar(255), 
megusta varchar(4),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
);

create table post (
id int  UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
contenido varchar(255), 
fecha date, 
megusta varchar(4), 
etiquetas varchar(30),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at datetime DEFAULT NULL,
CHECK (fecha = sysdate())
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
deleted_at datetime DEFAULT NULL 
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
CHECK (fecha = sysdate())
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
verificado boolean
);

create table g_admin(
usuario_id int UNSIGNED,
grupo_id int UNSIGNED,
PRIMARY KEY (usuario_id, grupo_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id)
);

create table g_crea(
usuario_id int UNSIGNED,
grupo_id int UNSIGNED,
PRIMARY KEY (usuario_id, grupo_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id)
);

create table participa(
usuario_id int UNSIGNED,
grupo_id int UNSIGNED,
PRIMARY KEY (usuario_id, grupo_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id)
);

create table tiene(
grupo_id int UNSIGNED,
chat_id int UNSIGNED,
PRIMARY KEY (grupo_id, chat_id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id),
FOREIGN KEY (chat_id) REFERENCES chat(id)
);

create table interactua(
usuario_id int UNSIGNED,
chat_id int UNSIGNED,
PRIMARY KEY (usuario_id, chat_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (chat_id) REFERENCES chat(id)
);

create table p_grupo(
post_id int UNSIGNED,
grupo_id int UNSIGNED,
PRIMARY KEY (post_id, grupo_id),
FOREIGN KEY (post_id) REFERENCES post(id),
FOREIGN KEY (grupo_id) REFERENCES grupo(id)
);

create table p_evento(
post_id int UNSIGNED,
evento_id int UNSIGNED,
PRIMARY KEY (post_id, evento_id),
FOREIGN KEY (post_id) REFERENCES post(id),
FOREIGN KEY (evento_id) REFERENCES evento(id)
);

create table realiza(
usuario_id int UNSIGNED,
post_id int UNSIGNED,
PRIMARY KEY (usuario_id, post_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (post_id) REFERENCES post(id)
);

create table publica(
usuario_id int UNSIGNED,
comentario_id int UNSIGNED,
PRIMARY KEY (usuario_id, comentario_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (comentario_id) REFERENCES comentario(id)
);

create table c_evento(
comentario_id int UNSIGNED,
evento_id int UNSIGNED,
PRIMARY KEY (comentario_id, evento_id),
FOREIGN KEY (comentario_id) REFERENCES comentario(id),
FOREIGN KEY (evento_id) REFERENCES evento(id)
);

create table c_lugar(
comentario_id int UNSIGNED,
lugar_id int UNSIGNED,
PRIMARY KEY (comentario_id, lugar_id),
FOREIGN KEY (comentario_id) REFERENCES comentario(id),
FOREIGN KEY (lugar_id) REFERENCES lugar(id)
);

create table c_post(
comentario_id int UNSIGNED,
post_id int UNSIGNED,
PRIMARY KEY (comentario_id, post_id),
FOREIGN KEY (comentario_id) REFERENCES comentario(id),
FOREIGN KEY (post_id) REFERENCES post(id)
);

create table posee(
usuario_id int UNSIGNED,
perfil_id int UNSIGNED,
PRIMARY KEY (usuario_id, perfil_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (perfil_id) REFERENCES perfil(id)
);

create table busca(
usuario_id int UNSIGNED,
lugar_id int UNSIGNED,
PRIMARY KEY (usuario_id, lugar_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (lugar_id) REFERENCES lugar(id)
);

create table sugiere(
usuario_id int UNSIGNED,
lugar_id int UNSIGNED,
PRIMARY KEY (usuario_id, lugar_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (lugar_id) REFERENCES lugar(id)
);

create table asiste(
usuario_id int UNSIGNED,
evento_id int UNSIGNED,
PRIMARY KEY (usuario_id, evento_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (evento_id) REFERENCES evento(id)
);

create table e_crea(
usuario_id int UNSIGNED,
evento_id int UNSIGNED,
PRIMARY KEY (usuario_id, evento_id),
FOREIGN KEY (usuario_id) REFERENCES usuario(id),
FOREIGN KEY (evento_id) REFERENCES evento(id)
);

create table sigue(
usuario_id1 int UNSIGNED,
usuario_id2 int UNSIGNED,
PRIMARY KEY (usuario_id1, usuario_id2),
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
VALUES ('Carlos', 'password123', 'carlos@example.com', '1980-01-01', CURDATE(), 'Notificación de prueba');

INSERT INTO chat (contenido, visto)
VALUES ('Hola, ¿cómo estás?', true);

INSERT INTO grupo (nombre, descripcion, foto)
VALUES ('Grupo de Prueba', 'Este es un grupo de prueba.', 'foto.png');

INSERT INTO comentario (contenido, megusta)
VALUES ('Este es un comentario de prueba', '10');

INSERT INTO post (contenido, fecha, megusta, etiquetas)
VALUES ('Este es un post de prueba', CURDATE(), '5', 'prueba,post');

INSERT INTO perfil (estado, pais, ciudad, biografia, redes)
VALUES ('Activo', 'Uruguay', 'Montevideo', 'Biografía de prueba', 'Twitter, Facebook');

INSERT INTO evento (nombre, participan, detalles, fecha, ubicacion, etiquetas)
VALUES ('Evento de Prueba', 100, 'Detalles del evento', CURDATE(), 'Montevideo', 'evento,prueba');

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

INSERT INTO interactua (usuario_id, chat_id)
VALUES (1, 1);

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
VALUES (1, 2);

COMMIT;

ROLLBACK;