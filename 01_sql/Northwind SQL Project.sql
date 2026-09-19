---Display all orders placed by customers from Germany.
SELECT o.order_id, c.customer_id
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE c.country = 'Germany';

---Show products supplied by suppliers located in the USA.

SELECT p.product_name, s.supplier_id
FROM suppliers s
INNER JOIN products p ON s.supplier_id= p.supplier_id
WHERE s.country = 'USA';

---List orders processed by employees in London.
SELECT CONCAT (e.first_name,' ',e.last_name) employee_name, o.order_id
FROM employees e
INNER JOIN orders o ON e.employee_id= o.employee_id
WHERE e.city = 'London';

---Calculate the number of orders handled by each employee.
SELECT CONCAT (e.first_name,' ',e.last_name) employee_name,
COUNT (o.order_id) total_order
FROM employees e
INNER JOIN orders o ON e.employee_id= o.employee_id
GROUP BY employee_name;

---Calculate total products available in each category.
SELECT CONCAT (e.first_name,' ',e.last_name) employee_name,
COUNT (o.order_id) total_order
FROM categories
INNER JOIN products p ON c.category_id= p.category_id
GROUP BY employee_name;

---Find the total sales value for each customer.
SELECT DISTINCT(c.customer_id),ROUND (Sum ((od.unit_price * od.quantity) - 
(od.discount * od.unit_price * od.quantity))) total_sales
FROM customers c
INNER JOIN orders o ON c.customer_id= o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id
ORDER BY total_sales DESC;

---Display employees who have processed more than 100 orders.
SELECT CONCAT (e.first_name,' ',e.last_name) employee_name,
COUNT (o.order_id) total_order
FROM employees e
INNER JOIN orders o ON e.employee_id= o.employee_id
GROUP BY employee_name
HAVING COUNT(o.order_id) > 100 
ORDER BY total_order DESC;

---Show categories containing more than 10 products.
SELECT c.category_name, COUNT(p.product_id) total_product
FROM categories C
INNER JOIN products p ON c.category_id= p.category_id
GROUP BY c.category_name
HAVING COUNT(p.product_id) > 10
ORDER BY total_product DESC;

---Display the top 5 customers with the highest number of orders.
SELECT c.customer_id ,COUNT(o.order_id) total_order
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_order DESC

---Show the 10 most expensive products along with their category names.
SELECT p.product_name,c.category_name, p.unit_price unit_price
FROM categories c
INNER JOIN products p ON c.category_id = p.category_id
ORDER BY p.unit_price DESC
LIMIT 10;

---List all customers and any orders they may have placed.Include customers who have never placed an order.
SELECT c.customer_id, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

---Display all employees and the orders they handled. Include employees who have never handled an order.
SELECT CONCAT (e.first_name,' ',e.last_name) employee_name, o.order_id
FROM employees e
LEFT JOIN orders o ON e.employee_id = o.employee_id;

---Show all categories and their products. Include categories that currently contain no products.
SELECT c.category_name, p.product_name
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id;

---Find customers who have never placed an order.
SELECT c.customer_id, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id = NULL;

---Find categories with no products.
SELECT c.category_id, p.product_id
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
WHERE p.product_name = NULL;

---Find suppliers that do not currently supply any products.
SELECT s.supplier_id, p.product_id
FROM suppliers s
LEFT JOIN products p ON s.supplier_id = p.supplier_id
WHERE p.product_name = NULL;

---Count the number of orders for every customer, including customers with zero orders.
SELECT c.customer_id, COUNT(o.order_id) total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders ASC;

---Count the number of products supplied by each supplier, including suppliers with none.
SELECT s.supplier_id, s.company_name, COUNT(p.product_id) total_products
FROM suppliers s
LEFT JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.company_name
ORDER BY total_products ASC;

---Count orders handled by every employee, including employees with zero orders.
SELECT CONCAT (e.first_name,' ',e.last_name) employee_name,
COUNT(o.order_id) total_orders
FROM employees e
LEFT JOIN orders o ON e.employee_id = o.employee_id
GROUP BY employee_name
ORDER BY total_orders ASC;

---Display all orders and the corresponding customer information.
---Include orders even if customer information is missing.
SELECT c.customer_id,
COUNT(o.order_id) total_orders
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

---Show all products and their category information.
--Include products even if category information is missing.
SELECT c.category_name, count(p.product_id) total_products
FROM categories c
RIGHT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;

---Display all order details and related product information.
---Include order details even if product records are missing.
SELECT c.category_name, count(p.product_id) total_products
FROM categories c
RIGHT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;

---Count how many order details exist for each product.
---Include products with no sales.
SELECT c.category_name, count(p.product_id) total_products
FROM products p
RIGHT JOIN order_details od ON p.product_id = od.product_id 
GROUP BY c.category_name;

---Count how many products belong to each supplier.
---Include products even when supplier information is unavailable.
SELECT s.company_name, count(p.product_id) total_products
FROM suppliers s
RIGHT JOIN products p ON s.supplier_id = p.supplier_id 
GROUP BY s.company_name;

---Display all customers and all orders.
---Show unmatched customers and unmatched orders.
SELECT c.company_name, o.order_id
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.company_name, o.order_id
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id 
WHERE c.customer_id = NULL AND o.order_id = NULL;

---Display all employees and all orders.
--Show employees without orders and orders without assigned employees.
SELECT CONCAT (e.first_name,' ',e.last_name) employee_name, o.order_id
FROM employees e
FULL OUTER JOIN orders o ON e.employee_id = o.employee_id ;

SELECT CONCAT (e.first_name,' ',e.last_name) employee_name, o.order_id
FROM employees e
FULL OUTER JOIN orders o ON e.employee_id = o.employee_id
WHERE  e.employee_id= NULL OR o.order_id = NULL;

---Display all categories and all products.
--Include categories without products and products without categories.
SELECT c.category_name, p.product_name, p.product_id
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id ;

---Identify all unmatched customer-order records.
---Display: Customers without orders, Orders without customers
SELECT c.customer_id,o.order_id
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id 
WHERE c.customer_id = NULL OR o.order_id = NULL;

---Identify categories without products and products without categories.
SELECT c.category_name, p.product_name, p.product_id
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id 
WHERE c.category_id = NULL OR p.product_id = NULL;

---Identify employees without orders and orders without employees.
SELECT e.employee_id,o.order_id 
FROM employees e
FULL OUTER JOIN orders o ON e.employee_id = o.employee_id 
WHERE e.employee_id = NULL OR o.order_id = NULL;

--- Create a single list containing: Customer cities, Supplier cities
SELECT city 
FROM customers
UNION
SELECT city 
FROM suppliers;

---Generate a list of contact names from: Customers, Suppliers
SELECT contact_name
FROM customers
UNION
SELECT contact_name
FROM suppliers;

---Create a combined list of countries where customers and suppliers are located.
-- Q37
SELECT country
FROM customers
UNION
SELECT country
FROM suppliers;

---Generate a single alphabetical list of all cities from customers and suppliers.
-- Q38
SELECT city
FROM customers
UNION
SELECT city
FROM suppliers
ORDER BY city;

---Create a single alphabetical list of all company names 
--from customers and suppliers.
SELECT company_name
FROM customers
UNION
SELECT company_name
FROM suppliers
ORDER BY company_name;

---Generate a list of all countries represented in the database
--and sort alphabetically.
SELECT country FROM customers
UNION
SELECT country FROM suppliers
UNION
SELECT country FROM employees
UNION
SELECT ship_country FROM orders
ORDER BY country;

---Create a combined list of all customer cities and supplier cities.
SELECT city FROM customers
UNION ALL
SELECT city FROM suppliers;

---Generate a combined list of customer and supplier contact names.
SELECT contact_name FROM customers
UNION ALL
SELECT contact_name FROM suppliers;

---Combine all customer countries and supplier countries.
SELECT country FROM customers
UNION ALL
SELECT country FROM suppliers;

---Combine customer and supplier countries and count how many 
--times each country appears.
SELECT
    country,
    COUNT(*) AS country_count
FROM (
    SELECT country FROM customers
    UNION ALL
    SELECT country FROM suppliers
) AS combined_countries
GROUP BY country
ORDER BY country_count DESC;

---Combine customer and supplier cities and count occurrences of each city.
SELECT
    city,
    COUNT(*) AS city_count
FROM (
    SELECT city FROM customers
    UNION ALL
    SELECT city FROM suppliers
)
GROUP BY city
ORDER BY city_count DESC;

--- Combine customer and supplier company names and determine 
---how many records come from each source.
SELECT
    source,
    COUNT(*) AS total_records
FROM (
    SELECT company_name, 'Customer' AS source
	FROM customers
    UNION ALL
    SELECT company_name, 'Supplier' AS source 
	FROM suppliers
) AS combined_companies
GROUP BY source;

---For each category, display:Category name
---Number of products, Average product price
SELECT
    c.category_name,
    COUNT(p.product_id) AS number_of_products,
    ROUND(AVG(p.unit_price):: numeric,2) AS average_product_price
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name;

---Show each customer and the total number of orders placed.
--Only include customers with at least 5 orders.
SELECT
    c.customer_id,
    c.company_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.company_name
HAVING COUNT(o.order_id) >= 5
ORDER BY total_orders DESC;

---Display suppliers and the number of products they supply.
---Include suppliers with no products.
---Sort by product count descending. Show only the top 10.
SELECT
    s.supplier_id,
    s.company_name,
    COUNT(p.product_id) AS product_count
FROM suppliers s
LEFT JOIN products p
    ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.company_name
ORDER BY product_count DESC
LIMIT 10;

---Display employees and the total sales amount they generated.
---Only include employees whose total sales exceed $50,000.
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)) :: NUMERIC, 2) AS total_sales_amount
FROM employees e
JOIN orders o
    ON e.employee_id = o.employee_id
JOIN order_details od
    ON o.order_id = od.order_id
GROUP BY e.employee_id, e.first_name, e.last_name
HAVING SUM(od.unit_price * od.quantity * (1 - od.discount)) > 50000
ORDER BY total_sales_amount DESC;

--- Find the top 5 customers by total purchase value.
--Use: Customers, Orders, Order Details
SELECT
    c.customer_id,
    c.company_name,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)) :: NUMERIC, 2)
	AS total_purchase_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
GROUP BY c.customer_id, c.company_name
ORDER BY total_purchase_value DESC
LIMIT 5;

--Display all categories and the total inventory value of products
--in each category.Inventory Value = UnitPrice × UnitsInStock
--Include categories with no products.
SELECT
    c.category_name,
    ROUND(COALESCE(SUM(p.unit_price * p.units_in_stock), 0) :: NUMERIC, 2)  AS total_inventory_value
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_inventory_value DESC;

--Find customers who placed orders in 1998 and display the number of 
--orders for each customer.Sort from highest to lowest.
SELECT
    c.customer_id,
    c.company_name,
    COUNT(o.order_id) AS orders_in_1998
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1998
GROUP BY c.customer_id, c.company_name
ORDER BY orders_in_1998 DESC;

--List suppliers whose products have sold more than 500 units in total.
SELECT
    s.supplier_id,
    s.company_name,
    SUM(od.quantity) AS total_units_sold
FROM suppliers s
JOIN products p
    ON s.supplier_id = p.supplier_id
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY s.supplier_id, s.company_name
HAVING SUM(od.quantity) > 500
ORDER BY total_units_sold DESC;

--Display the 10 products with the highest total sales revenue.
SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)) :: NUMERIC,2) AS total_sales_revenue
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales_revenue DESC
LIMIT 10;