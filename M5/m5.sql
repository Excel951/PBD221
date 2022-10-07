SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World!');
END;

set serveroutput on;
DECLARE
    konsumen customers.name%TYPE;
    BEGIN
    SELECT name INTO konsumen
    FROM customers
    WHERE customer_id=43;
    DBMS_OUTPUT.put_line(konsumen);
END;

set serveroutput on;
DECLARE
    konsumen        customers%ROWTYPE;
    id_konsumen     customers.customer_id%type;
    BEGIN
    SELECT * INTO konsumen, id_konsumen
    FROM customers
    WHERE customer_id=&id_customer;
    DBMS_OUTPUT.put_line(konsumen.name||'`s Website: '||konsumen.website);
    dbms_output.put_line(id_konsumen);
END;

declare
step    PLS_INTEGER:=3;
begin
    for counter in 1..10
    loop
    dbms_output.put_line(counter*step);
    end loop;
end;

declare
cursor hasil is select * from customers;
begin
    for keluaran in hasil
    loop
        dbms_output.put_line(keluaran.name||'`s Website: '||keluaran.website);
    end loop;
end;



declare
cursor hasil is select * from customers where customer_id<43 and customer_id>0;
cursor hasilx is select * from customers where customer_id>10 and customer_id<100;
begin
    for keluaran in hasil
    loop
        dbms_output.put_line(keluaran.name||'`s Website: '||keluaran.website);
    end loop;
    
    for keluaran in hasilx
    loop
        dbms_output.put_line(keluaran.name||'`s Website: '||keluaran.website);
    end loop;
end;


declare
total       number:=0;
cursor kodetgl is select o.ORDER_ID, O.ORDER_DATE, C.NAME from orders o join CUSTOMERS c on c.CUSTOMER_ID=o.CUSTOMER_ID where order_id=4;
cursor penjualan is select oi.ORDER_ID, OI.QUANTITY, OI.UNIT_PRICE, P.PRODUCT_ID, P.PRODUCT_NAME from order_items oi join PRODUCTS p on oi.PRODUCT_ID=p.PRODUCT_ID where order_id=4;
begin
    dbms_output.PUT_LINE('Toko Serba Emas');

    for keluaran in kodetgl
    loop
        dbms_output.put_line('Kode: '||keluaran.order_id);
        dbms_output.put_line('Tanggal: '||keluaran.order_date);
        dbms_output.PUT_LINE('Nama Customer: '||keluaran.name);
    end loop;
    
    dbms_output.put_line('=================================');
    
    dbms_output.PUT_LINE('No. item     |     Nama Item     |     Quantity     |     Price     |     Total');

    for keluaran in penjualan
    loop
        dbms_output.put_line(keluaran.PRODUCT_ID||'     |     '||keluaran.PRODUCT_NAME||'     |     '||keluaran.quantity||'     |     '||keluaran.unit_price||'     |     '||(keluaran.unit_price*keluaran.quantity));
        total:=total+(keluaran.unit_price*keluaran.quantity);
    end loop;

    dbms_output.put_line('=================================');

    DBMS_OUTPUT.PUT_LINE('Grand Total: '||total);
    DBMS_OUTPUT.PUT_LINE('Terima Kasih Kedatangannya');
end;