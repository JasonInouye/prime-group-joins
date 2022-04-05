-- Get all customers and their addresses

SELECT 
a."id",
a."first_name",
a."last_name",
b."street",
b."city",
b."state",
b."zip",
b."address_type"
FROM "customers" a, "addresses" b
WHERE a."id" = b."customer_id"
;

-- Get all orders and their line items (orders, quantity and product).

SELECT
a."id",
b."quantity",
c."description"
FROM "orders" a, "line_items" b, "products" c
WHERE a."id" = b."order_id"
AND b."product_id" = c."id"
ORDER by a."id", b."quantity" desc
;

-- Which warehouses have cheetos?

SELECT
a."warehouse",
b."on_hand",
c."description"
FROM "warehouse" a, "warehouse_product" b, "products" c
WHERE a."id" = b."warehouse_id"
AND b."product_id" = c."id"
AND c."description" = 'cheetos'
;

-- Which warehouses have diet pepsi?

SELECT
a."warehouse",
b."on_hand",
c."description"
FROM "warehouse" a, "warehouse_product" b, "products" c
WHERE a."id" = b."warehouse_id"
AND b."product_id" = c."id"
AND c."description" = 'diet pepsi'
;

-- Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.

SELECT
a."id",
a."first_name",
a."last_name",
count(c."address_id") as orders
FROM "customers" a
JOIN "addresses" b ON a."id" = b."customer_id"
JOIN "orders" c ON b."id" = c."address_id"
GROUP by a."id", a."first_name", a."last_name"
;

--How many customers do we have?
SELECT
count(*) as "customer_total"
from "customers"
;

--How many products do we carry?
SELECT 
count(*) as "product_total"
FROM "products"
;
--What is the total available on-hand quantity of diet pepsi?
SELECT
b."description",
sum(a."on_hand")
FROM "warehouse_product" a, "products" b
where a."product_id" = b."id"
AND b."description" = 'diet pepsi'
GROUP by b."description"
;
--How much was the total cost for each order?
SELECT
a."order_id",
sum(a."quantity" * b."unit_price") as "total_cost"
FROM "line_items" a, "products" b
WHERE a."product_id" = b."id"
GROUP BY a."order_id"
;
--How much has each customer spent in total?
SELECT
e."first_name",
e."last_name",
sum(b."unit_price" * a."quantity")
FROM "line_items" a, "products" b, "orders" c, "addresses" d, "customers" e
WHERE a."product_id" = b."id"
AND a."order_id" = c."id"
AND c."address_id" = d."id"
AND d."customer_id" = e."id"
GROUP BY e."first_name", e."last_name"
;