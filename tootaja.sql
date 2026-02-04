CREATE DATABASE puhtejev;
use puhtejev;

--tabeli loomine
CREATE TABLE tootaja(
tootajaID int PRIMARY KEY identity(1,1),
eesnimi varchar(30),
perenimi varchar(30),
synniaeg date,
koormus decimal(5,2),
elukoht TEXT,
abielus bit
);
--tabeli kutsutamine
drop table tootaja;
--kuvamine
select * from tootaja;

--andmete lisamine tabelisse
INSERT INTO tootaja(eesnimi, perenimi, synniaeg)
VALUES ('Mark', 'Päev', '2025-10-13'),
('Dmitriy', 'Valgus', '2000-8-23'),
('Lev', 'Tigr', '2003-5-09')
