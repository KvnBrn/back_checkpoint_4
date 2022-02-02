CREATE TABLE category
(
  id   INT          NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Aventure'),
(2, 'Course'),
(3, 'FPS'),
(4, 'Gestion'),
(5, 'MMORPG'),
(6, 'Plate-forme'),
(7, 'Simulation'),
(8, 'Sport'),
(9, 'RPG'),
(10, 'Combat');

CREATE TABLE rate
(
  id     INT NOT NULL AUTO_INCREMENT,
  number INT NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO `rate` (`id`, `number`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

CREATE TABLE user
(
  id       INT          NOT NULL AUTO_INCREMENT,
  email    VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  is_admin BOOLEAN      NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

INSERT INTO `user` (`id`, `email`, `password`, `is_admin`) VALUES
(1, 'test@test.com', 'password', 1);

CREATE TABLE video_game
(
  id          INT          NOT NULL AUTO_INCREMENT,
  name        VARCHAR(255) NOT NULL,
  image       VARCHAR(255) NOT NULL,
  description LONGTEXT NOT NULL,
  id_rate     INT          NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO `video_game` (`id`, `name`, `image`, `description`, `id_rate`) VALUES
(1, 'Final Fantasy VII', 'https://upload.wikimedia.org/wikipedia/fr/thumb/c/ce/Final_Fantasy_VII_Logo.svg/langfr-1024px-Final_Fantasy_VII_Logo.svg.png', 'L’histoire du jeu, dans une perspective eschatologique, est centrée sur le combat d’un groupe éco-terroriste nommé «Avalanche» contre une puissante organisation appelée la «Shinra», qui exploite jusqu à épuisement l énergie vitale de la planète pour produire de l énergie et des armes.', 10),
(2, 'World of Warcraft', 'https://upload.wikimedia.org/wikipedia/fr/thumb/e/e3/World_of_Warcraft_Logo.png/800px-World_of_Warcraft_Logo.png', 'Le jeu reprend place dans le monde imaginaire d’Azeroth, et dont le cadre historique se situe quatre ans après les évènements concluant Warcraft III. Le joueur choisit son personnage parmi douze races disponibles divisées en deux factions : l’Alliance et la Horde.', 10);

CREATE TABLE video_game_category
(
  id            INT NOT NULL AUTO_INCREMENT,
  id_category   INT NOT NULL,
  id_video_game INT NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE video_game_category
  ADD CONSTRAINT FK_category_TO_video_game_category
    FOREIGN KEY (id_category)
    REFERENCES category (id);

ALTER TABLE video_game_category
  ADD CONSTRAINT FK_video_game_TO_video_game_category
    FOREIGN KEY (id_video_game)
    REFERENCES video_game (id);

ALTER TABLE video_game
  ADD CONSTRAINT FK_rate_TO_video_game
    FOREIGN KEY (id_rate)
    REFERENCES rate (id);

INSERT INTO `video_game_category` (`id`, `id_category`, `id_video_game`) VALUES
(1, 1, 9),
(2, 2, 5);
