use AdventureWorks2019
go

--1
select count(name)
from Production.Product p
-- 504

--2
select count(p.Name)
from Production.Product p
where p.ProductSubcategoryID is not null
--295

--3
Ans:
select p.ProductSubcategoryID, count(p.name) AS CountedProducts
from Production.Product p
where p.ProductSubcategoryID is not null
group by p.ProductSubcategoryID

--4
select count(p.name) 
from Production.Product p
where p.ProductSubcategoryID is null

--209

--5
select sum(quantity) 
from Production.ProductInventory 
--335974

--6
select p.ProductID,  p.Quantity AS 'TheSum'
from Production.ProductInventory p
where p.LocationID = 40 AND p.Quantity<100

--7
select p.shelf,p.ProductID,  p.Quantity AS 'TheSum'
from Production.ProductInventory p
where p.LocationID = 40 AND p.Quantity<100

--8
select avg(p.quantity)
from Production.ProductInventory p
where p.LocationID = 10 

--295

--9
select p.ProductID, p.Shelf, Avg(p.quantity) AS TheAvg
from Production.ProductInventory p
group by p.shelf, p.ProductID

--10
select p.ProductID, p.Shelf, Avg(p.quantity) AS TheAvg
from Production.ProductInventory p
where shelf != 'N/A'
group by p.ProductID, p.shelf

--11
select p.Color, p.Class, count(p.name) TheCount, Avg(p.ListPrice) AvgPrice
from Production.Product p
where p.color is not null AND p.class is not null
group by p.color, p.class

--12
select pcr.Name AS Country, p.Name AS Province
from person.CountryRegion pcr join person.StateProvince p
on pcr.CountryRegionCode = p.CountryRegionCode
order by pcr.Name

--13
select pcr.Name AS Country, p.Name As Province
from person.CountryRegion pcr join person.StateProvince p
on pcr.CountryRegionCode = p.CountryRegionCode
where pcr.Name = 'Germany' or pcr.Name = 'Canada'
order by pcr.Name

use Northwind 
go

--14
select p.ProductID, p. ProductName, o.OrderDate
from Products p join [Order Details] od
on p.ProductID = od.ProductID
join Orders o
on o.OrderID = od.OrderID
where YEAR(o.OrderDate)>=(YEAR(GETDATE())-25) AND p.UnitsOnOrder>0
order by o.OrderDate

--15
select top 5 o.OrderID, c.PostalCode, sum(od.quantity) AS Quantity
from Orders o join [Order Details] od
on o.OrderID = od.OrderID
join Customers c 
on c.CustomerID = o.CustomerID
group by o.OrderID, c.PostalCode
order by Quantity desc

--shipping postal code
select top 5 o.ShipPostalCode, sum(od.Quantity) SoldQty
from Products p inner join [Order Details] od 
on p.ProductID=od.ProductID
inner join Orders o
on od.OrderID=o.OrderID
where od.Quantity is not null and o.ShipPostalCode is not null
group by o.ShipPostalCode
order by sum(od.Quantity) desc

--16
select top 5 o.ShipPostalCode
from Products p inner join [Order Details] od 
on p.ProductID=od.ProductID
inner join Orders o
on od.OrderID=o.OrderID
where p.ReorderLevel<=25
order by p.UnitsOnOrder DESC

----new
select top 5 p.ProductID, p. ProductName, o.OrderDate
from Products p join [Order Details] od
on p.ProductID = od.ProductID
join Orders o
on o.OrderID = od.OrderID
where YEAR(o.OrderDate)>=(YEAR(GETDATE())-20) AND p.UnitsOnOrder>0
order by o.OrderDate



--17
select c.City, count(C.customerID) AS CustNum
from Customers c
group by c.City

--18
select c.City, count(C.customerID) AS CustNum
from Customers c
group by c.City
having count(C.customerID)>10

--nothing return


--19
select c.ContactName
from Customers c join Orders o
on c.CustomerID = o.CustomerID
where OrderDate > '1998-01-01'

--20
select c.ContactName, max(o.OrderDate)
from Customers c join Orders o
on c.CustomerID = o.CustomerID
group by c.ContactName

--21
select c.ContactName, count(p.productID) countOfProduct
from Customers c join orders o
on c.CustomerID = o.CustomerID
join [Order Details] od
on od.OrderID = o.OrderID
join Products p
on p.ProductID = od.ProductID
group by c.ContactName

--22
select c.CustomerID, count(p.productID) countOfProduct
from Customers c join orders o
on c.CustomerID = o.CustomerID
join [Order Details] od
on od.OrderID = o.OrderID
join Products p
on p.ProductID = od.ProductID
group by c.CustomerID
having count(p.productID)>100

--23
select su.CompanyName AS 'Supplier Company Name', 
s.CompanyName AS 'Shipping Company Name'
from Suppliers su 
cross join Shippers s
order by su.CompanyName

--24
select p.ProductName, o.OrderDate
from Orders o join [Order Details] od
on o.OrderID = od.OrderID
join Products p
on p.ProductID = od.ProductID

--25
select distinct m.FirstName+' '+m.LastName AS Employee1
, z.FirstName+' '+z.LastName AS Employee2
from Employees m left join Employees z
on m.title = z.title
where m.EmployeeID!=z.EmployeeID


--26
select e.FirstName + ' '+e.LastName AS Manager
from Employees e
where e.ReportsTo>2

--27
select c.city, c.CompanyName, c.ContactName, 'Customer' "Type",
su.CompanyName, su.ContactName, 'Suppliers' "Type"
from Customers c
join Suppliers su
on c.city = su.city
--
select c.city AS City, s.CompanyName,'Supplier' AS Type
from Products p join Suppliers s
on p.SupplierID = s.SupplierID
join [Order Details] od
on od.ProductID = p.ProductID
join Orders o
on o.OrderID = od.OrderID
join Customers c
on c.CustomerID = o.CustomerID
UNION
select c.city AS City,c.contactname, 'Customer' AS Type
from Products p join Suppliers s
on p.SupplierID = s.SupplierID
join [Order Details] od
on od.ProductID = p.ProductID
join Orders o
on o.OrderID = od.OrderID
join Customers c
on c.CustomerID = o.CustomerID

--28
--Select T1, T2
--from F1 inner join F2
--on f1.T1 = F2.T2
--result should be :
--T1 | T2
--2  | 2
--3  | 3

--29
--Select T1, T2
--from F1 left outer join F2
--on F1.T1 = F2.T2
--result should be :
--T1 | T2
--1  | NULL
--2  | 2
--3  | 3


