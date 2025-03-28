---COMSULTAS--
SELECT name_users FROM users.users;
1
SELECT p.id, p.date_promotion, p.amount_promotion, p.discount
FROM promotion.promotion p
JOIN store.item i ON p.id_item = i.id
WHERE i.name_item = 'Pan de Molde';

2
SELECT v.id, v.date_sale, v.stock
FROM sale.sale v
JOIN users.users u ON v.id_users = u.id
WHERE u.name_users = 'bob_jones';

3

SELECT e.name_employee, e.ap_paterno, e.ap_materno, c.date_contract, p.name_position
FROM users.employee e
JOIN users.contract c ON e.id = c.id_employee
JOIN users.position p ON c.id_position = p.id
WHERE p.name_position = 'Cajero';


 4
 SELECT e.name_employee, e.ap_paterno, e.ap_materno, p.name_position, v.date_sale
FROM users.employee e
JOIN sale.sale v ON e.id = v.id_users 
JOIN users.contract c ON e.id = c.id_employee 
JOIN users.position p ON c.id_position = p.id 
WHERE v.id_users IS NOT NULL;


5
SELECT i.name_item, s.final_amount - s.amount_store AS stock_remaining
FROM store.item i
JOIN store.store s ON i.id = s.id_item
WHERE i.name_item = 'Pan de Molde'
AND s.motion = 'i';
6

SELECT DISTINCT bs.supplier_name, bs.company_name, bs.email, bs.number_phone
FROM buys.buys_supplier bs
JOIN buys.buys b ON bs.id = b.id_buys_supplier
JOIN buys.buys_detail bd ON b.id_buys_detail = bd.id
JOIN store.item i ON bd.id_item = i.id
WHERE i.name_item = 'Pan de Molde';

--CONSULTAS AVANZADAS--

1
SELECT SUM(s.stock) AS ingreso_total
FROM sale.sale s
WHERE EXTRACT(MONTH FROM s.date_sale) = '03' 
  AND EXTRACT(YEAR FROM s.date_sale) = '2025';

2
SELECT i.name_item, SUM(sd.amount) AS cantidad_vendida
FROM sale.sale_detail sd
JOIN store.item i ON sd.id_item = i.id
GROUP BY i.name_item
ORDER BY cantidad_vendida DESC
LIMIT 1;
3
SELECT c.name_client, SUM(sd.amount) AS cantidad_comprada
FROM sale.sale s
JOIN sale.sale_detail sd ON s.id_detail = sd.id
JOIN sale.client c ON s.id_client = c.id
GROUP BY c.name_client
ORDER BY cantidad_comprada DESC
LIMIT 1;
4
SELECT c.name_client, MAX(s.monto_total) AS max_purchase_cost
FROM sale.sale s
JOIN sale.client c ON s.id_client = c.id
GROUP BY c.name_client
ORDER BY max_purchase_cost DESC
LIMIT 1;
5
SELECT COUNT(*) AS cantidad_clientes
FROM sale.client;
6
SELECT i.name_item, s.amount_store
FROM store.item i
JOIN store.store s ON i.id = s.id_item
WHERE s.amount_store < 10;
