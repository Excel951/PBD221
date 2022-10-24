CREATE OR REPLACE PROCEDURE LATIHANUTS2 (
    TGLAWAL IN VARCHAR2,
    TGLAKHIR IN VARCHAR2
) AS
BEGIN
DECLARE
    CURSOR BATAS IS
        SELECT 
            o.ORDER_DATE AS TANGGAL,
            o.STATUS AS STATUS,
            p.PRODUCT_NAME AS "NAMA PRODUK",
            p.LIST_PRICE AS HARGA,
            i.QUANTITY AS "JUMLAH AWAL",
            SUM(CASE 
                WHEN o.STATUS LIKE 'Shipped' THEN 1
                WHEN o.STATUS LIKE 'Pending' THEN 0
                ELSE 0
                END
            ) AS "JUMLAH KELUAR" ,
            (i.QUANTITY - 
                SUM(CASE 
                    WHEN o.STATUS LIKE 'Shipped' THEN 1
                    WHEN o.STATUS LIKE 'Pending' THEN 0
                    ELSE 0
                    END
                )
            ) AS "JUMLAH AKHIR"
        FROM INVENTORIES i 
        JOIN ORDER_ITEMS oi ON oi.PRODUCT_ID = i.PRODUCT_ID
        JOIN ORDERS o ON o.ORDER_ID = oi.ORDER_ID 
        JOIN PRODUCTS p ON p.PRODUCT_ID = i.PRODUCT_ID 
        WHERE o.ORDER_DATE BETWEEN TO_DATE(TGLAWAL, 'dd-mm-yyyy') AND TO_DATE(TGLAKHIR, 'dd-mm-yyyy')
        GROUP BY o.ORDER_DATE , p.PRODUCT_NAME , p.LIST_PRICE , i.QUANTITY , o.STATUS , p.PRODUCT_ID 
        ORDER BY p.PRODUCT_ID;

BEGIN

    FOR OUTPUT IN BATAS LOOP

        DBMS_OUTPUT.PUT_LINE('============================');
        DBMS_OUTPUT.PUT_LINE('TANGGAL: '||OUTPUT.TANGGAL);
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('STATUS ORDER: '||OUTPUT.STATUS);
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('NAMA PRODUK: '||OUTPUT."NAMA PRODUK");
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('HARGA: '||OUTPUT.HARGA);
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('JUMLAH AWAL: '||OUTPUT."JUMLAH AWAL");
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('JUMLAH KELUAR: '||OUTPUT."JUMLAH KELUAR");
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('JUMLAH AKHIR: '||OUTPUT."JUMLAH AKHIR");
        DBMS_OUTPUT.PUT_LINE(' ');

    END LOOP;

END;
END;


EXEC LATIHANUTS2('1-1-2016', '31-12-2017');