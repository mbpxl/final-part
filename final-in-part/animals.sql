use animals;
CREATE TABLE cats
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
INSERT INTO cats (name, an_type, birthday, color, commands)
VALUES
	('Raphail', 'cat', '2001-01-15', 'gray', 'кис-кис, брысь'),
    ('Murka', 'cat', '2021-07-03', 'white', 'кис-кис, брысь'),
    ('Pushok', 'cat', '2013-02-18', 'black', 'кис-кис, брысь');
    
CREATE TABLE dogs
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
INSERT INTO dogs (name, an_type, birthday, color, commands)
VALUES
	('Grom', 'dog', '2021-11-15', 'brown', 'сидеть, лежать, апорт'),
    ('Barbos', 'dog', '2021-08-03', 'white', 'сидеть, лежать, апорт, голос'),
    ('Tilda', 'dog', '2022-03-19', 'black', 'сидеть, лежать, апорт, голос');
    
CREATE TABLE rats
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
INSERT INTO rats (name, an_type, birthday, color, commands)
VALUES
	('Busina', 'rat', '2018-12-17', 'gray', 'гулять'),
    ('Lariska', 'rat', '2020-06-13', 'white', ''),
    ('Stepan', 'rat', '2023-10-19', 'black', '');
    
CREATE TABLE horses
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
INSERT INTO horses (name, an_type, birthday, color, commands)
VALUES
	('Vezuchiy', 'horse', '2018-12-12', 'gray', 'шагом аллюр галоп'),
    ('Lambda', 'horse', '2021-09-13', 'white', 'ко_мне шагом аллюр галоп'),
    ('Rossinant', 'horse', '2023-05-21', 'black', 'шагом аллюр галоп');
    
CREATE TABLE camels
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
INSERT INTO camels (name, an_type, birthday, color, commands)
VALUES
	('Miha', 'camel', '2018-12-14', 'gray', 'лежать встать пошел'),
    ('Vasia', 'camel', '2021-09-25', 'white', 'лежать встать пошел'),
    ('Truck', 'camel', '2023-08-21', 'black', 'лежать встать пошел');
    
CREATE TABLE donkeys
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
INSERT INTO donkeys (name, an_type, birthday, color, commands)
VALUES
	('Biba', 'donkey', '2019-12-17', 'gray', 'лежать встать пошел'),
    ('Boba', 'donkey', '2022-09-14', 'gray', 'лежать встать пошел'),
    ('Vizir', 'donkey', '2013-11-24', 'black', 'лежать встать пошел');
    
-- объединение таблиц cats, rats и dogs в таблицу pets
CREATE TABLE pets
(
    id INT AUTO_INCREMENT,
    an_type VARCHAR(10),
    name VARCHAR(20),
    birthday DATE,
    color VARCHAR(20),
    commands VARCHAR(50),
    PRIMARY KEY (id)
);

INSERT INTO pets (an_type, name, birthday, color, commands)
SELECT an_type, name, birthday, color, commands FROM cats
UNION
SELECT an_type, name, birthday, color, commands FROM dogs
UNION
SELECT an_type, name, birthday, color, commands FROM rats;

-- объединение таблиц cats, rats и dogs в таблицу pets
CREATE TABLE pack_animals
(
    id INT AUTO_INCREMENT,
    an_type VARCHAR(10),
    name VARCHAR(20),
    birthday DATE,
    color VARCHAR(20),
    commands VARCHAR(50),
    PRIMARY KEY (id)
);

/*
10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.
*/
-- объединение всех вьючных в одну таблицу
INSERT INTO pack_animals (an_type, name, birthday, color, commands)
SELECT an_type, name, birthday, color, commands FROM horses
UNION
SELECT an_type, name, birthday, color, commands FROM camels
UNION
SELECT an_type, name, birthday, color, commands FROM donkeys;

-- удаляем верблюдов из таблицы вьючных животных
DELETE FROM pack_animals WHERE an_type = 'camel';

/*
12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на
прошлую принадлежность к старым таблицам.
*/
-- общая таблица всей скотины ---------------------------------------------
CREATE TABLE animals
(
    id INT AUTO_INCREMENT,
    name VARCHAR(20),
    birthday DATE,
    color VARCHAR(20),
    commands VARCHAR(50),
    type VARCHAR(10),
    PRIMARY KEY (id)
);

INSERT INTO animals (name, birthday, color, commands, type)
SELECT name, birthday, color, commands, 'cats' FROM cats
UNION
SELECT name, birthday, color, commands, 'dogs' FROM dogs
UNION
SELECT name, birthday, color, commands, 'rats' FROM rats
UNION
SELECT name, birthday, color, commands, 'horses' FROM horses
UNION
SELECT name, birthday, color, commands, 'camels' FROM camels
UNION
SELECT name, birthday, color, commands, 'dokeys' FROM donkeys;

/* 
11.Создать новую таблицу “молодые животные” в которую попадут все
животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
до месяца подсчитать возраст животных в новой таблице
*/
CREATE TABLE young_animals
	(
		id INT AUTO_INCREMENT,
		name VARCHAR(20),
		birthday DATE,
		color VARCHAR(20),
		commands VARCHAR(50),
		type VARCHAR(10),
		age DECIMAL,
		PRIMARY KEY (id)
    );
INSERT INTO young_animals (name, birthday, color, commands, type, age)
SELECT name, birthday, color, commands, 'cats', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM cats WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'dogs', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM dogs WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'rats', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM rats WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'horses', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM horses WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'camels', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM camels WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'donkeys', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM donkeys WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3);

