
--1. What is View? What are the benefits of using views?
--Views can provide advantages over tables: Views can represent a subset of the data contained in a table. Consequently,
--
--a view can limit the degree of exposure of the underlying tables to the outer world: a given user may have permission to query the view, while denied access to the rest of the base table.


--2. Can data be modified through views? You can, but you can't modify data in views that 
--use GROUP BY or DISTINCT statements. All columns being modified are subject to the same restrictions as if the 
--statements were being executed directly against the base table. Text and image columns can't be modified through views.

--3.What is stored procedure and what are the benefits of using it?

--Stored procedures are compiled once and stored in executable form, so procedure calls are quick and efficient.
--By grouping SQL statements, a stored procedure allows them to be executed with a single call. This minimizes the use of slow networks, 
--reduces network traffic, and improves round-trip response time.

--4.What is the difference between view and stored procedure?
--View is simple showcasing data stored in the database tables whereas a stored procedure is a group of statements that can be executed. 
--A view is faster as it displays data from the tables referenced whereas a store procedure executes sql statements.

--5.What is the difference between stored procedure and functions?
--The function must return a value but in Stored Procedure it is optional. Even a procedure can return zero or n values. 
--Functions can have only input parameters for it whereas Procedures can have input or output parameters. 
--Functions can be called from Procedure whereas Procedures cannot be called from a Function

--6.Can stored procedure return multiple result sets?
--Most stored procedures return multiple result sets. Such a stored procedure usually includes one or more select statements. 
--The consumer needs to consider this inclusion to handle all the result sets.

--7.Can stored procedure be executed as part of SELECT Statement? Why?
--Stored procedures are typically executed with an EXEC statement. However, you can execute a stored procedure implicitly from within 
--a SELECT statement, provided that the stored procedure returns a result set.

--8.What is Trigger? What types of Triggers are there?
--In SQL Server we can create four types of triggers Data Definition Language (DDL) triggers, Data Manipulation Language (DML) triggers, CLR triggers, and Logon triggers.

--9.What are the scenarios to use Triggers?
--when we need trigger to help the database designer ensure certain actions, such as maintaining an audit file, are completed regardless of which program or user makes changes to the data.

--10. What is the difference between Trigger and Stored Procedure?
--Stored procedures are a pieces of the code in written in PL/SQL to do some specific task. Stored procedures can be invoked explicitly by the user. 
--Trigger is a stored procedure that runs automatically when various events happen (eg update, insert, delete).





-- 1

--A new region called “Middle Earth”;
insert into Region values (5, 'Middle Earth')
--A new territory called “Gondor”, belongs to region “Middle Earth”;
insert into Territories values (123456, 'Gondor', 5)
--A new employee “Aragorn King” who's territory is “Gondor”.
insert into Employees ( LastName, FirstName) values ('Gondor', 'Aragorn')
insert into EmployeeTerritories values (10,123456)



--2
update Territories set TerritoryDescription = 'Arnor' where TerritoryDescription = 'Gondor'

--3

delete from EmployeeTerritories where EmployeeID = 10
delete from Territories where TerritoryDescription = 'Gondor' 
delete from region where RegionDescription = 'Middle Earth'

--4
create view view_product_order_Lily
as
select productid, quantityperunit
From Products--base table

select * from view_product_order_Lily

drop view view_product_order_Lily

--5
select * from Products
create proc sp_product_order_quantity_Lily
@id int, 
@productQty varchar(20) out 
as
begin
select @productQty = QuantityPerUnit from Products where ProductID = @id
end


begin 
declare @pr varchar(20)
execute sp_product_order_quantity_Lily 3, @pr out
print @pr
end

drop proc sp_product_order_quantity_Lily

------method 2
create proc sp_product_order_quantity_Lily
@id int
as
begin
select QuantityPerUnit from Products where ProductID = @id
return
end

sp_product_order_quantity_Lily 3


--6
create proc sp_product_order_city_lily
@productname varchar(40)
as
begin 
select top 5 c.city, p.ProductName from customers c join orders o on c.CustomerID = o.CustomerID
									join [Order Details] od on od.OrderID = o.orderid
									join Products p on p.ProductID = od.ProductID
									group by c.city, p.ProductName 
									order by sum(od.quantity)
return
end

sp_product_order_city_lily Chai

drop proc sp_product_order_city_lily

--7
create proc sp_move_employees_lily 
as
if(select  count(e.TerritoryID) from EmployeeTerritories e where e.TerritoryID in(
select TerritoryID from Territories where TerritoryDescription = 'Troy'))>0
	begin 
		insert into Territories values (123456, 'Steven Point', 3)
		update EmployeeTerritories set TerritoryID = 123456 where EmployeeID in
		( select e.EmployeeID from EmployeeTerritories e where e.TerritoryID in(
		select TerritoryID from Territories where TerritoryDescription = 'Troy'))
		return(1)
	end
else
	begin
		return(0)
	end


delete Territories where TerritoryDescription = 'Steven Point'
	sp_move_employees_lily

drop proc sp_move_employees_lily 


--8
Create Trigger ChangeLoc Before update on account
	if select count(employeeID) from EmployeeTerritories where TerritoryID in
	(select TerritoryID from Territories where TerritoryDescription = 'Stevens Point') >100

	update Territories set TerritoryDescription = 'Troy' where TerritoryDescription = 'Stevens Point'

	end if;
end;

--9
create table people_lily (Id int primary key , Name varchar(20) unique not null, city int foreign key references city_lily (cityid))

create table city_lily (cityId int primary key , cityName varchar(20) unique)

--city table
--id, city
insert into city_lily values(1, 'Seattle')
insert into city_lily values(2, 'Green Bay')

people table
-- id, name, city
insert into people_lily values (1, 'Aaron Rodgers',2)
insert into people_lily values (2, 'Russell Wilson', 1)
insert into people_lily values (3, 'Jody Nelson', 2)

select * from city_lily
select * from people_lily

update city_lily set cityName = NULL where cityName= 'Seattle'
--remove city seattle
update city_lily set cityName = 'Madison' where cityName is NULL

--of they are in Seattle, put them into a new city Madison

create view vwPackers_lily 
as 
select Name from people_lily where city in (select cityid from city_lily where cityName = 'Green Bay')

select * from vwPackers_lily

--list all people from green bay

--drop both tables
create view vwEmployee
as
select Id, FullName, deptid
From Employee--base table

drop table people_lily 
drop table city_lily

--10
create proc birthday_employee
as
begin
	create table birthday_employee_Lily (Name varchar(20) unique)
	insert into birthday_employee_Lily(Name) 
	select Lastname + ' ' + firstname from Employees where month(birthdate) = 02
end
--create a table (birthday_employee_Lily
--fill with employee birthday on feb
-- drop the table

 birthday_employee

select * from birthday_employee_Lily
drop table birthday_employee_Lily
drop proc birthday_employee



--11
-- sp_Lily_1
--return all cties that have at least two customer that bought nothing or only on kind product
--union
create proc sp_Lily_1
as begin
select city from customers c group by c.city having count(*)>=2
union
select c.city from customers c left join orders o on c.customerid is null
union
select c.city from customers c join orders o on c.CustomerID = o.CustomerID
								join [Order Details] od on od.OrderID = o.OrderID
								join Products p on p.productid = od.ProductID
								group by c.city
								having count(p.productid) between 0 and 2
end

sp_Lily_1

drop  proc sp_Lily_1

--sub-qery
create proc sp_Lily_2
as begin
select distinct a.city from customers a join orders o on a.CustomerID = o.CustomerID
								join [Order Details] od on od.OrderID = o.OrderID
								join Products p on p.productid = od.ProductID
where a.city in (select c.city from customers c left join orders o on c.customerid is null)
group by a.city
having count(p.productid) between 0 and 2
end

sp_Lily_2

drop  proc sp_Lily_2

--12How do you make sure two tables have the same data?
--1.An inner join to pick up the rows where the primary key exists in both tables, but there is a difference in the value of one or more of the other columns. This would pick up changed rows in original.
--2.A left outer join to pick up the rows that are in the original tables, but not in the backup table (i.e. a row in original has a primary key that does not exist in backup). This would return rows inserted into the original.
--3.A right outer join to pick up the rows in backup which no longer exist in the original. This would return rows that have been deleted from the original.


--14
create table Names (FirstName varchar(20) primary key , LastName varchar(20) unique not null, MiddleName char NULL)


insert Names values('John', 'Green', NULL)

insert Names values('Mike', 'White', 'M')

select * from Names

select FirstName + ' '+LastName  AS [Full Name] from Names where MiddleName is null
union
select FirstName + ' '+LastName +' ' +MiddleName +'.' AS [Full Name] from Names where MiddleName is not null

drop Table Names

--15


create table StudentTable (Student varchar(20) primary key , Marks int, Sex char NULL)


insert StudentTable values('Ci', 70, 'F')

insert StudentTable values('Bob', 80, 'M')

insert StudentTable values('Li', 90, 'F')

insert StudentTable values('Mi', 95, 'M')


select top 1 student, max(marks) from StudentTable where sex = 'F'
group by Student
order by student desc

--16
select student, marks, sex from StudentTable
order by sex asc,marks desc
