SELECT
    *
FROM
    PRODUCTS
WHERE
    PRODUCT_NAME='Kingston';

SELECT
    PRODUCT_ID   AS "ID PRODUK",
    PRODUCT_NAME AS "NAMA PRODUK",
    LIST_PRICE   AS HARGA
FROM
    PRODUCTS
WHERE
    LIST_PRICE>500
    AND LIST_PRICE<1000
ORDER BY
    LIST_PRICE;

SELECT
    *
FROM
    ORDERS
WHERE
    STATUS='Shipped'
    AND SALESMAN_ID='62'
    AND EXTRACT(YEAR FROM ORDER_DATE) = 2017
ORDER BY
    ORDER_DATE;

SELECT
    ORDERS.ORDER_ID,
    ORDERS.STATUS,
    ORDERS.ORDER_DATE,
    EMPLOYEES.FIRST_NAME||' '||EMPLOYEES.LAST_NAME AS "SALES NAME",
    CUSTOMERS.NAME                                 AS "CUSTOMER",
    PRODUCTS.PRODUCT_ID,
    PRODUCTS.PRODUCT_NAME,
    PRODUCTS.STANDARD_COST,
    ORDER_ITEMS.QUANTITY
FROM
    ORDERS
    INNER JOIN CUSTOMERS
    ON ORDERS.CUSTOMER_ID=CUSTOMERS.CUSTOMER_ID
    INNER JOIN ORDER_ITEMS
    ON ORDERS.ORDER_ID=ORDER_ITEMS.ORDER_ID
    INNER JOIN EMPLOYEES
    ON EMPLOYEES.EMPLOYEE_ID=ORDERS.SALESMAN_ID
    INNER JOIN PRODUCTS
    ON PRODUCTS.PRODUCT_ID=ORDER_ITEMS.PRODUCT_ID
ORDER BY
    CUSTOMERS.NAME,
    ORDERS.STATUS DESC;

SELECT
    EMPLOYEES.FIRST_NAME||' '||EMPLOYEES.LAST_NAME AS "SALES NAME",
    ORDERS.ORDER_ID,
    ORDERS.STATUS,
    ORDERS.ORDER_DATE,
    CUSTOMERS.NAME                                 AS "CUSTOMER",
    PRODUCTS.PRODUCT_ID,
    PRODUCTS.PRODUCT_NAME,
    PRODUCTS.STANDARD_COST,
    ORDER_ITEMS.QUANTITY
FROM
    ORDERS
    INNER JOIN CUSTOMERS
    ON ORDERS.CUSTOMER_ID=CUSTOMERS.CUSTOMER_ID
    INNER JOIN ORDER_ITEMS
    ON ORDERS.ORDER_ID=ORDER_ITEMS.ORDER_ID
    INNER JOIN EMPLOYEES
    ON EMPLOYEES.EMPLOYEE_ID=ORDERS.SALESMAN_ID
    INNER JOIN PRODUCTS
    ON PRODUCTS.PRODUCT_ID=ORDER_ITEMS.PRODUCT_ID
ORDER BY
    CUSTOMERS.NAME,
    ORDERS.STATUS DESC;

SELECT
    EMPLOYEES.FIRST_NAME||' '||EMPLOYEES.LAST_NAME AS SALES,
    ORDERS.ORDER_ID,
    ORDERS.STATUS,
    ORDERS.ORDER_DATE
FROM
    ORDERS
    RIGHT JOIN EMPLOYEES
    ON EMPLOYEES.EMPLOYEE_ID=ORDERS.SALESMAN_ID
WHERE
    ORDERS.ORDER_ID IS NOT NULL
ORDER BY
    EMPLOYEES.EMPLOYEE_ID,
    STATUS DESC;

SELECT
    EMPLOYEES.FIRST_NAME,
    COUNT(ORDER_ID)
FROM
    ORDERS
    RIGHT JOIN EMPLOYEES
    ON EMPLOYEES.EMPLOYEE_ID=ORDERS.SALESMAN_ID
HAVING
    COUNT(ORDER_ID)>0
GROUP BY
    EMPLOYEES.FIRST_NAME;

SELECT
    CUSTOMERS.NAME,
    SUM(PRODUCTS.LIST_PRICE*ORDER_ITEMS.QUANTITY)
FROM
    ORDERS
    JOIN CUSTOMERS
    ON CUSTOMERS.CUSTOMER_ID=ORDERS.CUSTOMER_ID JOIN ORDER_ITEMS
    ON ORDER_ITEMS.ORDER_ID=ORDERS.ORDER_ID
    JOIN PRODUCTS
    ON PRODUCTS.PRODUCT_ID=ORDER_ITEMS.PRODUCT_ID
GROUP BY
    CUSTOMERS.NAME
ORDER BY
    SUM(PRODUCTS.LIST_PRICE*ORDER_ITEMS.QUANTITY);

SELECT
    ADD_MONTHS(SYSDATE,
    9999999999999999999999999999999999999999999999999999999999999999999999999999999)
FROM
    DUAL;