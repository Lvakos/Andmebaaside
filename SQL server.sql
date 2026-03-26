create database praktikabaasPuhtejev;
use praktikabaasPuhtejev;

CREATE TABLE firma(
    firmaID INT NOT NULL PRIMARY KEY identity,
    firmanimi VARCHAR(20),
    aadress VARCHAR(20) UNIQUE,
    telefon VARCHAR(20) UNIQUE
);

CREATE TABLE praktikajuhendaja(
	praktikajuhendajaID INT NOT NULL PRIMARY KEY identity,
	eesnimi VARCHAR(30),
	perekonnanimi VARCHAR(30),
	synniaeg DATE,
	telefon varchar(20) UNIQUE
);

CREATE TABLE praktikabaas(
    praktikabaasID INT NOT NULL PRIMARY KEY IDENTITY,
    firmaID INT,
    praktikatingimused VARCHAR(20),
    arvutiprogramm VARCHAR(20),
    juhendajaID INT,
    FOREIGN KEY (firmaID) REFERENCES firma(firmaID),
    FOREIGN KEY (juhendajaID) REFERENCES praktikajuhendaja(praktikajuhendajaID)
);

-- firma
INSERT INTO firma (firmanimi, aadress, telefon) VALUES
('TechSoft', 'Tallinn', '5551111'),
('DataPro', 'Tartu', '5552222'),
('NetGroup', 'Narva', '5553333'),
('CodeLab', 'Parnu', '5554444'),
('SoftSys', 'Viljandi', '5555555');

-- praktikajuhendaja
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) VALUES
('Jaan', 'Tamm', '1980-05-12', '6001111'),
('Mari', 'Kask', '1985-07-23', '6002222'),
('Peeter', 'Saar', '1978-03-15', '6003333'),
('Kati', 'Lepp', '1990-11-30', '6004444'),
('Andres', 'Mets', '1982-09-08', '6005555');

-- praktikabaas
INSERT INTO praktikabaas (firmaID, praktikatingimused, arvutiprogramm, juhendajaID) VALUES
(1, 'Hea', 'Java', 1),
(2, 'Vaga hea', 'Python', 2),
(3, 'Keskmine', 'C++', 3),
(4, 'Hea', 'C#', 4),
(5, 'Vaga hea', 'JavaScript', 5);

SELECT * FROM firma;
SELECT * FROM praktikajuhendaja;
SELECT * FROM praktikabaas;

SELECT * FROM firma
WHERE firmanimi LIKE '%a%';

SELECT *
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
ORDER BY firmanimi;

SELECT firmanimi, COUNT(praktikabaasID) AS kogus
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
GROUP BY firmanimi;

SELECT *
FROM praktikajuhendaja
WHERE MONTH(synniaeg) = 9 
   OR MONTH(synniaeg) = 10 
   OR MONTH(synniaeg) = 11;

SELECT *
FROM praktikajuhendaja
WHERE MONTH(synniaeg) IN (9, 10, 11);


SELECT praktikajuhendaja.eesnimi as Juhendaja, COUNT(praktikabaasID) AS kogus
FROM praktikabaas JOIN praktikajuhendaja
ON praktikabaas.juhendajaID = praktikajuhendaja.praktikajuhendajaID
GROUP BY praktikajuhendaja.eesnimi;

ALTER TABLE praktikajuhendaja
ADD palk decimal(7,2);
UPDATE praktikajuhendaja SET palk = 1500.50 WHERE praktikajuhendajaID = 1;
UPDATE praktikajuhendaja SET palk = 1800.75 WHERE praktikajuhendajaID = 2;
UPDATE praktikajuhendaja SET palk = 1700.25 WHERE praktikajuhendajaID = 3;
UPDATE praktikajuhendaja SET palk = 1600.00 WHERE praktikajuhendajaID = 4;
UPDATE praktikajuhendaja SET palk = 1900.90 WHERE praktikajuhendajaID = 5;
SELECT * FROM praktikajuhendaja;

SELECT avg(praktikajuhendaja.palk) as keskminePalk
FROM praktikajuhendaja;

SELECT min(praktikajuhendaja.palk) as minimaalnepalk, 
max(praktikajuhendaja.palk) as maksimaalnepalk
FROM praktikajuhendaja;


CREATE VIEW vaade_firma_praktikad AS
SELECT f.firmanimi, COUNT(p.praktikabaasID) AS praktikakohtade_arv
FROM firma f
LEFT JOIN praktikabaas p ON f.firmaID = p.firmaID
GROUP BY f.firmanimi;

SELECT * FROM vaade_firma_praktikad;

CREATE VIEW vaade_sugis_juhendajad AS
SELECT eesnimi, perekonnanimi, synniaeg, telefon, palk
FROM praktikajuhendaja
WHERE MONTH(synniaeg) IN (9, 10, 11);

SELECT * FROM vaade_sugis_juhendajad;


CREATE PROCEDURE dbo.lisaKirje 
@firmanimi VARCHAR(100), 
@aadress VARCHAR(100), 
@telefon VARCHAR(20)
AS
BEGIN
    INSERT INTO Firma (firmanimi, aadress, telefon)
    VALUES (@firmanimi, @aadress, @telefon)
END;

EXEC dbo.lisaKirje 'Test Firma', 'Viru', '1234567';
select * from firma;

CREATE procedure muudaTabeli
@tegevus varchar(15),
@tabelinimi varchar(50),
@veerunimi varchar(50),
@andmetyyp varchar(50) =null
AS
Begin
    DECLARE @sqltegevus AS varchar(max)
    SET @sqltegevus=case
        when @tegevus='add' then
        concat('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi,' ', @andmetyyp)
  
        when @tegevus='drop' then
        concat('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
        END;
print @sqltegevus;
begin
EXEC(@sqltegevus);
END;
END;

EXEC muudaTabeli @tegevus='add', @tabelinimi='praktikajuhendaja', @veerunimi='email', @andmetyyp='varchar(50)';
select * from praktikajuhendaja;

CREATE PROCEDURE dbo.keskminepalk 
AS
BEGIN
    SELECT avg(praktikajuhendaja.palk) as keskminePalk
	FROM praktikajuhendaja;
END;
EXEC keskminepalk;


create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
    declare @tempdate date, @years int, @months int, @days int
        select @tempdate = @DOB
 
        select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(GETDATE())) or (MONTH(@DOB)
        = month (getdate()) and day(@DOB) > DAY(getdate())) then 1 else 0 end
        select @tempdate = dateadd(year, @years, @tempdate)
 
        select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
        select @tempdate = dateadd(MONTH, @months, @tempdate)
 
        select @days = datediff(day, @tempdate, getdate())
 
    declare @Age nvarchar(50)
        set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2)) + 
        ' Months ' + cast(@days as nvarchar(2)) + ' Days old'
    return @Age
end

select eesnimi, synniaeg, dbo.fnComputeAge(synniaeg) 
as Age from praktikajuhendaja;


create function dbo.CalculateAge(@DOB date)
returns int
as begin
declare @Age int

set @Age = DATEDIFF(YEAR, @DOB, GETDATE()) -
	case
		when (MONTH(@DOB) > MONTH(getdate())) or
			 (MONTH(@DOB) > MONTH(GETDATE()) and DAY(@DOB) > day(GETDATE()))
		then 1
		else 0
		end
	return @Age
end

select eesnimi, synniaeg, dbo.CalculateAge(synniaeg) 
as Age from praktikajuhendaja;
