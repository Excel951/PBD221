CREATE OR REPLACE FUNCTION CONTOH_FUNCTION RETURN VARCHAR2 IS
    TEKS VARCHAR(20);
BEGIN
    SELECT
        'ini function' INTO TEKS
    FROM
        DUAL;
    RETURN TEKS;
END CONTOH_FUNCTION;
SELECT
    CONTOH_FUNCTION
FROM
    DUAL;