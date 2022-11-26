CREATE OR REPLACE PROCEDURE LATIHANUTS2 (
    TGLAWAL IN VARCHAR2,
    TGLAKHIR IN VARCHAR2
) AS
BEGIN
DECLARE
    NO NUMBER;
    QTYAWAL NUMBER;
    QTYPERTENGAHAN NUMBER;
    QTY2BLN NUMBER;
    QTYAKHIR NUMBER;
    TEMPPRODUCT NUMBER;
    TEMPIDORDER NUMBER;
    -- CURSOR BATAS1 IS
    --     SELECT 
    --         O.ORDER_ID,
    --         OI.PRODUCT_ID AS "ID PRODUK",
    --         P.PRODUCT_NAME AS "NAMA PRODUK",
    --         O.STATUS
    --     FROM PRODUCTS P
    --     JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID=P.PRODUCT_ID
    --     JOIN ORDERS O ON O.ORDER_ID=OI.ORDER_ID
    --     WHERE O.ORDER_DATE BETWEEN TO_DATE('1-1-2016', 'dd-mm-yyyy') AND TO_DATE('1-3-2016', 'dd-mm-yyyy')
    --     ORDER BY O.ORDER_ID;

    CURSOR BATAS1 IS
        SELECT 
            I.PRODUCT_ID AS IDPRODUK,
            P.PRODUCT_NAME AS NAME,
            SUM(I.QUANTITY) AS JUMLAHAWAL,
            SUM(OI.QUANTITY) AS JUMLAHAKHIR
        FROM INVENTORIES I 
        JOIN PRODUCTS P ON P.PRODUCT_ID=I.PRODUCT_ID
        JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID=I.PRODUCT_ID
        JOIN ORDERS O ON O.ORDER_ID=OI.ORDER_ID
        WHERE O.ORDER_DATE BETWEEN TO_DATE('1-1-2016', 'dd-mm-yyyy') AND TO_DATE('1-3-2016', 'dd-mm-yyyy')
        AND O.STATUS='Shipped'
        GROUP BY I.PRODUCT_ID, P.PRODUCT_NAME;

    CURSOR BATAS2 IS
        SELECT
            O.ORDER_DATE
        FROM ORDERS O
        WHERE O.ORDER_DATE BETWEEN TO_DATE('1-1-2016', 'dd-mm-yyyy') AND TO_DATE('1-3-2016', 'dd-mm-yyyy') 
        AND O.STATUS='Shipped';

    CURSOR BATAS3 IS
        SELECT
            I.PRODUCT_ID,
            SUM(I.QUANTITY) AS JUMLAHAWAL,
            SUM(OI.QUANTITY) AS JUMLAHAKHIR
        FROM INVENTORIES I 
        JOIN PRODUCTS P ON P.PRODUCT_ID=I.PRODUCT_ID
        JOIN ORDER_ITEMS OI ON OI.PRODUCT_ID=I.PRODUCT_ID
        JOIN ORDERS O ON O.ORDER_ID=OI.ORDER_ID
        WHERE O.ORDER_DATE BETWEEN TO_DATE('1-1-2010', 'dd-mm-yyyy') AND TO_DATE('1-1-2016', 'dd-mm-yyyy')
        AND O.STATUS='Shipped'
        GROUP BY I.PRODUCT_ID, P.PRODUCT_NAME;

    -- CURSOR BATAS3 IS
    --     SELECT
    --         O.ORDER_DATE AS TANGGAL,
    --         O.STATUS AS STATUS,
    --         OI.PRODUCT_ID AS "ID PRODUK",
    --         O.ORDER_ID AS IDORDER,
    --         OI.QUANTITY AS "JUMLAH KELUAR",
    --         E.FIRST_NAME||' '||E.LAST_NAME AS NMSALES,
    --         C.NAME AS NMCUST
    --     FROM ORDER_ITEMS OI
    --     JOIN ORDERS O ON O.ORDER_ID=OI.ORDER_ID
    --     JOIN CUSTOMERS C ON C.CUSTOMER_ID=O.CUSTOMER_ID
    --     JOIN EMPLOYEES E ON E.EMPLOYEE_ID=O.SALESMAN_ID
    --     WHERE O.ORDER_DATE BETWEEN TO_DATE('1-1-2016', 'dd-mm-yyyy') AND TO_DATE('1-3-2016', 'dd-mm-yyyy');
    --     -- ORDER BY O.ORDER_DATE;



BEGIN


    FOR AA IN BATAS1 LOOP
        DBMS_OUTPUT.PUT_LINE('KODEBRG | NAMA PROD | STOK AWAL | KELUAR | STOK AKHIR');
        DBMS_OUTPUT.PUT_LINE();

        FOR AC IN BATAS3 LOOP



            FOR AB IN BATAS1 LOOP
                DBMS_OUTPUT.PUT_LINE(AB.IDPRODUK||' | '||AB.NAME||' | '||);

            END LOOP;

        END LOOP;

    END LOOP;




    -- FOR OUTPUT1 IN BATAS1 LOOP
    --         NO:=0;
    --         QTYMASUK:=0;
    --         QTYKELUAR:=0;
    --         QTYTOTAL:=0;
    --         -- TEMPIDORDER:=OUTPUT1.IDORDER;

    --     IF OUTPUT1.STATUS = 'Shipped' THEN
    --         TEMPPRODUCT:=OUTPUT1."ID PRODUK";

    --         DBMS_OUTPUT.PUT_LINE('Kode Produk: '||OUTPUT1."ID PRODUK");
    --         DBMS_OUTPUT.PUT_LINE('Nama Produk: '||OUTPUT1."NAMA PRODUK");
    --         DBMS_OUTPUT.PUT_LINE('=====================================');
    --         DBMS_OUTPUT.PUT_LINE('========== INVENTORI PRODUK ==========');
    --         DBMS_OUTPUT.PUT_LINE('No. | Deskripsi       | Jumlah Barang');

    --         FOR AWAL IN BATAS2 LOOP
    --             IF TEMPPRODUCT = AWAL."ID PRODUK" THEN
    --                 NO:=NO+1;
    --                 QTYMASUK:=AWAL."JUMLAH AWAL"+QTYMASUK;
    --                 DBMS_OUTPUT.PUT_LINE(NO||'. | Produk di gudang '||AWAL.NMGUDANG||' | '||AWAL."JUMLAH AWAL");

    --             END IF;

    --         END LOOP;

    --         DBMS_OUTPUT.PUT_LINE('========== PRODUK KELUAR ==========');
    --         DBMS_OUTPUT.PUT_LINE('No. | Tanggal       | Order ID | Nama Customer    | Nama Sales        | Jumlah Barang Keluar');

    --         NO:=0;

    --         FOR AKHIR IN BATAS3 LOOP
    --             IF TEMPPRODUCT = AKHIR."ID PRODUK" THEN
    --                 NO:=NO+1;
    --                 DBMS_OUTPUT.PUT_LINE(NO||'. | '||AKHIR.TANGGAL||'    | '||AKHIR.IDORDER||' | '||AKHIR.NMCUST||' | '||AKHIR.NMSALES||' | '||AKHIR."JUMLAH KELUAR");
    --                 QTYKELUAR:=AKHIR."JUMLAH KELUAR"+QTYKELUAR;

    --             END IF;

    --         END LOOP;

    --         DBMS_OUTPUT.PUT_LINE('=====================================');

    --         QTYTOTAL:=QTYMASUK-QTYKELUAR;
    --         DBMS_OUTPUT.PUT_LINE('Rincian: ');
    --         DBMS_OUTPUT.PUT_LINE('Barang di gudang: '||QTYMASUK);
    --         DBMS_OUTPUT.PUT_LINE('Barang keluar: '||QTYKELUAR);
    --         IF ABS(QTYTOTAL)-QTYTOTAL = 0 THEN
    --             DBMS_OUTPUT.PUT_LINE('Produk tersisa '||ABS(QTYTOTAL)||' item');
    --         ELSE
    --             DBMS_OUTPUT.PUT_LINE('Produk kurang '||ABS(QTYTOTAL)||' item');

    --         END IF;


    --         DBMS_OUTPUT.PUT_LINE('=====================================');
    --         DBMS_OUTPUT.PUT_LINE('=====================================');

    --     END IF;

    -- END LOOP;

END;
END;


EXEC LATIHANUTS2('1-1-2016', '1-3-2016');