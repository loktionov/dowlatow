SET NAMES 'utf8';

-- 
-- Установка базы данных по умолчанию
--
USE dowlatow;

--
-- Описание для таблицы categories
--
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы articles
--
DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 10
AVG_ROW_LENGTH = 1820
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы articles_categories
--
DROP TABLE IF EXISTS articles_categories;
CREATE TABLE articles_categories (
  id INT(11) NOT NULL AUTO_INCREMENT,
  article_id INT(11) DEFAULT NULL,
  category_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_articles_categories_article FOREIGN KEY (article_id)
    REFERENCES articles(id) ON DELETE NO ACTION ON UPDATE RESTRICT,
  CONSTRAINT FK_articles_categories_categor FOREIGN KEY (category_id)
    REFERENCES categories(id) ON DELETE NO ACTION ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 10
AVG_ROW_LENGTH = 1820
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

-- 
-- Вывод данных для таблицы articles
--
INSERT INTO articles VALUES
(1, 'статья1'),
(2, 'статья2'),
(3, 'статья3'),
(4, 'статья4'),
(5, 'статья5'),
(6, 'статья6'),
(7, 'статья7'),
(8, 'статья8'),
(9, 'статья6');

-- 
-- Вывод данных для таблицы articles_categories
--
INSERT INTO articles_categories VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 3),
(8, 8, 3),
(9, 9, 3);

-- 
-- Вывод данных для таблицы categories
--
INSERT INTO categories VALUES
(1, 'категория1'),
(2, 'категория2'),
(3, 'категория3');

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;