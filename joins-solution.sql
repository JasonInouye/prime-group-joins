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