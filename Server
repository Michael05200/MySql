CREATE DATABASE IF NOT EXISTS progetto_units;

USE progetto_units;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id_utente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_utente VARCHAR(255),
    email_utente VARCHAR(255),
    password_utente VARCHAR(255),
    data_nascita DATE
);

INSERT INTO users (nome_utente, email_utente, password_utente, data_nascita)
VALUES
    ('Nome1', 'email1@example.com', 'password1', '1990-01-01'),
    ('Nome2', 'email2@example.com', 'password2', '1991-02-02'),
    ('Nome3', 'email3@example.com', 'password3', '1992-03-03');


DROP TABLE IF EXISTS acquisti;

CREATE TABLE acquisti (
    id_acquisto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_utente INT,
    id_prodotto INT,
    data_acquisto DATE
);

INSERT INTO acquisti (id_utente, id_prodotto, data_acquisto)
VALUES
    (1, 1, '2023-01-01'),
    (1, 2, '2023-02-02'),
    (2, 1, '2023-03-03'),
    (2, 2, '2023-04-04');


ALTER TABLE acquisti
ADD COLUMN esito BOOLEAN;

 DROP TABLE IF EXISTS lista_desideri;

CREATE TABLE lista_desideri (
    id_lista INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_utente INT,
    id_prodotto INT
);

 DROP TABLE IF EXISTS game;

CREATE TABLE games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    genere VARCHAR(255) NOT NULL,
    release_date DATE
);

 DROP TABLE IF EXISTS community;

CREATE TABLE community (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

 DROP TABLE IF EXISTS moderators;

CREATE TABLE moderators (
    id int AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id_utente)
    -- Aggiungere altri campi specifici per i moderatori
);

SET @id_utente = 1;
SET @id_prodotto = 2;
SET @data_acquisto = '2023-06-07';

INSERT INTO acquisti (id_utente, id_prodotto, data_acquisto)
SELECT * FROM (SELECT @id_utente, @id_prodotto, @data_acquisto) AS tmp
WHERE NOT EXISTS (
    SELECT 1
    FROM acquisti a
    WHERE a.id_utente = @id_utente AND a.id_prodotto = @id_prodotto
);

  -- per raccogliere l'email per venderle a terzi etc.

DELIMITER //
CREATE PROCEDURE get_emails(OUT emails TEXT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE email VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT email_utente FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET emails = '';

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO email;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET emails = CONCAT(emails, email, ';');
    END LOOP;

    CLOSE cur;
END//
DELIMITER ;
	
CALL get_emails(@emails);
SELECT @emails;

-- per raccogliere tutti gli acquisti fatti dall'apertura del sito

DELIMITER //
CREATE PROCEDURE get_all_purchases()
BEGIN
    SELECT * FROM acquisti;
END//
DELIMITER ;

CALL get_all_purchases();


-- per verificare quantità acquisti di gioco

CALL get_game_purchases(1, @purchase_count);
SELECT @purchase_count;

-- per verificare la lista dei desideri di quel gioco in termine di quantità

DELIMITER //
CREATE PROCEDURE get_game_wishlist(IN game_id INT, OUT wishlist_count INT)
BEGIN
    SELECT COUNT(DISTINCT id_utente) INTO wishlist_count
    FROM lista_desideri
    WHERE id_prodotto = game_id;
END//
DELIMITER ;

CALL get_game_wishlist(1, @wishlist_count);
SELECT @wishlist_count;

-- store procedure per vedere una lista desideri completa di un user qualsiasi
DELIMITER //
CREATE PROCEDURE get_user_wishlist(IN user_id INT)
BEGIN
    SELECT id_prodotto
    FROM lista_desideri
    WHERE id_utente = user_id;
END//
DELIMITER ;

CALL get_user_wishlist(1);

DELIMITER //
CREATE PROCEDURE get_game_purchases(IN game_id INT, OUT purchase_count INT)
BEGIN
    SELECT COUNT(*) INTO purchase_count
    FROM acquisti
    WHERE id_prodotto = game_id;
END//
DELIMITER ;

CALL get_game_purchases(1, @purchase_count);
SELECT @purchase_count;


