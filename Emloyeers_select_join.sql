
--- loome uued tabelid
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(10),
Salary nvarchar(50),
DepartmentId int
)

--?
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Deparment', 'Sydney', 'Cindrella')

select * from Department

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (9, 'James', 'Male', 6500, NULL)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

select * from Employees

---?
select distinct Name, DepartmentId from Employees

---?
select sum(cast(Salary as int)) from Employees
---?
select min(cast(Salary as int)) from Employees


alter table Employees
add City nvarchar(25)


alter table Employees
add DepartmentId
int null


--?
alter table Employees
add MiddleName nvarchar(30)

alter table Employees
add LastName nvarchar(30)

update Employees set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employees set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employees set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3
update Employees set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employees set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employees set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employees set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employees set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employees set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employees set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10


--- igast reast võtab esimeses veerus täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

select * from Employees
select * from Department
select * from Employees
select * from Department

--seosed - join
--füüsiline seos - on lisatud Foreign key (constraint - piirang näiteks kontrollida diagrammil)
--loogiline seos - kui õigesti kirjutatada select joiniga


--JOIN
SELECT * FROM Employees JOIN Department
ON Employees.DepartmentId=Department.Id;

--kirjutame lihtsamaks
SELECT e.Name, e.Salary, d.DepartmentName
FROM Employees e JOIN Department d
ON e.DepartmentId=d.Id;

--inner join sama nagu lihtne join
--näitab kõik department, kus on olemas väärtus
SELECT e.Name, e.Salary, d.DepartmentName
FROM Employees e  INNER JOIN Department d
ON e.DepartmentId=d.Id;

--left join
-- näitab kõike DepartmentName (Null väärtused)
SELECT e.Name, e.Salary, d.DepartmentName
FROM Employees e  LEFT JOIN Department d
ON e.DepartmentId=d.Id;

--right join
--näitab Detartname, kus Name on null 
--RIGHT JOIN =RIGHT OUTER JOIN
SELECT e.Name, e.Salary, d.DepartmentName
FROM Employees e  RIGHT JOIN Department d
ON e.DepartmentId=d.Id

--outer join = full outer join 
--näitab kõik väärtused kahest tabelist
SELECT e.Name, e.Salary, d.DepartmentName
FROM Employees e  FULL OUTER JOIN Department d
ON e.DepartmentId=d.Id
--cross join - Näitab nii, et 1.tabeli väärtused * 2.tabeli väärtused
SELECT Name, Salary, DepartmentName
FROM Employees CROSS JOIN Department;

-- Näidata ainult need isikud, kellel departmentName on null

SELECT e.Name, e.Salary, d.DepartmentName
FROM Employees e  LEFT JOIN Department d
ON e.DepartmentId=d.Id
WHERE d.DepartmentName is Null;


Alter table employees ADD managerID int;

Select * from employees;

Update employees set managerID=2
Where Gender='Male';

--tabel Manager
CREATE TABLE manager(
id int primary key,
managerName varchar(25))

INSERT INTO manager(id, managerName)
VALUES (1, 'Roman'), (2, 'Nikita');
select * from manager;
Select * from employees;

--teha kõik join'id
--ja kirjutada mida nad näitavad
ON employees.managerID=manager.Id