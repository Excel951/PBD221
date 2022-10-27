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