SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    SALARY
FROM
    EMPLOYEES
ORDER BY
    SALARY DESC;

-- MENCARI GAJI TERBESAR KEDUA
SELECT
    MAX(SALARY)
FROM
    EMPLOYEES
WHERE
    SALARY NOT IN (
        SELECT
            MAX(SALARY)
        FROM
            EMPLOYEES
    );

-- MENCARI GAJI TERBESAR KETIGA
-- CONTOH KE 1
SELECT
    MAX(SALARY)
FROM
    EMPLOYEES
WHERE
    SALARY NOT IN (
        SELECT
            MAX(SALARY)
        FROM
            EMPLOYEES
    );

-- CONTOH KE 2
SELECT
    *
FROM
    EMPLOYEES
WHERE
    SALARY = (
        SELECT
            MAX(SALARY)
        FROM
            EMPLOYEES
        WHERE
            SALARY < (
                SELECT
                    MAX(SALARY)
                FROM
                    EMPLOYEES
            )
    );

-- CONTOH KE 3
SELECT
    *
FROM
    (
        SELECT
            SALARY,
            DENSE_RANK()OVER(
        ORDER BY
            SALARY DESC)R
        FROM
            EMPLOYEES
    )
WHERE
    R=2;