-- Q1
use classicmodels;
show tables;
describe customers; describe employees; describe offices; 
describe orderdetails; describe orders; describe payments;
describe productlines; describe products;
-- Q2(a)
SELECT count(city) AS Number_of_Employee, city FROM employees
JOIN offices ON employees.officecode = offices.officecode
GROUP BY city
Order by Number_of_Employee DESC;
-- Q2(b)
SELECT customerName AS Customer_Name, phone AS Contact, 
firstName AS Salesperson_name, jobTitle AS Position 
FROM customers 
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber;
-- Q2(c)
SELECT count(firstName) AS Number_of_Customer, firstName AS Salesperson_Name
FROM customers 
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
Group by firstName;
-- Q2(d)
SELECT * FROM orders;
SELECT sum(quantityOrdered) FROM orderdetails WHERE orderNumber <= 10104 AND
 productCode= 'S18_2248';
SELECT * FROM products;
SELECT productName AS Product_Name, sum(quantityOrdered) AS Quantity_Order, 
month(orderDate) AS Month_sale, year(orderDate) AS Year_sale
FROM orderdetails
JOIN products ON orderdetails.productCode = products.productCode
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
GROUP By year(orderDate), month(orderDate), productName
Having Year_sale = 2004 AND Month_sale = 12
Order By year(orderDate), month(orderDate) ASC, Quantity_Order DESC;
-- 2(e)
SELECT productName , (MSRP - buyPrice) AS Profit FROM products
WHERE MSRP - buyPrice >50;
-- 2(f)
SELECT customerName, orders.orderNumber, (quantityOrdered * priceEach) AS TotalAmount
FROM orders
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN customers ON orders.customerNumber = customers.customerNumber
GROUP BY customerName
Order BY customerName;

-- 2(g)
SELECT productlines.productLine AS Line,
productvendor as Vendor, sum(quantityinStock) AS Stock
FROM products
JOIN productlines on products.productLine = productlines.productLine 
GROUP BY Line, Vendor
Order By Line, Vendor;
-- 2(h)
SELECT productVendor AS Vendor, buyPrice,
rank() over( 
order by buyPrice DESC
) Price_Rank
FROM products;

SELECT productname, productVendor AS Vendor, buyPrice,
rank() over( 
partition by productvendor order by buyPrice desc
) Price_Rank
FROM products;
