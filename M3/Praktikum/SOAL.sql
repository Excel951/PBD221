-- Tampilkan region, negara, kota, dan kodepos dimana kantor
-- berada beserta nama manager yang memimpin
SELECT
    DEPARTMENTS.DEPARTMENT_ID                      AS "ID DEPARTEMEN",
    DEPARTMENTS.DEPARTMENT_NAME                    AS "NAMA DEPARTEMEN",
    EMPLOYEES.FIRST_NAME||' '||EMPLOYEES.LAST_NAME AS MANAGER,
    LOCATIONS.STREET_ADDRESS||', '||LOCATIONS.CITY AS ALAMAT,
    LOCATIONS.STATE_PROVINCE                       AS PROVINSI,
    COUNTRIES.COUNTRY_NAME                         AS NEGARA,
    REGIONS.REGION_NAME,
    LOCATIONS.POSTAL_CODE                          AS "KODE POS"
FROM
    DEPARTMENTS
    JOIN EMPLOYEES
    ON DEPARTMENTS.MANAGER_ID=EMPLOYEES.EMPLOYEE_ID JOIN LOCATIONS
    ON LOCATIONS.LOCATION_ID=DEPARTMENTS.LOCATION_ID
    JOIN COUNTRIES
    ON COUNTRIES.COUNTRY_ID=LOCATIONS.COUNTRY_ID JOIN REGIONS
    ON REGIONS.REGION_ID=COUNTRIES.REGION_ID;

-- Tampilkan manager yang menjabat pada rentang tahun 2005-2010
SELECT
    EMPLOYEES.EMPLOYEE_ID                          AS ID,
    EMPLOYEES.FIRST_NAME||' '||EMPLOYEES.LAST_NAME AS MANAGER,
    JOB_HISTORY.END_DATE                           AS "TURUN JABATAN"
FROM
    EMPLOYEES
    JOIN JOB_HISTORY
    ON JOB_HISTORY.EMPLOYEE_ID=EMPLOYEES.EMPLOYEE_ID
WHERE
    TO_CHAR(JOB_HISTORY.END_DATE, 'YYYY') BETWEEN 2005
    AND 2010
    AND JOB_HISTORY.JOB_ID IN (
        SELECT
            X.JOB_ID
        FROM
            JOBS X
        WHERE
            X.JOB_TITLE LIKE '%Manager%'
    );

-- Tampilkan rata-rata komisi sales dikelompokkan berdasarkan job
SELECT
    JOBS.JOB_ID    AS "JOB ID",
    JOBS.JOB_TITLE AS "NAMA JOB",
    AVG(EMPLOYEES.COMMISSION_PCT)
FROM
    EMPLOYEES
    JOIN JOBS
    ON JOBS.JOB_ID=EMPLOYEES.JOB_ID
HAVING
    AVG(EMPLOYEES.COMMISSION_PCT) IS NOT NULL
GROUP BY
    JOBS.JOB_ID, JOBS.JOB_TITLE;