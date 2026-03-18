CREATE DATABASE puhtejevView;
use puhtejevView;

CREATE TABLE laps(
    lapsID INT NOT NULL PRIMARY KEY identity(1,1),
    nimi VARCHAR(40) NOT NULL,
    pikkus SMALLINT,
    synniaasta INT NULL,
    synnilinn VARCHAR(15)
);

CREATE TABLE loom(
    loomID INT NOT NULL PRIMARY KEY identity,
    nimi VARCHAR(40) NOT NULL,
    kaal SMALLINT,
    lapsID INT,
    FOREIGN KEY (lapsID) REFERENCES laps(lapsID)
);

INSERT INTO laps (nimi, pikkus, synniaasta, synnilinn)
VALUES 
('Ivan', 150, 2010, 'Tallinn'),
('Anna', 140, 2012, 'Narva'),
('Maksim', 155, 2009, 'Tartu'),
('Olga', 145, 2011, 'Pärnu'),
('Dmitri', 160, 2008, 'Kohtla');

INSERT INTO loom (nimi, kaal, lapsID)
VALUES
('Koer Daisy', 20, 1),
('Kass Talisman', 5, 2),
('Papagoi Kesha', 1, 3),
('Hamster Puffy', 1, 4),
('Jänes Bunny', 3, 5);

SELECT * FROM laps, loom
WHERE loom.lapsID = laps.lapsID;

--select lause 2 seotud tabelite põhjal
SELECT * FROM laps INNER JOIN loom
ON laps.lapsID=loom.lapsID;

--kitsaim variant
SELECT la.nimi, lo.nimi FROM laps as la INNER JOIN loom as lo
ON la.lapsID=lo.lapsID;

--salvestamine päring view
CREATE view sisestatud_lapsi_loomad as 
SELECT la.nimi as LapsNimi, lo.nimi as LoomNimi FROM laps la INNER JOIN loom lo
ON la.lapsID=lo.lapsID;

SELECT * FROM sisestatud_lapsi_loomad;

--LapsedIlmaLoomata
CREATE view lapsedIlmaLoomata as 
SELECT lp.nimi AS lapsenimi, 
       l.nimi AS loomanimi, 
       l.kaal, 
       lp.synnilinn
FROM laps AS lp LEFT JOIN loom AS l
ON l.lapsID = lp.lapsID;

SELECT * FROM lapsedIlmaLoomata;
Select lapsenimi, loomanimi from lapsedIlmaLoomata;


-- Kolmanda tabeli lisamine
CREATE TABLE varjupaik(
    varjupaikID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    koht VARCHAR(50) NOT NULL,
    firma VARCHAR(30)
);

ALTER TABLE loom 
ADD varjupaikID INT;

ALTER TABLE loom 
ADD CONSTRAINT fk_varjupaik
FOREIGN KEY (varjupaikID) REFERENCES varjupaik(varjupaikID);

INSERT INTO varjupaik(koht, firma)
VALUES ('Paljassaare', 'Varjupaikade MTÜ');

UPDATE loom 
SET varjupaikID = 1;


SELECT * FROM loom;

--Loome view -vaade mis kasutab 3 tabelit
CREATE VIEW lapseloomadVarjupaigas AS
SELECT lp.nimi AS lapsenimi, 
       l.nimi AS loomanimi, 
       v.koht
FROM laps AS lp, loom AS l, varjupaik AS v
WHERE l.lapsID = lp.lapsID 
AND l.varjupaikID = v.varjupaikID;

-- Kasutame salvestatud view

SELECT * FROM lapseloomadVarjupaigas;

-- Kõik kassid
CREATE VIEW kassid as
SELECT * FROM loom
WHERE nimi like '%kass%';

select * from kassid;

-- Kõik lapsed alla 18
CREATE VIEW LapsedAlla18 as
SELECT nimi, synniaasta, (2026 - synniaasta) AS vanus FROM laps
WHERE synniaasta >= 2008;

select * from LapsedAlla18;

DROP VIEW LapsedAlla18;

--view mis arvutab keskmine looma kaal
CREATE VIEW KeskmineLoomaKaal as
select AVG(kaal) as KeskmineKaal from loom;
Select * from KeskmineLoomaKaal;

--view mis näitab lapsi, kellel on rohkem kui 1 loom
INSERT INTO loom (nimi, kaal, lapsID)
VALUES
('Koer Nusya', 20, 1);


CREATE view LapsiKellelOnRohkemKui1Loom as 
SELECT la.nimi as LapsNimi, Count(lo.nimi) as CountLoom 
FROM laps la INNER JOIN loom lo
ON la.lapsID=lo.lapsID
GROUP BY la.nimi
HAVING Count(lo.nimi) > 1;

select * from LapsiKellelOnRohkemKui1Loom;

-- Kas võib teha UPDATE VIEW? Ja mida ta muudab?
create view loomad as 
SELECT nimi, kaal FROM loom;

SELECT * FROM loom;
SELECT * FROM loomad;

UPDATE loom SET kaal = kaal * 1.1;

-- salvestage sql laused failis nimega view.sql ja lisa oma repose ja moodlisse
