--top 3 products from everycity with maximum sale

select * from
(select c.city, p.productname, dense_rank() over(partition by c.city order by p.productID desc) rnk 
from customers c 
inner join Orders o on c.customerID = o.customerID
inner join [Order Details] od on od.OrderID = o.orderID
inner join products p on p.ProductID = od.ProductID
group by  c.City, p.ProductName, p.ProductID)dt2
where dt2.rnk <=3

--Travel Table

Create table #Travel(destination varchar(20), distance int)

Insert into #Travel values ('A', 0)
Insert into #Travel values ('B', 20)
Insert into #Travel values ('C', 50)
Insert into #Travel values ('D', 70)
Insert into #Travel values ('E', 85)

select * from #Travel

--method 1

select b.destination + '-' + a.destination as destination, b.distance - a.distance as distance
from #Travel a  join #Travel b on a.destination < b.destination

--method 2
with TravelCTE
as
(
 Select b.destination + '-' + a.destination as destination, b.distance - a.distance as distance
from #Travel b inner join #Travel a on b.distance>a.distance where b.distance =20
union all

select d.destination + '-' + c.destination as destination, d.distance - c.distance as distance
from #Travel d inner join #Travel c on d.distance>c.distance where d.distance>20
)select * from TravelCTE
