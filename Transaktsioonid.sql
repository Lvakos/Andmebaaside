CREATE DATABASE transaktsioonIKT;
use transaktsioonIKT;

CREATE TABLE tblMailingAddress(
addressId int PRIMARY KEY NOT NULL,
employeeNumber int,
houseNumber nvarchar(50),
streetAddress nvarchar(50),
city nvarchar(10),
postalCode nvarchar(50)
);

CREATE TABLE tblPhysicalAddress(
addressId int PRIMARY KEY NOT NULL,
employeeNumber int,
houseNumber nvarchar(50),
streetAddress nvarchar(50),
city nvarchar(10),
postalCode nvarchar(50)
);

INSERT INTO tblPhysicalAddress(addressId, employeeNumber, houseNumber, streetAddress, city, postalCode)
VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW');

select * from tblMailingAddress;
select * from tblPhysicalAddress;


ALTER PROCEDURE spUpdateAddress
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;

		UPDATE tblMailingAddress
		SET city = 'LONDON12'
		WHERE employeeNumber = 101;

		UPDATE tblPhysicalAddress
		SET city = 'LONDON LONDON'
		WHERE employeeNumber = 101;

		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
END;
GO

select * from tblMailingAddress;
select * from tblPhysicalAddress;
EXEC spUpdateAddress;
select * from tblMailingAddress;
select * from tblPhysicalAddress;


UPDATE tblMailingAddress
SET city = 'LONDON12'
WHERE employeeNumber = 101;

UPDATE tblPhysicalAddress
SET city = 'LONDON LONDON'
WHERE employeeNumber = 101;

select * from tblMailingAddress;
select * from tblPhysicalAddress;

CREATE TABLE tblArveldusarve (
    kontoId int PRIMARY KEY NOT NULL,
    kliendiNr int,
    omanik nvarchar(30),
    saldo decimal(10,2) CHECK (saldo >= 0)
);

CREATE TABLE tblHoiusarve (
    kontoId int PRIMARY KEY NOT NULL,
    kliendiNr int,
    omanik nvarchar(30),
    saldo decimal(10,2) CHECK (saldo >= 0)
);

insert into tblArveldusarve(kontoId, kliendiNr, omanik, saldo)
VALUES (1, 201, 'Mari Maasikas', 500.00);
insert into tblHoiusarve(kontoId, kliendiNr, omanik, saldo)
VALUES (1, 201, 'Mari Maasikas', 1000.00);

select * from tblArveldusarve;
select * from tblHoiusarve;

ALTER PROCEDURE spUlekanne
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;

		UPDATE tblHoiusarve
		SET saldo = saldo + 1000
		WHERE kliendiNr = 201;

		UPDATE tblArveldusarve
		SET saldo = saldo - 1000
		WHERE kliendiNr = 201;

		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
END;
GO

select * from tblArveldusarve;
select * from tblHoiusarve;
EXEC spUlekanne;
select * from tblArveldusarve;
select * from tblHoiusarve;

UPDATE tblHoiusarve
SET saldo = saldo + 200
WHERE kliendiNr = 201;

UPDATE tblArveldusarve
SET saldo = saldo - 200
WHERE kliendiNr = 201;