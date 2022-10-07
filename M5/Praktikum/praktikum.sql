create or replace function NmLengkapKaryawan(id_k in EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN varchar2 IS
emp_name varchar2(50);
BEGIN
    SELECT FIRST_NAME||' '||LAST_NAME
    INTO emp_name
    from EMPLOYEES
    WHERE EMPLOYEE_ID=id_k;
    RETURN emp_name;
end;

SELECT
EMPLOYEE_ID,
NmLengkapKaryawan(EMPLOYEE_ID)
FROM EMPLOYEES
where EMPLOYEE_ID=200;

INSERT into REGIONS values (5, 'Eropa Timur');
delete from REGIONS where REGION_ID=5;

-- buat function untuk menambahkan region
-- ADD REGION
create or replace function addregion(id in NUMBER, nm_negara in varchar2)
return VARCHAR2 is 
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO REGIONS VALUES (id, nm_negara);
    commit;
    return 'Region dengan id = '||id||' berhasil ditambahkan';
end;

-- DELETE REGION
create or replace function delregion(id in NUMBER)
return VARCHAR2 is 
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    delete from REGIONS where REGIONS.REGION_ID=id;
    commit;
    return 'Region dengan id = '||id||' berhasil dihapus';
end;

SELECT addregion(5, 'Eropa Timur') FROM dual;
SELECT delregion(5) FROM dual;

-- buat function untuk menambahkan kategori gol pada DB Gudang
create or replace function addGolProduct(kode in KATEGORIBARANG.KODEGOL%TYPE, nama IN KATEGORIBARANG.NAMAGOL%TYPE)
RETURN VARCHAR2 IS 
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO KATEGORIBARANG VALUES (kode, nama);
    COMMIT;
    RETURN 'Kategori Barang dengan id: '||kode||' dan nama: '||nama||' berhasil ditambahkan';
end;

create or replace function delGolProduct(kode in KATEGORIBARANG.KODEGOL%TYPE)
RETURN VARCHAR2 IS 
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    DELETE FROM KATEGORIBARANG WHERE KATEGORIBARANG.KODEGOL=kode;
    COMMIT;
    RETURN 'Kategori Barang dengan id: '||kode||' berhasil dihapus';
end;

select addGolProduct('COM', 'Komputer') from dual;
SELECT delGolProduct('COM') from dual;