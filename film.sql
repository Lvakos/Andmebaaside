CREATE DATABASE filmidPuhtejev;
use filmidPuhtejev;

--Zanri loomine
CREATE TABLE zanr(
zanrID int PRIMARY KEY identity(1,1),
zanrNimetus varchar(50) UNIQUE,
kirjeldus TEXT
);

--tabeli rezisoor loomine

CREATE TABLE rezisoor(
rezisoorID int PRIMARY KEY identity(1,1),
eesnimi varchar(20),
perenimi varchar(20) UNIQUE,
synniaasta int,
);

-- tabeli täitmine
INSERT INTO rezisoor(eesnimi, perenimi, synniaasta)
VALUES ('Alfred', 'Hitchcock', 1899),
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
v_aasta int CHECK(v_aasta<2027),
zanrID int
);

Select * from film;
Select * from rezisoor;
Select * from zanr;

Insert into film(filmNimetus, rezisoorID, pikkus, v_aasta)
Values('Titanic', 1, 195, 1997),
('Goodfellas', 4, 145, 1990),
('2001: A Space Oddysey', 3, 160, 1968),
('Schindler´s List', 5, 195, 1997),
('Psycho', 2, 109, 1960);

Insert into zanr(zanrNimetus, kirjeldus)
Values('romantiline draama', 'keskendub armastusele ja emotsionaalsetele suhetele.'),
('põnevusfilm', 'tekitab pinget ja hoiab vaatajat pidevas ärevuses.'),
('teadusulmefilm', 'käsitleb tulevikutehnoloogiat ja kosmoseuuringuid.'),
('kriminaaldraama', 'kujutab kuritegevust ja selle tagajärgi.'),
('ajalooline draama', 'põhineb ajaloolistel sündmustel ja tegelastel.');

--tabeli struktuuri muutmine - uue veergu lisamine
ALTER TABLE film ADD zanrID int;
--FK lisamine
ALTER TABLE film ADD CONSTRAINT fk_zanr 
FOREIGN KEY (zanrID) references zanr(zanrID);
--tabeli uuendamine
UPDATE film SET zanrID=2 WHERE filmID=7;

CREATE TABLE tootja(
tootjaID int PRIMARY KEY identity(1,1) ,
tootjaNimi varchar(100) UNIQUE,
asukoht TEXT
);

CREATE TABLE tootjaFilm(
tootjaFilm TEXT,
tootjaID int,
FOREIGN KEY (tootjaID) REFERENCES tootja(tootjaID),
filmID int,
FOREIGN KEY (filmID) REFERENCES film(filmID)
);

Insert into tootja(tootjaNimi, asukoht)
Values('Paramount Pictures', 'Los Angeles, California, USA'),
('Shamley Productions', 'Los Angeles, California, USA'),
('Metro-Goldwyn-Mayer', 'Culver City, California, USA'),
('Warner Bros.', 'Burbank, California, USA'),
('Universal Pictures', 'Universal City, California, USA');

Select * from film;
Select * from rezisoor;
Select * from zanr;
Select * from tootja;
Select * from tootjaFilm;

Insert into tootjaFilm(tootjaFilm, tootjaID, filmID)
Values('Titanic', 1, 3),
('Psycho', 2, 7),
('2001: A Space Oddysey', 3, 5),
('Goodfellas', 4, 4),
('Schindler´s List', 5, 6);
