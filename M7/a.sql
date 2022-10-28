SELECT 
            -- o.ORDER_ID,
            -- o.ORDER_DATE AS TANGGAL,
            -- o.STATUS AS STATUS,
            p.PRODUCT_ID,
            p.PRODUCT_NAME AS "NAMA PRODUK",
            i.WAREHOUSE_ID,
            p.DESCRIPTION,
            -- p.LIST_PRICE AS HARGA,
            i.QUANTITY AS "JUMLAH AWAL"
            -- SUM(CASE 
            --     WHEN o.STATUS LIKE 'Shipped' THEN oi.QUANTITY
            --     WHEN o.STATUS LIKE 'Pending' THEN 0
            --     ELSE 0
            --     END
            -- ) AS "JUMLAH KELUAR" ,
            -- (i.QUANTITY - 
            --     SUM(CASE 
            --         WHEN o.STATUS LIKE 'Shipped' THEN oi.QUANTITY
            --         WHEN o.STATUS LIKE 'Pending' THEN 0
            --         ELSE 0
            --         END
            --     )
            -- ) AS "JUMLAH AKHIR"
        FROM INVENTORIES i 
        JOIN ORDER_ITEMS oi ON oi.PRODUCT_ID = i.PRODUCT_ID
        JOIN ORDERS o ON o.ORDER_ID = oi.ORDER_ID 
        JOIN PRODUCTS p ON p.PRODUCT_ID = i.PRODUCT_ID 
        WHERE o.ORDER_DATE BETWEEN TO_DATE('1-1-2016', 'dd-mm-yyyy') AND TO_DATE('1-10-2016', 'dd-mm-yyyy');
        -- GROUP BY o.ORDER_DATE , p.PRODUCT_NAME , p.LIST_PRICE , i.QUANTITY , o.STATUS , p.PRODUCT_ID , o.ORDER_ID
        -- ORDER BY o.ORDER_DATE;




DECLARE
    NO NUMBER;
    QTYMASUK NUMBER;
    QTYKELUAR NUMBER;
    QTYTOTAL NUMBER;
    TEMPPRODUCT NUMBER;
    TEMPDATE ORDERS.ORDER_DATE%TYPE;
    CURSOR BATAS1 IS
        SELECT
            O.ORDER_DATE AS TANGGAL,
            P.PRODUCT_ID AS "ID PRODUK",
            P.PRODUCT_NAME AS "NAMA PRODUK",
            O.STATUS AS STATUS
        FROM ORDERS O
        JOIN ORDER_ITEMS OI ON OI.ORDER_ID=O.ORDER_ID
        JOIN PRODUCTS P ON P.PRODUCT_ID=OI.PRODUCT_ID
        WHERE O.ORDER_DATE BETWEEN TO_DATE('1-1-2016', 'dd-mm-yyyy') AND TO_DATE('1-10-2016', 'dd-mm-yyyy')
        ORDER BY O.ORDER_DATE;

    CURSOR BATAS2 IS
        SELECT 
            i.PRODUCT_ID AS "ID PRODUK",
            w.WAREHOUSE_NAME AS NMGUDANG,
            i.QUANTITY AS "JUMLAH AWAL"
        FROM INVENTORIES i 
        JOIN WAREHOUSES w ON w.WAREHOUSE_ID=i.WAREHOUSE_ID;

    CURSOR BATAS3 IS
        SELECT
            O.ORDER_DATE AS TANGGAL,
            OI.PRODUCT_ID AS "ID PRODUK",
            OI.ORDER_ID AS IDORDER,
            OI.QUANTITY AS "JUMLAH KELUAR"
        FROM ORDER_ITEMS OI
        JOIN ORDERS O ON O.ORDER_ID=OI.ORDER_ID
        WHERE O.ORDER_DATE BETWEEN TO_DATE('1-1-2016', 'dd-mm-yyyy') AND TO_DATE('1-10-2016', 'dd-mm-yyyy')
        ORDER BY O.ORDER_DATE;


BEGIN

    FOR OUTPUT1 IN BATAS1 LOOP
        IF OUTPUT1.STATUS = 'Shipped' THEN
            NO:=0;
            QTYMASUK:=0;
            QTYKELUAR:=0;
            QTYTOTAL:=0;
            TEMPPRODUCT:=OUTPUT1."ID PRODUK";
            TEMPDATE:=OUTPUT1.TANGGAL;

            DBMS_OUTPUT.PUT_LINE('Tanggal: '||OUTPUT1.TANGGAL);
            DBMS_OUTPUT.PUT_LINE('Kode Produk: '||OUTPUT1."ID PRODUK");
            DBMS_OUTPUT.PUT_LINE('Nama Produk: '||OUTPUT1."NAMA PRODUK");
            DBMS_OUTPUT.PUT_LINE('=====================================');
            DBMS_OUTPUT.PUT_LINE('No. | Deskripsi       | Jumlah');

            FOR AWAL IN BATAS2 LOOP
                IF TEMPPRODUCT = AWAL."ID PRODUK" THEN
                    NO:=NO+1;
                    QTYMASUK:=AWAL."JUMLAH AWAL"+QTYMASUK;
                    DBMS_OUTPUT.PUT_LINE(NO||'. | Produk di gudang '||AWAL.NMGUDANG||' | '||AWAL."JUMLAH AWAL");

                END IF;

            END LOOP;

            FOR AKHIR IN BATAS3 LOOP
                IF TEMPPRODUCT = AKHIR."ID PRODUK" AND TEMPDATE = AKHIR.TANGGAL THEN
                    NO:=NO+1;
                    DBMS_OUTPUT.PUT_LINE(NO||'. | Produk keluar (order_id: '||AKHIR.IDORDER||') | '||AKHIR."JUMLAH KELUAR");
                    QTYKELUAR:=AKHIR."JUMLAH KELUAR"+QTYKELUAR;

                END IF;

            END LOOP;

            DBMS_OUTPUT.PUT_LINE('=====================================');

            QTYTOTAL:=QTYMASUK-QTYKELUAR;
            DBMS_OUTPUT.PUT_LINE('Rincian: ');
            DBMS_OUTPUT.PUT_LINE('Barang di gudang: '||QTYMASUK);
            DBMS_OUTPUT.PUT_LINE('Barang keluar: '||QTYKELUAR);
            IF ABS(QTYTOTAL)-QTYTOTAL = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Produk tersisa '||ABS(QTYTOTAL)||' item');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Produk kurang '||ABS(QTYTOTAL)||' item');

            END IF;


            DBMS_OUTPUT.PUT_LINE('=====================================');
            DBMS_OUTPUT.PUT_LINE('=====================================');

        END IF;

    END LOOP;

END;