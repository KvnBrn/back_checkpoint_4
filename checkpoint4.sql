CREATE TABLE category
(
  id   INT          NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE user
(
  id       INT          NOT NULL AUTO_INCREMENT,
  email    VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  is_admin BOOLEAN      NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

CREATE TABLE video_game
(
  id          INT          NOT NULL AUTO_INCREMENT,
  name        VARCHAR(255) NOT NULL,
  image       VARCHAR(255) NOT NULL,
  description LONGTEXT     NOT NULL,
  rate        INT          NOT NULL,
  PRIMARY KEY (id)
);

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
(10, 'Combat'),
(11, 'Stratégie');

INSERT INTO `user` (`id`, `email`, `password`, `is_admin`) VALUES
(1, 'test@test.com', 'password', 1);

INSERT INTO `video_game` (`id`, `name`, `image`, `description`, `rate`) VALUES
(1, 'Final Fantasy VII', 'https://upload.wikimedia.org/wikipedia/fr/thumb/c/ce/Final_Fantasy_VII_Logo.svg/langfr-1024px-Final_Fantasy_VII_Logo.svg.png', 'L’histoire du jeu, dans une perspective eschatologique, est centrée sur le combat d’un groupe éco-terroriste nommé «Avalanche» contre une puissante organisation appelée la «Shinra», qui exploite jusqu à épuisement l énergie vitale de la planète pour produire de l énergie et des armes.', 10),
(2, 'World of Warcraft', 'https://upload.wikimedia.org/wikipedia/fr/thumb/e/e3/World_of_Warcraft_Logo.png/800px-World_of_Warcraft_Logo.png', 'Le jeu reprend place dans le monde imaginaire d’Azeroth, et dont le cadre historique se situe quatre ans après les évènements concluant Warcraft III. Le joueur choisit son personnage parmi douze races disponibles divisées en deux factions : l’Alliance et la Horde.', 10),
(3, 'Animal Crossing : New Horizons', 'https://upload.wikimedia.org/wikipedia/fr/7/7f/Logo-acnh.png', 'Animal Crossing : New Horizons est un jeu vidéo de simulation de vie.', 8.5),
(4, 'Detroit : Becaume Human', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Detroit-become-human-logo.png/1024px-Detroit-become-human-logo.png', 'En 2038, dans la ville de Détroit aux États-Unis, les androïdes partagent le quotidien des êtres humains en étant à leur service5. Kara, un androïde d intérieur, est confiée à un homme détruit, mais aussi drogué, alcoolique et violent. Connor, un autre androïde à l état de prototype, est négociateur et enquêteur dans la police. Il est désigné pour être le partenaire de Hank dans les enquêtes sur les déviants6. Markus est un androïde d intérieur prenant soin d un peintre riche et célèbre mais en fin de vie.', 9.5)
(5, "Légendes Pokémon : Arceus", "https://upload.wikimedia.org/wikipedia/fr/thumb/8/8c/Pokemon_Legends_Arceus_logo_FR.png/1024px-Pokemon_Legends_Arceus_logo_FR.png", "Légendes Pokémon : Arceus se déroule durant une période révolue de l'histoire de Sinnoh, dans la région de Hisui (ancien nom de Sinnoh). Le but du joueur est de créer et compléter le tout premier Pokédex de la région, en parcourant les rudes environnements de cette dernière à l'aide de son premier partenaire Pokémon choisi entre Brindibou, Héricendre et Moustillon.", 9),
(6, "Assassin's Creed Valhalla", "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Assassin%27s_Creed_Valhalla_text_logo.svg/langfr-1280px-Assassin%27s_Creed_Valhalla_text_logo.svg.png", "Assassin's Creed Valhalla prend place à la fin du IXe siècle dans le cadre des raids vikings en Angleterre. Le joueur incarne Eivor Varinsdottir , un viking qui mène ses camarades de Norvège dans des raids et des combats contre le roi Alfred le Grand et les quatre royaumes anglo-saxons : Wessex, Northumbrie, Est-Anglie et Mercie. Assassin’s Creed Valhalla a été conçue depuis le début avec cette notion de héros masculin ou féminin. Vous pouvez donc choisir une version homme ou femme.", 9),
(7, "Sekiro: Shadows Die Twice", "https://upload.wikimedia.org/wikipedia/fr/2/23/Sekiro_Shadows_Die_Twice_Logo.png", "Le jeu se déroule dans un Japon médiéval-fantastique durant l'époque Sengoku. Il est inspiré de la trilogie Dark Souls, Demon's Souls ou encore Bloodborne de par le gameplay et les mécaniques de combats.", 9),
(8, "Teamfight Tactics", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/TFT_new.png/1280px-TFT_new.png", "Teamfight Tactics (abrégé TFT) est un jeu vidéo de type auto battler développé et édité par Riot Games. Il prend place dans l'univers de League of Legends et est basé sur le jeu Dota Auto Chess, où le joueur affronte sept adversaires en ligne, qu'il doit combattre en formant une équipe afin d'être le dernier à rester en vie.", 8);

INSERT INTO `video_game_category` (`id`, `id_category`, `id_video_game`) VALUES
(1, 9, 1),
(2, 5, 2),
(3, 7, 3),
(4, 1, 4);
(5, 9, 5),
(6, 1, 6),
(7, 1, 7),
(8, 11, 8),
(9, 1, 5);
