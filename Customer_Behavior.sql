use showroom;
show tables;

-- Number of Customers in each country--
select count(Id) as Total_Customers ,country 
from customer 
group by country 
order by Total_Customers desc;

-- Number of Customers in each city--
select count(Id) as Total_Customers ,city 
from customer 
group by city 
order by Total_Customers desc;

-- Total number of orders placed by each customer--
select customerId ,count(Id) as Total_Orders
from orders 
group by CustomerId 
order by CustomerId;

-- Details of Most Valuable Customers--
select o.CustomerId,c.firstName,c.LastName,c.City,c.Country,c.Phone ,count(o.CustomerId)as Total_Orders 
from customer c left join orders o 
on c.CustomerId=o.customerId 
group by o.CustomerId,c.firstName,c.LastName,c.City,c.Country,c.Phone 
order by Total_Orders desc limit 10;

-- List of all products along with their corresponding suppliers--
select p.productname ,s.companyname
from product p left join supplier s 
on s.supplierid=p.ProductId;

-- Top 20 most ordered products--
select p.ProductName , count(o.OrderitemId) as Orders
from product p left join orderitem o 
on p.productId=o.productId 
group by ProductName 
order by Orders desc limit 20;

-- Total Number of products supplied by each company--
select p.SupplierId,s.CompanyName ,count(p.ProductId) as Total_Products
from Supplier s left join product p 
on s.SupplierId=p.SupplierId 
group by p.SupplierId,s.CompanyName;

-- Sales trend over years and months --
select year(OrderDate) as years ,month(OrderDate) as months ,sum(TotalAmount) as sales
from orders 
group by years,months 
order by years desc,sales desc;

-- Products that are frequently bought together --
Select p1.productname as product1_name, p2.productname as product2_name, COUNT(*) as frequency
from  orderitem oi1 join orderitem oi2
on oi1.orderid = oi2.orderid 
and oi1.productid < oi2.productid
join product p1 on oi1.productid = p1.productid
join product p2 on oi2.productid = p2.productid
group by p1.productname, p2.productname
order by frequency desc;
