CREATE OR REPLACE PROCEDURE PRINTINVOICE (
    ID IN ORDERS.ORDER_ID%TYPE
) AS
BEGIN
    DECLARE
        TOTAL NUMBER:=0;
        CURSOR KODETGL IS
            SELECT
                O.ORDER_ID,
                O.ORDER_DATE,
                C.NAME,
                E.FIRST_NAME,
                E.LAST_NAME,
                OI.QUANTITY,
                OI.UNIT_PRICE,
                P.PRODUCT_ID,
                P.PRODUCT_NAME
            FROM
                ORDERS      O
                JOIN CUSTOMERS C
                ON C.CUSTOMER_ID=O.CUSTOMER_ID JOIN EMPLOYEES E
                ON E.EMPLOYEE_ID=O.SALESMAN_ID
                JOIN ORDER_ITEMS OI
                ON OI.ORDER_ID=O.ORDER_ID JOIN PRODUCTS P
                ON P.PRODUCT_ID=OI.PRODUCT_ID
            WHERE
                O.ORDER_ID=4;
 -- cursor penjualan is select oi.ORDER_ID, OI.QUANTITY, OI.UNIT_PRICE, P.PRODUCT_ID, P.PRODUCT_NAME from order_items oi join PRODUCTS p on oi.PRODUCT_ID=p.PRODUCT_ID where order_id=4;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Toko Serba Emas');
        FOR KELUARAN IN KODETGL LOOP
            FOR KELUARAN IN KODETGL LOOP
                DBMS_OUTPUT.PUT_LINE('Kode: '
                    ||KELUARAN.ORDER_ID);
                DBMS_OUTPUT.PUT_LINE('Tanggal: '
                    ||KELUARAN.ORDER_DATE);
                DBMS_OUTPUT.PUT_LINE('Nama Customer: '
                    ||KELUARAN.NAME);
                DBMS_OUTPUT.PUT_LINE('Nama Sales: '
                    ||KELUARAN.FIRST_NAME
                    ||' '
                    ||KELUARAN.LAST_NAME);
                EXIT;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('=================================');
            DBMS_OUTPUT.PUT_LINE('No. item     |     Nama Item     |     Quantity     |     Price     |     Total');
            FOR KELUARAN IN KODETGL LOOP
                DBMS_OUTPUT.PUT_LINE(KELUARAN.PRODUCT_ID
                    ||'     |     '
                    ||KELUARAN.PRODUCT_NAME
                    ||'     |     '
                    ||KELUARAN.QUANTITY
                    ||'     |     '
                    ||KELUARAN.UNIT_PRICE
                    ||'     |     '
                    ||(KELUARAN.UNIT_PRICE*KELUARAN.QUANTITY));
                TOTAL:=TOTAL+(KELUARAN.UNIT_PRICE*KELUARAN.QUANTITY);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('=================================');
            DBMS_OUTPUT.PUT_LINE('Grand Total: '
                ||TOTAL);
            DBMS_OUTPUT.PUT_LINE('Terima Kasih Kedatangannya');
        END LOOP;
    END;
END;
EXEC PRINTINVOICE(4);