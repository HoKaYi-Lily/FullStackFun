--Short Answers

--1 What is an object in SQL?
--SQL objects are schemas, journals, catalogs, tables, aliases, views, indexes,
--constraints, triggers, masks, permissions, sequences, stored procedures, user-defined
--functions, user-defined types, global variables, and SQL packages. 
--SQL creates and maintains these objects as system objects.

--2
--What is Index? What are the advantages and disadvantages of using Indexes?
--Since Indexes physically take up space on the Disk, using the Index will 
--increase the extra disk cost unless necessary. In general, indexes improve performance 
--in our Select queries and slow down DML (insert, update, delete) operations.

--3

--What are the types of Indexes?
---Unique and non-unique indexes
---Clustered and non-clustered indexes
---Partitioned and nonpartitioned indexes
---Bidirectional indexes
---Expression-based indexes

--4
--Does SQL Server automatically create indexes when a table is created? If yes, under which constraints?
--When you create a PRIMARY KEY constraint, a unique clustered index on the column
--or columns is automatically created if a clustered index 
--on the table does not already exist and you do not specify a unique nonclustered index.

--5
--Can a table have multiple clustered index? Why?
--It isn't possible to create multiple clustered indexes for a single table. 
--From the docs (emphasis mine): Clustered indexes sort and store the data rows in the table or 
--view based on their key values. These are the columns included in the index definition.

--6
--Can an index be created on multiple columns?
--Is yes, is the order of columns matter?
--Indexes can be composites - composed of multiple columns - 
--and the order is important because of the leftmost principle.

--7
--Can indexes be created on views?
--The first index created on a view must be a unique clustered index.
--Creating a unique clustered index on a view improves query performance
--because the view is stored in the database in the same way a table with
--a clustered index is stored. 
--The query optimizer may use indexed views to speed up the query execution

--8
--What is normalization? What are the steps (normal forms) to achieve normalization?
--Normalisation aims at eliminating the anomalies in data. 
--The process of normalisation involves three stages,
--each stage generating a table in normal form.
--It is the process of reorganizing data in a database so that it meets 
--two basic requirements: There is no redundancy of data, all data 
--is stored in only one place. Data dependencies are logical,all related data 
--items are stored together.

--9
--What is denormalization and under which scenarios can it be preferable?
--Denormalization is a database optimization technique in which we add redundant data to one or more tables.

--10
--How do you achieve Data Integrity in SQL Server?
--We can apply Entity integrity to the Table by specifying a primary key, unique key, and not null. Referential 
--integrity ensures the relationship between the Tables. We can apply this using a Foreign Key constraint.

--11
--What are the different kinds of constraint do SQL Server have?
--UNIQUE constraints and CHECK constraints are two types of constraints that can be used to enforce data integrity in SQL Server tables.

--12
--What is the difference between Primary Key and Unique Key?
--A primary key is a column of table which uniquely identifies each tuple (row) 
--in that table. Unique key constraints also identifies an individual tuple uniquely 
--in a relation or table. A table can have more than one unique key unlike primary key.

--13 
--What is foreign key?
--A foreign key is a column (or combination of columns) in a table whose 
--values must match values of a column in some other table. FOREIGN KEY constraints enforce referential integrity,
--which essentially says that if column value A refers to column value B, then column value B must exist.

--14
--Can a table have multiple foreign keys?
--A table may have multiple foreign keys, and each foreign key can have a 
--different parent table. Each foreign key is enforced independently by the database system. Therefore, cascading relationships between tables can be established using foreign keys.

--15
--Does a foreign key have to be unique? Can it be null?
--It can be NULL or duplicate

--16
--Can we create indexes on Table Variables or Temporary Tables?
--SQL temp tables support adding clustered and non-clustered indexes 
--after the SQL Server temp table creation and implicitly by defining Primary key constraint 
--or Unique Key constraint during the tables creation, but table variables support only adding such indexes implicitly by defining Primary key constraint or Unique 

--17
--What is Transaction? What types of transaction levels are there in SQL Server?
--A transaction is a logical unit of work that contains one or more SQL statements. A transaction is an atomic unit.  Read uncommitted, read committed , repeatable read, serializable.


--queries

--1

create table customer (cust_id int primary key, iname varchar (50)) 

create table Order_table (order_id int , cust_id int Foreign key references Customer(cust_id)
, amount money, order_date smalldatetime)


insert customer values(1, 'Shannon Fisher')
insert customer values(2, 'Tom Brown')
insert customer values(3, 'Jamision Curry')

insert order_table values(1, 1, 500, '1955-12-13 12:43:10')
insert order_table values(2, 2, 600, '2002-12-13 12:43:10')
insert order_table values(3, 3, 700, '2002-12-13 12:43:10')

select c.iname, sum(amount) 
from customer c join order_table o on c.cust_id = o.cust_id
where Year(o.order_date) = 2002
group by c.iname

drop table customer
drop table order_table



--2
Create table person (id int, firstname varchar(100), lastname varchar(100)) write a query that returns all employees whose last names  start with “A”.

create table person (id int, firstname varchar(100), lastname varchar(100))
--return all employees whose last names start with "A"

insert person values(1, 'Allison', 'Sander')
insert person values(2, 'Awesome', 'Aily')
insert person values(3, 'Bellan','Aase')

select firstname + ' ' + lastname from person
where lastname like 'A%'

--3
Create table person(person_id int primary key, manager_id int null, name varchar(100)not null) 

insert person values(1,2, 'Shibaya')
insert person values(2,null, 'Lily')
insert person values (3, 2, 'PeterRabbit')
insert person values(4, 3,'Pikachu')

select p.name, dt.EmpCnt from person p 
inner join
(select manager_id, count(person_id) EmpCnt from person
group by manager_id) dt
on p.person_id = dt.manager_id 
where p.manager_id is null

--4
--DML statements that modify data in a table ( INSERT , UPDATE , or DELETE )
--DDL statements.
--System events such as startup, shutdown, and error messages.
--User events such as logon and logoff. Note: Oracle Forms can define, store, and run triggers of a different sort.

--5
Create table company ( companyname varchar(20) primary key, divisionName varchar(20) foreign key references location(divisionName))
create table location ( divisionName varchar(20) primary key)
create table contacts ( contactname  varchar(20) , divisionName varchar(20) foreign key references location(divisionName), address varchar(20), MailOrSuite varchar(20))

