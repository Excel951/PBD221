CREATE OR REPLACE PROCEDURE SOAL1 (
    TGLAWAL IN VARCHAR2,
    TGLAKHIR IN VARCHAR2
) AS
BEGIN
DECLARE

    IDTEMP1 NUMBER;
    IDTEMP2 NUMBER;
    GTOTAL NUMBER;
    TOTAL NUMBER:=0;
    NO NUMBER;
    CURSOR KODETGL IS
        SELECT
            O.ORDER_ID,
            OI.QUANTITY,
            OI.UNIT_PRICE,
            P.PRODUCT_ID,
            P.PRODUCT_NAME
        FROM
            ORDERS      O
            JOIN ORDER_ITEMS OI
            ON OI.ORDER_ID=O.ORDER_ID JOIN PRODUCTS P
            ON P.PRODUCT_ID=OI.PRODUCT_ID
        where
            O.ORDER_DATE BETWEEN TO_DATE(TGLAWAL, 'dd-mm-yyyy') AND TO_DATE(TGLAKHIR, 'dd-mm-yyyy')
        ORDER BY O.ORDER_ID ASC;
        --     O.ORDER_ID=4;
            
    cursor penjualan is 
        select 
            O.ORDER_ID,
            O.ORDER_DATE,
            C.NAME,
            E.FIRST_NAME,
            E.LAST_NAME
        from 
            ORDERS O
            JOIN CUSTOMERS C ON C.CUSTOMER_ID=O.CUSTOMER_ID
            JOIN EMPLOYEES E ON E.EMPLOYEE_ID=O.SALESMAN_ID
        where
            O.ORDER_DATE BETWEEN TO_DATE(TGLAWAL, 'dd-mm-yyyy') AND TO_DATE(TGLAKHIR, 'dd-mm-yyyy')
        ORDER BY O.ORDER_ID ASC;

BEGIN

    DBMS_OUTPUT.PUT_LINE('Toko Serba Emas');
    
    -- FOR BATASAN IN PENJUALAN LOOP
    --     IDTEMP1:=BATASAN.ORDER_ID;
    --     EXIT;
    -- END LOOP;

    FOR KELUARAN1 IN PENJUALAN LOOP
        NO:=0;
        GTOTAL:=0;
        -- FOR KELUARAN2 IN penjualan LOOP
            DBMS_OUTPUT.PUT_LINE('Kode: '
                ||KELUARAN1.ORDER_ID);
            DBMS_OUTPUT.PUT_LINE('Tanggal: '
                ||KELUARAN1.ORDER_DATE);
            DBMS_OUTPUT.PUT_LINE('Nama Customer: '
                ||KELUARAN1.NAME);
            DBMS_OUTPUT.PUT_LINE('Nama Sales: '
                ||KELUARAN1.FIRST_NAME
                ||' '
                ||KELUARAN1.LAST_NAME);
        --     EXIT;
        -- END LOOP;
        IDTEMP2:=KELUARAN1.ORDER_ID;
        -- DBMS_OUTPUT.PUT_LINE(IDTEMP2);
        DBMS_OUTPUT.PUT_LINE('=================================');
        DBMS_OUTPUT.PUT_LINE('No.       |       No. item     |     Nama Item     |     Quantity     |     Price     |     Total');
    
        FOR KELUARAN3 IN KODETGL LOOP
            IDTEMP1:=KELUARAN3.ORDER_ID;
            IF IDTEMP1 = IDTEMP2 THEN
                NO:=NO+1;
                DBMS_OUTPUT.PUT_LINE(KELUARAN3.ORDER_ID);
                DBMS_OUTPUT.PUT_LINE(NO
                    ||'     |     '
                    ||KELUARAN3.PRODUCT_ID
                    ||'     |     '
                    ||KELUARAN3.PRODUCT_NAME
                    ||'     |     '
                    ||KELUARAN3.QUANTITY
                    ||'     |     '
                    ||KELUARAN3.UNIT_PRICE
                    ||'     |     '
                    ||(KELUARAN3.UNIT_PRICE*KELUARAN3.QUANTITY));
                GTOTAL:=GTOTAL+(KELUARAN3.UNIT_PRICE*KELUARAN3.QUANTITY);

            END IF;

        END LOOP;
        DBMS_OUTPUT.PUT_LINE('=================================');
        DBMS_OUTPUT.PUT_LINE('Grand Total: '||GTOTAL);
        DBMS_OUTPUT.PUT_LINE('Terima Kasih Kedatangannya');
        TOTAL:=GTOTAL+TOTAL;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Jumlah Total Keseluruhan dari tanggal '||TGLAWAL||' - '||TGLAKHIR||' : '||TOTAL);
    
END;
END;


EXEC SOAL1('1-1-2016','1-3-2016');