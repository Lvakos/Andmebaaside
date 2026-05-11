create database kasutajaPuhtejev;
use kasutajaPuhtejev;

create table õpilane(
õpilaneID int primary key not null identity(1,1),
klass int not null,
nimi varchar(40),
CONSTRAINT lmt_klass_õpilane CHECK (klass between 0 and 13),
klassiJuhetaja_ID int not null,
FOREIGN KEY (klassiJuhetaja_ID) REFERENCES klassijuhataja(juhatajaID)
);

SELECT o.õpilaneID, o.klass, o.nimi, k.nimi AS klassijuhataja
FROM õpilane AS o 
INNER JOIN klassijuhataja AS k
ON o.klassiJuhetaja_ID = k.juhatajaID;

create table klassijuhataja(
juhatajaID int primary key not null identity(1,1),
nimi varchar(40),
);

create table logi(
logID int not null identity(1,1),
kuupaev DATETIME,
andmed TEXT,
kasutaja varchar(40)
);
---- Õpilane
CREATE TRIGGER õpilaneLisamine
on õpilane
FOR Insert
AS
insert into logi(kuupaev, andmed, kasutaja)
select
getdate(),
CONCAT('Lisatud õpilane nimega: Nimi: ', inserted.nimi,
' / klass: ', inserted.klass, ' / klassijuhetaja: ', inserted.klassiJuhetaja_ID),
SYSTEM_USER
FROM inserted
INNER JOIN klassijuhataja AS k 
ON inserted.klassiJuhetaja_ID = k.juhatajaID;

CREATE TRIGGER õpilaneUuendamine
on õpilane
FOR UPDATE
AS
insert into logi(kuupaev, andmed, kasutaja)
select
getdate(),
CONCAT('Vana õpilane andmed: Nimi: ', d.nimi,
' / klass: ', d.klass, ' / klassijuhetaja: ', d.klassiJuhetaja_ID,
', uued õpilane andmed: Nimi: ', i.nimi,
' / klass: ', i.klass, ' / klassijuhetaja: ', i.klassiJuhetaja_ID),
SYSTEM_USER
FROM deleted d INNER JOIN inserted i
ON d.õpilaneID = i.õpilaneID;

drop trigger õpilaneLisamine;

------ KlassiJuhataja
CREATE TRIGGER klassijuhatajaLisamine
on klassijuhataja
FOR Insert
AS
insert into logi(kuupaev, andmed, kasutaja)
select
getdate(),
CONCAT('Lisatud klassijuhataja nimega: Nimi: ', inserted.nimi),
SYSTEM_USER
FROM inserted;

drop trigger klassijuhatajaLisamine;

CREATE TRIGGER klassijuhatajaUuendamine
on klassijuhataja
FOR UPDATE
AS
insert into logi(kuupaev, andmed, kasutaja)
select
getdate(),
CONCAT('Vana klassijuhataja andmed: Nimi: ', d.nimi, ' uued klassijuhatja andmed: Nimi: ', i.nimi),
SYSTEM_USER
FROM deleted d INNER JOIN inserted i
ON d.juhatajaID = i.juhatajaID;
-----
INSERT INTO õpilane (klass, nimi, klassiJuhetaja_ID)
VALUES 
(2, 'Maksimilian Puhtejev', 2),
(6, 'Peeter Vaher', 1),
(11, 'Laura Kask', 3);

INSERT INTO klassijuhataja(nimi)
VALUES 
('Marina Oleinik');

UPDATE klassijuhataja
SET nimi = 'Alina Laaneväli-Toots'
WHERE nimi = 'Marina Oleinik';

GRANT SELECT
on õpilane to Direktor;

GRANT INSERT
on õpilane to Direktor;

GRANT SELECT
on klassijuhataja to Direktor;

GRANT INSERT
on klassijuhataja to Direktor;

select * from klassijuhataja;

select * from logi;



