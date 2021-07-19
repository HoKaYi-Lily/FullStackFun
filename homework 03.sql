----1. In SQL Server, assuming you can find the result by using both joins and subqueries, 
----which one would you prefer to use and why?

----Joins and subqueries are both used to combine data from different tables 
----into a single result. They share many similarities and differences.
----Subqueries can be used to return either a scalar (single) value or a row set, 
----and joins are used to return rows

----2.What is CTE and when to use it?

----A common table expression is called as CTE and it is a temporary named result set
----that you can reference within a SELECT, INSERT, UPDATE, or DETELE statement.

----3.What are Table Variables? What is their scope and where are they created in SQL Server?
----A Table variable is a type of variable that represents one or more rows of
--unknown values arranged into columns whose names and types you define. 
--It is a local variable that has some similarities to temp tables. 
--Table variables are created via a declaration statement like other local variables.
--It is scoped to the stored procedure, batch, or user-defined function just like any 
--local variable you create with a DECLARE statement.

----4.What is the difference between DELETE and TRUNCATE? Which one will have better performance and why?
--Truncate always removes all the rows from a table, leaving the table empty and the table structure intact whereas DELETE may remove conditionally if the where clause is used. 
--The rows deleted by TRUNCATE TABLE statement cannot be restored and you can not specify the where clause in the TRUNCATE statement. 
----5. What is Identity column? How does DELETE and TRUNCATE affect it?
--Identity column of a table is a column whose value increases automatically. 
--The value in an identity column is created by the server. The SQL Delete retains the identity and does not reset it to the seed value. 
--The SQL Truncate command reset the identity to its seed value. 

----6. What is difference between “delete from table_name” and “truncate table table_name”?
--TRUNCATE always removes all the rows from a table, leaving the table empty and the table structure intact whereas DELETE may remove conditionally if the where clause is used. The rows deleted by TRUNCATE TABLE statement cannot be restored and you can not specify the where clause in the TRUNCATE statement.


--1.
select e.city 
from Employees e WHERE e.city in (SELECT c.city FROM customers c)

--2a.
select c.city
from Customers c where c.city not in (SELECT e.city FROM Employees e)

--2b.
select c.city 
from Customers c
left outer join
Employees e on c.city = e.City
where e.city is null

--3.
select p.productname, count(od.quantity) totalOrderQty
from [Order Details] od join Products p 
on p.ProductID = od.ProductID
group by p.ProductName

--4.
select c.City, count(od.productID)
from Customers c join orders o 
on c.customerid = o.customerid
join [Order Details] od
on od.orderID = o.orderID
group by c.City

--5a.
select c.city 
from customers c 
group by c.city 
having count(*)>2

union

select c.city 
from customers c 
group by c.city 
having count(*)=2

5b.

select dt.city from 
(select c.city 
from customers c 
group by c.city 
having count(*)>=2) dt

-- same
select distinct a.city from 
Customers a 
where a.city in
(select c.city 
from customers c 
group by c.city 
having count(*)>=2) 

--6
select c.city, count(p.productid)
from customers c join orders o
on c.customerID = o.customerid 
join [Order Details] od 
on od.OrderID = o.OrderID
join Products p 
on p.ProductID = od.ProductID
group by c.city
having count(p.productid)>=2

--7.
select c.CustomerID
from Customers c join orders o 
on o.CustomerID = c.CustomerID
where c.city != o.ShipCity 

--8.
--correct method: using (unitprice*qty*(1-discount))/sum

select top 5
	p.productid, 
	round(sum(od.unitprice*od.Quantity*(1-od.discount))/sum(od.quantity),2) Average_Price,
	c.city
From 
	products p
	join [Order Details] od on od.ProductID = p.ProductID
	join Orders o on o.orderid = od.OrderID
	join customers c on c.CustomerID = o.CustomerID
group by p.ProductID, c.city
order by sum(od.quantity) desc

--method one, not by all price (qty*productUnitprice(1-discount))
select top 5 p.ProductName, od.ProductID, c.city, count(od.Quantity) "TotalQty", avg(od.unitprice)
from [Order Details] od join Products p on p.ProductID = od.ProductID
join Orders o on o.OrderID = od.OrderID
join Customers c on c.CustomerID = o.CustomerID
group by od.ProductID, p.ProductName, c.City
order by count(od.Quantity) desc

--9a
select city from customers
where not customerid in (Select distinct customerid from orders) and not city in (select e.city from employees e)

--9b
select e.city from employees e 
except
select city from customers
where customerid in (Select distinct customerid from orders) 

--10
select dt2.city from
(select top 1 c.city, od.ProductID, count(od.orderid) saleCount
from [Order Details] od 
join orders o on o.OrderID = od.OrderID
join Customers c on c.customerid = o.CustomerID
group by c.city, od.ProductID
order by count(od.OrderID) desc) dt2
union
select dt.city from 
(select top 1 c.city, od.ProductID, count(od.quantity) saleQty
from [Order Details] od
join orders o on o.OrderID = od.OrderID
join Customers c on c.customerid = o.CustomerID
group by c.city, od.ProductID
order by count(od.quantity) desc) dt

--11
--Find duplicate rows using GROUP BY clause or ROW_NUMBER() function.
--Use DELETE statement to remove the duplicate rows.
--select distinct

--12.
CREATE TABLE #Dept (
    deptid int PRIMARY KEY,
    deptname VARCHAR(30),
);

CREATE TABLE #Employee (
    empid int PRIMARY KEY,
	mgrid int,
    deptid int FOREIGN KEY REFERENCES #Dept(deptid),
	salary int
);

--ALTER TABLE #Employee
--ALTER COLUMN deptid varchar(30);
Insert into #Dept values( 1, 'Landscape Design')
Insert into #Dept values( 2, 'Computer Science')
Insert into #Dept values( 3, 'Product Design')
Insert into #Dept values( 4, 'Art and Science')



Insert into #Employee values (1, 2, 1, 100)			
Insert into #Employee values (2, null,3, 100)			
Insert into #Employee values (3,  2, 1, 200)			
Insert into #Employee values (4,  3,4, 100)			
Insert into #Employee values (5, 1,2, 300)			
Insert into #Employee values (6, 3,2, 400)			
Insert into #Employee values (7, 1, 1, 500)			
Insert into #Employee values (8,  5,1, 600)			
Insert into #Employee values (9,  1,1, 100);	

select e.empid from #employee e
where not e.empid in (select a.mgrid from #employee a where a.mgrid = e.empid)

--13

select * from
(select d.deptid, dt.Cnt, 
dense_rank() over (order by dt.Cnt desc) rnk from #Dept d
inner join
(select e.deptid, count(e.empid) Cnt from #employee e group by e.deptid)dt
on d.deptid = dt.deptid)dt2
where dt2.rnk = 1

--14

select * from
(select d.deptid, e.empid, e.salary, dense_rank() over(partition by d.deptid order by e.salary desc) rnk from #dept d 
inner join #employee e on d.deptid = e.deptid) dt2
where dt2.rnk <=3

-----CTE method same thing

with cCTE (deptid,empid, salary,rnk)
AS (
	SELECT
		d.deptid,e.empid,e.salary,
		DENSE_RANK() over (partition by d.deptid order by e.salary desc) rnk
	FROM
		#dept d
		JOIN #Employee e on d.deptid = e.deptid
	)
select * from cCTE where rnk <=3

