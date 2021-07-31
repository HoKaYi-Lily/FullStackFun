--1
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p

--2
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p
where p.ListPrice=0

--3
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p
where p.Color is null

--4
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p
where p.Color is not null

--5
select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p
where p.Color is not null and p.ListPrice>0

--6
select  p.Name + ' '+ p.Color AS Report
from Production.Product p
where p.Color is not null 

--7
select  'Name: ' + p.Name + ' -- '+ 'COLOR:'+ p.Color AS "Name And Color"
from Production.Product p
where p.Color is not null 

--8

select p.ProductID, p.Name
from Production.Product p
where p.ProductID between 400 and 500 

--9
select p.ProductID, p.Name, p.Color
from Production.Product p
where p.Color = 'blue' or p.Color = 'black' 

--10
select p.Name
from Production.Product p
where p.name like 's%' 

--11

select p.Name, p.ListPrice
from Production.Product p
where p.name like 'Seat%' or p.name like 'Short%' and p.name like '%[^S]' and
 p.name not like '%X%'
order by p.name

--12
select p.Name, p.ListPrice
from Production.Product p
where p.name like 'S%' and p.name like 'Seat%' and p.name not like '%Stays%'
and p.name not like '%Tube%' or p.name like 'A%' 
order by p.name

--13

select p.Name, p.ListPrice
from Production.Product p
where p.name like 'SPO%' and p.name not like '%spok%'
order by p.name

--14

select distinct p.Color
from Production.Product p
order by p.Color desc

--15

select distinct p.ProductSubcategoryID, p.Color
from Production.Product p
where p.ProductSubcategoryID is not null and p.Color is not null
order by p.Color desc


--16

SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice 
FROM Production.Product
WHERE Color IN ('Red','Black') 
      AND ProductSubCategoryID = 1
	  OR Color IN ('Red','Black') 
      AND ListPrice BETWEEN 1000 AND 2000
ORDER BY ProductID



--17
SELECT distinct p.ProductSubCategoryID, p.Name,p.Color,p.ListPrice
FROM Production.Product p
WHERE p.ProductSubCategoryID is not null 
AND
p.ProductSubcategoryID =14 AND p.ListPrice IN('1431.50') 
AND 
p.name = 'HL Road Frame - Black, 58'
OR
p.ProductSubcategoryID =14 AND p.ListPrice IN('1431.50') 
AND 
p.color='Red'
OR
p.ProductSubcategoryID =12 AND p.ListPrice IN('1364.50') 
OR
p.ProductSubcategoryID =2 AND p.ListPrice IN('1700.99') 
OR 
p.ProductSubcategoryID =1 AND p.ListPrice IN('539.99') 
ORDER BY p.ProductSubcategoryID desc

