--1. Orders tablosunda ka� m�steri oldugunu 
SELECT COUNT(customerid) FROM deneme_orders  

--2. Orders tablosunda ka� essiz m�steri oldugunu bulunuz.
SELECT COUNT(distinct customerid)FROM deneme_orders

--3. Customers tablosunda hangi �lkeden ka�ar tane m�steri oldugunu bulunuz. 
SELECT COUNT(customerid) as sayi, country FROM deneme_customers
GROUP BY country ORDER BY 1 --sayi or COUNT(customerid)

--4. M�sterilerin �lkesi Brazil ya da USA olanlari bulunuz.
SELECT customername, country  FROM deneme_customers
WHERE LOWER(country) = 'brazil' or LOWER(country) = 'usa'
--OR--
SELECT customername, country  FROM deneme_customers
WHERE LOWER(country) in('brazil', 'usa')

--5. �nce �lkeye sonra sehre g�re group by islemi yapip bu kirilimda m�steri sayisini bulunuz.
SELECT country, city, count( customerid) from deneme_customers
GROUP BY country, city ORDER BY 3

--6. M�sterileri adreslerinin herhangi bir yerinde "da" ifadesi ge�en t�m adresleri bulunuz. 
SELECT address FROM deneme_customers
WHERE address LIKE '%da%'

--7. Germany-Berlin' de yasayan m�sterilerin isimleri nelerdir?
SELECT customername, country, city FROM deneme_customers
WHERE country= 'Germany' and city='Berlin'

--8. Canada'da yasay�p isimlerinde "in" ifadesi gecen m�sterileri bulunuz.
SELECT customername, country FROM deneme_customers
WHERE country='Canada' and customername like '%in%'

--9. Fiyati 40 ile 90 TL arasinda olan �r�nlerin isimleri ve fiyatlar� nelerdir?
SELECT productname, price FROM deneme_products
WHERE price BETWEEN '40' and '90'

--10. Fiyati 30 tl den b�y�k olan �r�nlerin isimlerini, fiyatlarini ve fiyatlarinin karesini bulunuz ve t�m de�i�kenlerin isimlendirmelerini urun-urun_fiyati_urun_fiyati_karesi diye de�i�tiriniz.
SELECT productname as urun , price as urun_fiyati,price*price urun_fiyati_karesi FROM deneme_products
WHERE price>'30'
--OR--
SELECT productname as urun , price as urun_fiyati,power(price,2) urun_fiyati_karesi FROM deneme_products
WHERE price>'30'

--11. Products tablosundaki categoryid'lerin yani kategori isimleri nelerdir?
SELECT distinct (deneme_products.categoryid), deneme_categories.categoryname FROM deneme_products
JOIN deneme_categories on deneme_categories.categoryid=deneme_products.categoryid 
ORDER BY 1

--12. bevarages �r�n kategorisindeki �r�nlerin fiyat ortalamasi nedir? 
SELECT deneme_categories.categoryname, avg( price) FROM deneme_categories
JOIN deneme_products on deneme_products.categoryid=deneme_categories.categoryid
WHERE LOWER(deneme_categories.categoryname)= 'beverages'
GROUP BY deneme_categories.categoryname

--13. USA'de yasayan m�sterilerin kazandirdigi toplam kazanci bulunuz.
SELECT sum(price) FROM deneme_orders ord
INNER JOIN deneme_orderdetails od on ord.orderid = od.orderid
INNER JOIN deneme_products pr on pr.productid = od.productid
INNER JOIN deneme_customers c on c.customerid = ord.customerid
WHERE LOWER(c.country) = 'usa'

--14. Product tablosundaki categoryid'lerin isimlerini bulunuz ve sonrasinda kategori basina ortalama �r�n fiyatini g�steriniz. 
SELECT deneme_products.categoryid, deneme_categories.categoryname, avg(price) FROM deneme_products
INNER JOIN deneme_categories on deneme_categories.categoryid=deneme_products.categoryid
GROUP BY deneme_categories.categoryname, deneme_products.categoryid 
ORDER BY 1

--15. Cali�anlari (employee) isimleri ile birlikte yaptiklari toplam satislara g�re siralay�n�z.
SELECT ep.lastname, sum(price) FROM deneme_employees ep
JOIN deneme_orders od on od.employeeid=ep.employeeid
JOIN deneme_orderdetails ode on ode.orderid=od.orderid
JOIN deneme_products po on po.productid=ode.productid
GROUP BY ep.lastname ORDER BY 2
--JOIN = INNER JOIN

--16. Almanya'dan verilen sipari�lerin kategorilerine g�re ortalama fiyatlar� nelerdir?
SELECT ca.categoryname, avg(price) FROM deneme_customers cu
JOIN deneme_orders ode on ode.customerid=cu.customerid
JOIN deneme_orderdetails oi on oi.orderid=ode.orderid
JOIN deneme_products pu on pu.productid=oi.productid
JOIN deneme_categories ca on ca.categoryid=pu.categoryid
WHERE cu.country='Germany'
GROUP BY ca.categoryname
 
--17. Almanya ya da USA'den verilen siparislerin kategorilerine g�re ortalama fiyatlari nelerdir?
SELECT categoryname , avg(pu.price) FROM deneme_orders ord
JOIN deneme_orderdetails odi on odi.orderid = ord.orderid
JOIN deneme_products pu  on pu.productid = odi.productid
JOIN deneme_categories ca on ca.categoryid =pu.categoryid
JOIN deneme_customers cu on  cu.customerid=ord.customerid
WHERE cu.country in ('Germany','USA')
GROUP BY categoryname
--OR--
SELECT categoryname Kategori_Fiyatlari, avg(DENEME_PRODUCTS.PRICE) ortalama_fiyatlari
FROM muhammetyorulmaz.deneme_orders 
LEFT OUTER JOIN MUHAMMETYORULMAZ.DENEME_ORDERDETAILS on DENEME_ORDERS.ORDERID = DENEME_ORDERDETAILS.ORDERID
LEFT OUTER JOIN MUHAMMETYORULMAZ.DENEME_PRODUCTS     on DENEME_ORDERDETAILS.PRODUCTID = DENEME_PRODUCTS.PRODUCTID
LEFT OUTER JOIN MUHAMMETYORULMAZ.DENEME_CATEGORIES   on DENEME_PRODUCTS.CATEGORYID = DENEME_CATEGORIES.CATEGORYID
LEFT OUTER JOIN MUHAMMETYORULMAZ.DENEME_CUSTOMERS    on DENEME_ORDERS.CUSTOMERID = DENEME_CUSTOMERS.CUSTOMERID
WHERE DENEME_CUSTOMERS.country = 'Germany' or DENEME_CUSTOMERS.country = 'USA'  group by categoryname ;

--18. Haziran Temmuz Agustos aylarinda verilen siparislerin ortalama fiyati nedir? 
SELECT  sum(price) FROM deneme_orders od
JOIN deneme_orderdetails ode on ode.orderid=od.orderid
JOIN deneme_products po on po.productid=ode.orderid
GROUP BY  ode.orderid

SELECT avg(price) FROM deneme_orderdetails od
JOIN deneme_products pr on pr.productid = od.productid
JOIN deneme_orders o on o.orderid = od.orderid
JOIN o.orderdate like '%/06/%' or  o.orderdate like '%/07/%' or  o.orderdate like '%/08/%'

--19. M�sterilerin 1997 yilina ait siparislerinin maksimum miktarlarini bulup m�sterilerin isimleri ile birlikte b�y�kten k�c�ge dogru siralayiniz.
SELECT cu.customername, max(pu.price) FROM deneme_customers cu
JOIN deneme_orders ord on ord.customerid=cu.customerid
JOIN deneme_orderdetails odi on odi.orderid=ord.orderid
JOIN deneme_products pu on pu.productid=odi.productid
JOIN orderdate like ('%1997')
GROUP BY cu.customername
--OR--
SELECT  customername Musteri_Adi, max(DENEME_PRODUCTS.PRICE) miktar
FROM muhammetyorulmaz.deneme_orders 
LEFT OUTER JOIN MUHAMMETYORULMAZ.DENEME_ORDERDETAILS on DENEME_ORDERS.ORDERID = DENEME_ORDERDETAILS.ORDERID
LEFT OUTER JOIN MUHAMMETYORULMAZ.DENEME_PRODUCTS     on DENEME_ORDERDETAILS.PRODUCTID = DENEME_PRODUCTS.PRODUCTID
LEFT OUTER JOIN MUHAMMETYORULMAZ.DENEME_CUSTOMERS    on DENEME_ORDERS.CUSTOMERID = DENEME_CUSTOMERS.CUSTOMERID
JOIN orderdate like ('%1997') GROUP BY customername ORDER BY miktar desc;

--20. Siprais yili 1997 olan siprasleri alan calisanlari siparis alma sayilarina g�re siralayiniz. 
SELECT distinct ep.lastname, count(distinct orderid) FROM deneme_orders od
JOIN deneme_employees ep on ep.employeeid=od.employeeid
WHERE od.orderdate like'%1997'
GROUP BY ep.lastname
 
SELECT COUNT(*) n, deneme_employees.FirstName 
FROM muhammetyorulmaz.deneme_Orders 
LEFT outer JOIN muhammetyorulmaz.deneme_Employees  on deneme_Orders.EmployeeID = deneme_employees.EmployeeID 
WHERE OrderDate like '%1997%' 
GROUP BY deneme_employees.FirstName 
ORDER by n DESC;



