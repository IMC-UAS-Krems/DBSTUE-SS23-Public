PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE Person (
name VARCHAR(255),
age UNSIGNED INT NOT NULL CHECK (age < 130),
gender CHAR CHECK (gender IN ("M", "F", "O")),
PRIMARY KEY(name)
);
INSERT INTO Person VALUES('Alessio',42,'M');
INSERT INTO Person VALUES('Gigi',16,'F');
CREATE TABLE Frequents (
name VARCHAR(255) NOT NULL,
pizzeria VARCHAR(255) NOT NULL,
PRIMARY KEY(name, pizzeria),
FOREIGN KEY (name) REFERENCES Person(name)
);
INSERT INTO Frequents VALUES('Alessio','mammamia');
INSERT INTO Frequents VALUES('Gigi','domino');
INSERT INTO Frequents VALUES('Alessio','corleone');
CREATE TABLE Eats(
name VARCHAR(255) NOT NULL,
pizza VARCHAR(255) NOT NULL,
PRIMARY KEY(name, pizza),
FOREIGN KEY (name) REFERENCES Person(name)
);
INSERT INTO Eats VALUES('Alessio','pepperoni');
INSERT INTO Eats VALUES('Gigi','margherita');
INSERT INTO Eats VALUES('Alessio','mushrooms');
INSERT INTO Eats VALUES('Gigi','mushrooms');
CREATE TABLE Serves(
pizzeria VARCHAR(255) NOT NULL,
pizza VARCHAR(255) NOT NULL,
price NUMERIC(10,2) NOT NULL CHECK (price > 0),
PRIMARY KEY(pizzeria, pizza)
);
INSERT INTO Serves VALUES('mammamia','pepperoni',10);
INSERT INTO Serves VALUES('domino','margherita',6);
INSERT INTO Serves VALUES('domino','mushrooms',6);
INSERT INTO Serves VALUES('pizzeria','pepperoni',8);
INSERT INTO Serves VALUES('corleone','pepperoni',8);
INSERT INTO Serves VALUES('corleone','mushrooms',5);
COMMIT;

