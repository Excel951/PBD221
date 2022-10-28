CREATE OR REPLACE PROCEDURE LATIHANUTS2 (
    TGLAWAL IN VARCHAR2,
    TGLAKHIR IN VARCHAR2
) AS
BEGIN
DECLARE
    CURSOR BATAS IS
        SELECT 
            o.ORDER_ID,
            o.ORDER_DATE AS TANGGAL,
            o.STATUS AS STATUS,
            p.PRODUCT_ID AS "ID PRODUK",
            p.PRODUCT_NAME AS "NAMA PRODUK",
            p.LIST_PRICE AS HARGA,
            i.WAREHOUSE_ID AS "ID GUDANG",
            w.WAREHOUSE_NAME AS NMGUDANG,
            i.QUANTITY AS "JUMLAH AWAL",
            oi.QUANTITY AS "JUMLAH KELUAR"
            -- SUM(CASE 
            --     WHEN o.STATUS LIKE 'Shipped' THEN oi.QUANTITY
            --     ELSE 0
            --     END
            -- ) AS "JUMLAH KELUAR" ,
            -- (i.QUANTITY - 
            --     SUM(CASE 
            --         WHEN o.STATUS LIKE 'Shipped' THEN oi.QUANTITY
            --         ELSE 0
            --         END
            --     )
            -- ) AS "JUMLAH AKHIR"
        FROM INVENTORIES i 
        JOIN ORDER_ITEMS oi ON oi.PRODUCT_ID = i.PRODUCT_ID
        JOIN ORDERS o ON o.ORDER_ID = oi.ORDER_ID 
        JOIN PRODUCTS p ON p.PRODUCT_ID = i.PRODUCT_ID 
        JOIN WAREHOUSES w ON w.WAREHOUSE_ID=i.WAREHOUSE_ID
        WHERE o.ORDER_DATE BETWEEN TO_DATE(TGLAWAL, 'dd-mm-yyyy') AND TO_DATE(TGLAKHIR, 'dd-mm-yyyy')
        GROUP BY o.ORDER_DATE , p.PRODUCT_NAME , p.LIST_PRICE , i.QUANTITY , oi.QUANTITY ,
                    o.STATUS , p.PRODUCT_ID , o.ORDER_ID , W.WAREHOUSE_NAME , i.WAREHOUSE_ID
        ORDER BY o.ORDER_DATE;

    NO NUMBER;
    QTYMASUK NUMBER;
    QTYKELUAR NUMBER;
    QTYTOTAL NUMBER;
    TEMPPRODUCT NUMBER;
    TEMPWARE NUMBER;

BEGIN

    FOR OUTPUT1 IN BATAS LOOP
        NO:=0;
        QTYMASUK:=0;
        QTYKELUAR:=0;
        QTYTOTAL:=0;
        TEMPPRODUCT:=OUTPUT1."ID PRODUK";
        TEMPWARE:=OUTPUT1."ID GUDANG";

        DBMS_OUTPUT.PUT_LINE('Tanggal: '||OUTPUT1.TANGGAL);
        DBMS_OUTPUT.PUT_LINE('Kode Produk: '||OUTPUT1."ID PRODUK");
        DBMS_OUTPUT.PUT_LINE('=====================================');
        DBMS_OUTPUT.PUT_LINE('No. | Deskripsi       | Jumlah');

        FOR AWAL IN BATAS LOOP
            IF TEMPPRODUCT = AWAL."ID PRODUK" THEN
                NO:=NO+1;
                DBMS_OUTPUT.PUT_LINE(NO||'. | Produk di gudang '||AWAL.NMGUDANG||' | '||AWAL."JUMLAH AWAL");
                QTYMASUK:=AWAL."JUMLAH AWAL"+QTYMASUK;

            END IF;

        END LOOP;

        FOR AKHIR IN BATAS LOOP
            IF TEMPPRODUCT = AKHIR."ID PRODUK" THEN
                NO:=NO+1;
                DBMS_OUTPUT.PUT_LINE(NO||'. | Produk keluar (order_id: '||AKHIR.ORDER_ID||') | '||AKHIR."JUMLAH KELUAR");
                QTYKELUAR:=AKHIR."JUMLAH KELUAR"+QTYKELUAR;

            END IF;

        END LOOP;

        QTYTOTAL:=QTYMASUK-QTYKELUAR;
        IF MOD(QTYTOTAL /*N2*/, ABS(QTYTOTAL) /*N1*/) = 1 THEN
            DBMS_OUTPUT.PUT_LINE(OUTPUT1."NAMA PRODUK"||' dengan ID: '||OUTPUT1."ID PRODUK"||' tersisa '||QTYTOTAL);
        ELSE IF MOD(QTYTOTAL /*N2*/, ABS(QTYTOTAL) /*N1*/) = -1 THEN
            DBMS_OUTPUT.PUT_LINE(OUTPUT1."NAMA PRODUK"||' dengan ID: '||OUTPUT1."ID PRODUK"||' kurang '||QTYTOTAL);

        END IF;
        END IF;

    END LOOP;

END;
END;


EXEC LATIHANUTS2('1-1-2016', '31-12-2017');