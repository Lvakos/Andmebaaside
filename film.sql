CREATE DATABASE filmidPuhtejev;
use filmidPuhtejev;

--tabeli rezisoor loomine

CREATE TABLE rezisoor(
rezisoorID int PRIMARY KEY identity(1,1),
eesnimi varchar(20),
perenimi varchar(20) UNIQUE,
synniaasta int,
);

-- tabeli täitmine
INSERT INTO rezisoor(eesnimi, perenimi, synniaasta)
VALUES ('James', 'Cemeron', 1987),
('Alfred', 'Hitchcock', 1899),
('Stanley', 'Kubrick', 1928),
('Martin', 'Scorsese', 1942),
('Steven', 'Spielberg', 1946);

-- tabeli film loomine
CREATE TABLE film(
filmID int PRIMARY KEY identity(1,1),
filmNimetus varchar(100),
pikkus int,
rezisoorID int, 
FOREIGN KEY (rezisoorID) REFERENCES rezisoor(rezisoorID),
v_aasta int CHECK(v_aasta<2027)
);

Select * from film;
Select * from rezisoor;

Insert into film(filmNimetus, rezisoorID, pikkus, v_aasta)
Values('Titanic', 1, 195, 1997),
('Goodfellas', 4, 145, 1990),
('2001: A Space Oddysey', 3, 160, 1968),
('Schindler´s List', 5, 195, 1997),
('Psycho', 2, 109, 1960);
