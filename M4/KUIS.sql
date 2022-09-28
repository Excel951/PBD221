-- 1. TAMPILKAN ORDERS DENGAN ORDER_ID = DIGIT NIM, DENGAN NAMA, ADDRESS, WEBSITE, CREDIT_LIMIT,
-- DARI CUSTOMER DENGAN FIRST_NAME, EMAIL, PHONE, JOB_TITLE DARI EMPLOYEE

SELECT
    O.ORDER_ID,
    C.NAME,
    C.ADDRESS,
    C.WEBSITE,
    C.CREDIT_LIMIT,
    E.FIRST_NAME,
    E.EMAIL,
    E.PHONE,
    E.JOB_TITLE
FROM
    ORDERS    O
    JOIN CUSTOMERS C
    ON C.CUSTOMER_ID=O.CUSTOMER_ID JOIN EMPLOYEES E
    ON E.EMPLOYEE_ID=O.SALESMAN_ID
WHERE
    O.ORDER_ID=45;

-- 2. TAMPILKAN ORDERS, DENGAN PRODUCT_NAME, DESCRIPTION DARI PRODUCTS DENGAN CATEGORY_NAME
-- DARI PRODUCT_CATEGORIES

SELECT
    O.ORDER_ID,
    P.PRODUCT_NAME,
    P.DESCRIPTION,
    PC.CATEGORY_NAME
FROM
    ORDER_ITEMS        OI
    JOIN PRODUCTS P
    ON OI.PRODUCT_ID=P.PRODUCT_ID JOIN ORDERS O
    ON O.ORDER_ID=OI.ORDER_ID
    JOIN PRODUCT_CATEGORIES PC
    ON PC.CATEGORY_ID=P.CATEGORY_ID
WHERE
    O.ORDER_ID=45;

SELECT
    *
FROM
    PRODUCTS;

SELECT
    MAX(LIST_PRICE)
FROM
    PRODUCTS;

SELECT
    *
FROM
    PRODUCTS
WHERE
    LIST_PRICE=(
        SELECT
            MAX(LIST_PRICE)
        FROM
            PRODUCTS
    );

SELECT
    P.PRODUCT_ID     AS ID,
    P.PRODUCT_NAME   AS NAME,
    SUM(OI.QUANTITY) AS SOLD
FROM
    PRODUCTS    P
    JOIN ORDER_ITEMS OI
    ON P.PRODUCT_ID=OI.PRODUCT_ID
WHERE
    P.PRODUCT_NAME='Samsung MZ-V6P512BW'
GROUP BY
    P.PRODUCT_ID, P.PRODUCT_NAME;

SELECT
    P.PRODUCT_ID   AS ID,
    P.PRODUCT_NAME AS NAME,
    SUM(CASE
        WHEN O.STATUS IN ('Canceled', 'Pending') THEN
            0
        WHEN O.STATUS = 'Shipped' THEN
            1
    END)           AS QTY
 -- SUM(OI.QUANTITY) AS SOLD
FROM
    ORDER_ITEMS OI
    JOIN PRODUCTS P
    ON P.PRODUCT_ID=OI.PRODUCT_ID JOIN ORDERS O
    ON O.ORDER_ID=OI.ORDER_ID
WHERE
    P.PRODUCT_NAME='Samsung MZ-V6P512BW'
GROUP BY
    P.PRODUCT_ID,
    P.PRODUCT_NAME,
    O.STATUS;