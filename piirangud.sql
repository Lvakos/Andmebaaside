CREATE TABLE City(
ID INT NOT NULL,
cityName varchar(30)
);

CREATE TABLE Country(
ID int NOT NULL primary key IDENTITY(1,1),
countryName varchar(30),
captital int
);

select * from city
--PK Lisamine
ALTER TABLE City
ADD CONSTRAINT pk_ID PRIMARY KEY(ID); 

--Unique Lisamine
ALTER TABLE City
ADD CONSTRAINT cityName_Unique UNIQUE(cityName); 

--FK Lisamine
ALTER TABLE Country
ADD CONSTRAINT fk_city FOREIGN KEY(captital)
REFERENCES City(ID); 

insert into Country(countryName, captital)
Values ('Eesti', 1);

select * from Country;

--andmete lisamine
insert into City(ID, cityName)
Values (2, 'Tartu');

select * from city;

--näitab süsteemne info tabelist
EXEC sp_help Country;
