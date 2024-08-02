--a) Crear la base de datos con el archivo create_restaurant_db.sql
--b) Explorar la tabla “menu_items” para conocer los productos del menú.
SELECT * FROM MENU_ITEMS

--1.- Realizar consultas para contestar las siguientes preguntas:
--Encontrar el número de artículos en el menú. 
SELECT COUNT(*)
FROM MENU_ITEMS;

EL MENU CONSTA DE 32 ARTICULOS
	
--¿Cuál es el artículo menos caro y el más caro en el menú?
SELECT ITEM_NAME, PRICE
FROM MENU_ITEMS
ORDER BY PRICE;

SELECT MIN (PRICE)
FROM MENU_ITEMS;

SELECT MAX (PRICE)
FROM MENU_ITEMS;

EDAMAME ES EL ARTICULO MENOS CARO CON 5.00
SHRIMP SCAMPI ES EL ARTICULO MAS CARO CON 19.95

--¿Cuántos platos americanos hay en el menú?
SELECT * FROM MENU_ITEMS
WHERE CATEGORY IN ('American');

SELECT COUNT(CATEGORY)
FROM MENU_ITEMS
WHERE CATEGORY IN ('American');

LOS PLATOS CON CATEGORIA AMERICANA SON 6

--¿Cuál es el precio promedio de los platos?
SELECT ROUND (AVG (PRICE),2)
FROM MENU_ITEMS;

EL PRECIO PROMEDIO DE LOS PLATOS ES DE 13.29
	
--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados. 
SELECT * FROM ORDER_DETAILS

--1.- Realizar consultas para contestar las siguientes preguntas:
--¿Cuántos pedidos únicos se realizaron en total?
SELECT DISTINCT ORDER_ID
FROM ORDER_DETAILS
ORDER BY ORDER_ID;

SELECT COUNT (DISTINCT ORDER_ID) AS "RECUENTO DE PEDIDOS UNICOS"
FROM ORDER_DETAILS;

SE REALIZARON 5370 PEDIDOS ÚNICOS

--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
SELECT ORDER_ID, COUNT (ITEM_ID)
FROM ORDER_DETAILS
GROUP BY ORDER_ID
ORDER BY 2 DESC
LIMIT 5;

LOS 5 PEDIDOS CON EL MAYOR NUMERO DE ARTICULOS FUERON EL 440, 2675,3473,4305 Y 443.
TODOS CON UN TOTAL DE 14 ARTICULOS.
	
--¿Cuándo se realizó el primer pedido y el último pedido?
SELECT *
FROM ORDER_DETAILS
ORDER BY ORDER_DATE ASC
LIMIT 1;

EL PRIMER PEDIDO SE REALIZO EL 2023-01-01

SELECT *
FROM ORDER_DETAILS
ORDER BY ORDER_DATE DESC
LIMIT 1;

EL ULTIMO PEDIDO SE REALIZO EL 2023-03-31

--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
SELECT * FROM ORDER_DETAILS
WHERE ORDER_DATE BETWEEN '2023-01-01' AND '2023-01-05'

SE REALIZARON 702 PEDIDOS ENTRE '2023-01-01' y el '2023-01-05'

--d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
--1.- Realizar un left join entre entre order_details y menu_items con el identificador item_id(tabla order_details) 
y menu_item_id(tabla menu_items).

SELECT order_details.item_id,
	order_details.order_id,
	order_details.order_date,
	order_details.order_time,
	order_details.order_details_id,
	menu_items.menu_item_id,
	menu_items.item_name,
	menu_items.category,
	menu_items.price
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id=menu_items.menu_item_id

SELECT *
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.ITEM_ID=M.MENU_ITEM_ID

--CONSULTAS ADICIONALES

--Los 3 platillos más pedidos:
SELECT COUNT (O.ORDER_ID), M.ITEM_NAME
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.ITEM_ID=M.MENU_ITEM_ID
GROUP BY M.ITEM_NAME
ORDER BY COUNT (O.ORDER_ID) DESC
LIMIT 3

--Las 3 categorías con mayor número de pedidos
SELECT COUNT (O.ORDER_ID), M.CATEGORY
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.ITEM_ID=M.MENU_ITEM_ID
GROUP BY M.CATEGORY
ORDER BY COUNT (O.ORDER_ID) DESC
LIMIT 3

--LAS 3 fechas con mayor número de pedidos
SELECT COUNT (O.ORDER_ID), O.ORDER_DATE
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.ITEM_ID=M.MENU_ITEM_ID
GROUP BY O.ORDER_DATE
ORDER BY COUNT (O.ORDER_ID) DESC
LIMIT 3

--Las 3 ordenes con mayor precio pagadas
SELECT SUM (M.PRICE), O.ORDER_ID
FROM MENU_ITEMS AS M
LEFT JOIN ORDER_DETAILS AS O
ON O.ITEM_ID=M.MENU_ITEM_ID
GROUP BY O.ORDER_ID
ORDER BY SUM (M.PRICE) DESC
LIMIT 3

--LAS 3 horas con mayor número de pedidos
SELECT COUNT (O.ORDER_ID), O.ORDER_TIME
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.ITEM_ID=M.MENU_ITEM_ID
GROUP BY O.ORDER_TIME
ORDER BY COUNT (O.ORDER_ID) DESC
LIMIT 3


