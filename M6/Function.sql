-- FUNCTION1
CREATE OR REPLACE FUNCTION FUNCTION1 (
    PARAM1 IN VARCHAR2
) RETURN VARCHAR2 AS
BEGIN
    RETURN PARAM1;
END;

-- RUN FUNCTION1
BEGIN
DBMS_OUTPUT.PUT_LINE(FUNCTION1('AGUS'));
END;

-- FUNCTION2
CREATE OR REPLACE FUNCTION FUNCTION2 (
    PARAM1 IN NUMBER,
    PARAM2 IN NUMBER
) RETURN NUMBER AS
BEGIN
DECLARE
    HASIL NUMBER:=0;
BEGIN
    HASIL:=PARAM1+PARAM2;
    RETURN HASIL;
END;
END FUNCTION2;

-- RUN FUNCTION2
BEGIN
DBMS_OUTPUT.PUT_LINE(FUNCTION2(8,2));
END;

-- FUNCTION3
CREATE OR REPLACE FUNCTION FUNCTION3 (
    PARAM1 IN NUMBER
) RETURN VARCHAR2 AS
X CUSTOMERS.CUSTOMER_ID%TYPE;
Z CUSTOMERS.NAME%TYPE;
BEGIN
    SELECT
        CUSTOMER_ID,
        NAME
    INTO X,Z
    FROM CUSTOMERS
    WHERE CUSTOMER_ID=PARAM1;
    RETURN X||' '||Z;
END;

-- RUN FUNCTION3
BEGIN
DBMS_OUTPUT.PUT_LINE(FUNCTION3(40));
END;

-- TUGAS
-- TABEL ORDER DENGAN DETIL ORDER YANG BISA MENGHITUNG JUMLAH TOTAL
-- INPUT TANGGAL AWAL - AKHIR
-- MUNCUL ORDER DAN DETAIL SERTA JUMLAH ORDER
-- TOTAL DITAMPILKAN DI AKHIR
CREATE OR REPLACE FUNCTION TUGASM6(
    PARAM IN 
)