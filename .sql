CREATE DATABASE Alphabet; 
USE Alphabet;
CREATE TABLE E1Video (
    id_videos INT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(200),
    date_upload INT NOT NULL ,
    likes INT DEFAULT 0,
    dislikes INT DEFAULT 0,
    user_fk TEXT,
    genre_fk INT,
    channel_fk INT
);
INSERT INTO E1Video (id_videos, name, description, date_upload, user_fk, genre_fk, channel_fk)
VALUES
    (1, 'Video1', 'Descripción del video 1', 1678923456, 'user1', 1, 1),
    (2, 'Video2', 'Descripción del video 2', 1678923457, 'user2', 2, 2),
    (10, 'Video10', 'Descripción del video 10', 1678923465, 'user3', 3, 3);

CREATE TABLE E2Comment (
    id_comment INT PRIMARY KEY NOT NULL,
    content VARCHAR(100) NOT NULL,
    date_creation VARCHAR(200),
    likes INT DEFAULT 0,
    dislikes INT DEFAULT 0,
    User_fk TEXT,
    video_fk INT
);
INSERT INTO E2Comment (id_comment, content, date_creation, User_fk, video_fk)
VALUES
    (1, 'Comentario 1', '2024-05-21', 'user1', 1),
    (2, 'Comentario 2', '2024-05-22', 'user2', 2),
    (5, 'Comentario 5', '2024-05-25', 'user3', 3);
    
CREATE TABLE E3Playlist  (
    id_playlist INT PRIMARY KEY NOT NULL,
    name VARCHAR(30) NOT NULL,
    likes INT DEFAULT 0,
    User_fk INT
);
INSERT INTO E3Playlist (id_playlist, name, likes, User_fk)
VALUES
    (1, 'Lista1', 10, 1),
    (2, 'Lista2', 5, 2),
    (5, 'Lista5', 8, 3);
    
CREATE TABLE E4User (
    id_nombre INT PRIMARY KEY NOT NULL,
    name VARCHAR(30),
    email VARCHAR(30),
    phone VARCHAR(50),
    nickname VARCHAR(20) UNIQUE NOT NULL,
    password VARCHAR(30) NOT NULL,
    musical_genre_fk INT NOT NULL,
    country_fk INT NOT NULL
);
INSERT INTO E4User (id_nombre, name, email, phone, nickname, password, musical_genre_fk, country_fk)
VALUES
    (1, 'Usuario1', 'usuario1@email.com', '1234567890', 'user1', 'contraseña1', 1, 1),
    (2, 'Usuario2', 'usuario2@email.com', '9876543210', 'user2', 'contraseña2', 2, 2),
    (10, 'Usuario10', 'usuario10@email.com', '5555555555', 'user3', 'contraseña3', 3, 3);
    
CREATE TABLE E5community  (
    id_community INT PRIMARY KEY NOT NULL,
    name VARCHAR(25) UNIQUE NOT NULL,
    description VARCHAR(200)
);
INSERT INTO E5community (id_community, name, description)
VALUES
    (1, 'Comunidad1', 'Descripción de la comunidad 1'),
    (2, 'Comunidad2', 'Descripción de la comunidad 2'),
    (5, 'Comunidad5', 'Descripción de la comunidad 5');
CREATE TABLE E6channel  (
    id_channel INT PRIMARY KEY NOT NULL,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(200),
    user_fk TEXT
);
INSERT INTO E6channel (id_channel, name, description, user_fk)
VALUES
    (1, 'Canal1', 'Descripción del canal 1', 'user1'),
    (2, 'Canal2', 'Descripción del canal 2', 'user2'),
    (5, 'Canal5', 'Descripción del canal 5', 'user3');
CREATE TABLE E7MusicalGenre  (
    id_genre INT PRIMARY KEY NOT NULL,
    name VARCHAR(15) NOT NULL,
    description VARCHAR(100)
);
INSERT INTO E7MusicalGenre (id_genre, name, description)
VALUES
    (1, 'Rock', 'Descripción del género Rock'),
    (2, 'Pop', 'Descripción del género Pop'),
    (5, 'Electrónica', 'Descripción del género Electrónica');
CREATE TABLE E8BackAccount (
    UniqueID INT PRIMARY KEY NOT NULL,
    bank_name VARCHAR(30),
    account_number INT,
    country_fk INT,
    user_fk INT
);
INSERT INTO E8BackAccount (UniqueID, bank_name, account_number, country_fk, user_fk)
VALUES
    (1, 'Banco1', '123456789', 1, 'user1'),
    (2, 'Banco2', '987654321', 2, 'user2'),
    (5, 'Banco5', '555555555', 3, 'user3');
CREATE TABLE  E9Country (
    codes  INT PRIMARY KEY NOT NULL,
    name VARCHAR(25) UNIQUE NOT NULL
);
INSERT INTO E9Country (code, name)
VALUES
    (1, 'País1'),
    (2, 'País2'),
    (5, 'País5');

CREATE TABLE Playlist_Video_REL  (
    playlist_fk INT,
    video_fk INT
);
INSERT INTO Playlist_Video_REL (playlist_fk, video_fk)
VALUES
    (1, 1), 
    (1, 2), 
    (2, 3); 
CREATE TABLE community_user_REL  (
    community_fk INT,
    user_fk TEXT
);

INSERT INTO community_user_REL (community_fk, user_fk)
VALUES
    (1, 'user1'), 
    (1, 'user2'),
    (2, 'user3'); 
CREATE TABLE subscriber_REL  (
    id_channel INT PRIMARY KEY NOT NULL,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(200),
    user_fk TEXT
);
INSERT INTO subscriber_REL (id_channel, name, description, user_fk)
VALUES
    (1, 'Canal1', 'Descripción del canal 1', 'user1'),
    (2, 'Canal2', 'Descripción del canal 2', 'user2'),
    (3, 'Canal3', 'Descripción del canal 3', 'user3');


SELECT v.*
FROM E1Video v
INNER JOIN E4User u ON v.user_fk = u.nickname
WHERE u.country_fk = 1;

SELECT g.name AS genre, COUNT(v.id_videos) AS video_count
FROM E1Video v
INNER JOIN E7MusicalGenre g ON v.genre_fk = g.id_genre
GROUP BY g.name;

SELECT v.*, u.name AS user_name, u.email AS user_email
FROM E1Video v
INNER JOIN E4User u ON v.user_fk = u.nickname
WHERE v.likes > 20;

SELECT DISTINCT c.*
FROM E6channel c
INNER JOIN subscriber_REL s ON c.id_channel = s.id_channel
INNER JOIN E4User u ON c.user_fk = u.nickname
WHERE u.country_fk = 1;

SELECT c.*, u.name AS user_name, v.name AS video_name
FROM E2Comment c
INNER JOIN E4User u ON c.User_fk = u.nickname
INNER JOIN E1Video v ON c.video_fk = v.id_videos
WHERE c.content LIKE '%feo%';

SELECT u.*, b.*, g.name AS genre_name
FROM E4User u
LEFT JOIN E8BackAccount b ON u.id_nombre = b.user_fk
LEFT JOIN E7MusicalGenre g ON u.musical_genre_fk = g.id_genre
WHERE u.country_fk = 1
ORDER BY u.email
LIMIT 3;

ALTER TABLE E1Video ADD COLUMN Popular BOOLEAN DEFAULT FALSE;

UPDATE E1Video
SET Popular = TRUE
WHERE likes > 20;



