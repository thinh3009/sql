select * from newPizza
--index
--A.DOANH THU
--1.tong doanh thu
select SUM(total_price) as total_sold_sum
from newPizza

--2.tong don hang
select COUNT(distinct order_num) as total_order from newPizza
--3.gia trung binh cho moi don hang
select (SUM(total_price)/COUNT( distinct order_num)) as avg_order from newPizza
--4.trung binh so luong qua moi don hang
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_num) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM newPizza
--tong so pizza da ban
select count(order_num) from newPizza
select * from newPizza

--16.tong so pizza co gia la 16
/*alter proc proc_value_onepizza
	@total_p float
as
select  count(pizza_name) as total_pizza, total_price from newPizza
where total_price=@total_p
group by total_price
exec proc_value_onepizza @total_p=35.95*/



--B.XU HUONG DAT HANG
--5.tong so don hang dat trong moi ngay trong tuan
select DATEname(dw,order_date) as order_date, COUNT(distinct order_num) as total_orders
from newPizza
group by DATEname(dw,order_date)
order by order_date

--6.don hang duoc dat trong moi thang
select DATENAME(MONTH, order_date) as Month_name,COUNT(distinct order_num) as total_ord_month
from newPizza
group by DATENAME(MONTH, order_date)

--don hang dat nhieu nhat trong thang
WITH day_in_week AS (
    SELECT DATENAME(MONTH, order_date) as Month_name, COUNT(distinct order_num) as total_ord_in_week
    FROM newPizza
    GROUP BY DATENAME(MONTH, order_date)
)
SELECT MAX(total_ord_in_week) as max_in_week FROM day_in_week;
----------
--7.phan tram so pizza ban ra theo category
SELECT pizza_category, sum(total_price) as total_sales, 
(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM newPizza)) as pizza_per_category
FROM newPizza
GROUP BY pizza_category
--8.phan tram size pizza trong don hang
SELECT pizza_size, cast(sum(total_price) as decimal(10,2))  as total_sales, 
cast((SUM(total_price) * 100 / (SELECT SUM(total_price) FROM newPizza)) as decimal(10,2)) as pizza_per_category
FROM newPizza
GROUP BY pizza_size
--9.ten pizza ban duoc doanh thu thap nhat
select top 5  pizza_name,cast(SUM(total_price) as decimal(10,2)) as total_revenue from newPizza
group by pizza_name
order by total_revenue asc

--10.ten pizza ban duoc doanh thu cao nhat
select top 5 pizza_name,SUM(total_price) as total_revenue from newPizza
group by pizza_name
order by total_revenue desc
--11.so luong (quantity) pizza ban dc nhieu nhat
select top 5 pizza_name,SUM(quantity) as total_quantity from newPizza
group by pizza_name
order by total_quantity desc
--12.so luong pizza ban dc it nhat
select top 5 pizza_name,SUM(quantity) as total_quantity from newPizza
group by pizza_name
order by total_quantity asc

--13.loai thuc an duoc dung nhieu trong banh
select pizza_dish as dish,COUNT(distinct order_num) as total_ord_dish
from newPizza
group by pizza_dish
----


WITH dish AS (
    SELECT pizza_dish, COUNT(distinct order_num) as total_dish
    FROM newPizza
    GROUP BY pizza_dish
)
SELECT MAX(total_dish) as max_in_dish FROM dish;

SELECT @@SERVERNAME
 

--14. so pizza ban ra trong 1 ngay 
alter procedure proc_pizzaIn1day
	@day_order int,
	@month_order int
as
begin
	if exists(SELECT order_date FROM newPizza WHERE MONTH(order_date)=@day_order AND DAY(order_date)= @month_order)
	begin
		select order_date,count(pizza_name) as total_oneday
		from newPizza
		where MONTH(order_date)=@month_order and DAY(order_date)=@day_order
		group by order_date
	end
end
--tong banh ban ra trong 1 ngay
exec proc_pizzaIn1day @day_order=3,@month_order=1
exec proc_pizzaIn1day @day_order=1,@month_order=1
--thong ke ten banh da ban trong 1 ngay
SELECT order_date,pizza_name 
FROM newPizza 
WHERE MONTH(order_date)=1 AND DAY(order_date)= 3
--banh ban 1 ngay trong 12 thang
select order_date,count(pizza_name) as total_piza_12month from newPizza
group by order_date
order by order_date asc
--15.so luong don pizza ban chay nhat
select count(distinct order_num) as total_order_perName,pizza_name 
from newPizza
group by pizza_name 
order by total_order_perName desc

--16.banh ban ra trong 1 quy 
select DATENAME(q, order_date) as Month_name,COUNT(order_num) as total_ord_month
from newPizza
group by DATENAME(q, order_date)
order by Month_name asc

--18.so pizza ban ra trong 1 thang
select order_date,count(distinct order_num) as total_ord_oneMonth
from newPizza
where DATEPART(M,order_date)=5
group by order_date



select order_date,count(distinct order_num) as total_ord_oneMonth 
from newPizza
where DATEPART(M,order_date)=2
group by order_date

--19.procedure size pizza ban ra trong thang 1-->12
alter procedure proc_sizeMonth
	@orderMonth int,
	@pizzaSize varchar(5)
as
begin
	if exists (select pizza_size=@pizzaSize from newPizza)
	begin
		select COUNT(distinct order_num) as total_size,pizza_size 
		from newPizza
		where DATEPART(m,order_date)=@orderMonth and pizza_size like @pizzaSize
		group by pizza_size
	end
end
exec proc_sizeMonth @pizzaSize='s',@orderMonth=12
exec proc_sizeMonth @pizzaSize='M',@orderMonth=2
exec proc_sizeMonth @pizzaSize='L',@orderMonth=12
