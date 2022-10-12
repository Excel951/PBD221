-- MEMBUAT VIEW SEDERHANA
create view coba as
select PRODUCT_ID, product_name from products;

-- MEMBUAT PROSEDURE SEDERHANA
-- COBA1
CREATE OR REPLACE PROCEDURE COBA1 AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('TEST');
END;

-- RUN PROCEDURE COBA1
EXEC COBA1;

-- COBA2
CREATE OR REPLACE PROCEDURE COBA2(NAMA IS VARCHAR2) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO '||NAMA||'!!!');
END;

-- RUN PROCEDURE COBA2
EXEC COBA2('LOLOLOLOLOLOLOLOLOLOLO');

-- COBA3
CREATE OR REPLACE PROCEDURE COBA3 (
    PARAM1 IN NUMBER, 
    PARAM2 IN NUMBER
) AS 
BEGIN DECLARE
A NUMBER:=0;
BEGIN
    A:=PARAM1+PARAM2;
    DBMS_OUTPUT.PUT_LINE('HASIL = '||A);
    DBMS_OUTPUT.PUT_LINE('HASIL = ');
    DBMS_OUTPUT.PUT_LINE(PARAM1+PARAM2);
END;
END;

-- RUN PROCEDURE COBA3
EXEC COBA3(8, 3);

-- COBA4
CREATE OR REPLACE PROCEDURE COBA4 (
    PARAM1 IN NUMBER
) AS
BEGIN
DECLARE
    ID CUSTOMERS.CUSTOMER_ID%TYPE;
    NAME CUSTOMERS.NAME%TYPE;
BEGIN
    SELECT CUSTOMER_ID, NAME
    INTO ID, NAME
    FROM CUSTOMERS
    WHERE CUSTOMER_ID=PARAM1;

    DBMS_OUTPUT.PUT_LINE(ID);
    DBMS_OUTPUT.PUT_LINE(NAME);
END;
END;

-- RUN PROCEDURE COBA4
EXEC COBA4(100);

-- COBA5
