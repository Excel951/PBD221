INSERT INTO DETAILPENERIMAAN VALUES ('IN2109150001', 'BVG0001', '60000', '10');
INSERT INTO DETAILPENERIMAAN VALUES ('IN2106120001', 'FTS0001', '150000', '10');
INSERT INTO DETAILPENERIMAAN VALUES ('IN2102200001', 'FDS0001', '121000', '11');

COMMIT;

INSERT INTO DETAILPENGELUARAN VALUES ('OUT2103120001', 'BVG0001', '3');
INSERT INTO DETAILPENGELUARAN VALUES ('OUT2105230001', 'BVG0002', '7');
INSERT INTO DETAILPENGELUARAN VALUES ('OUT2102110001', 'FTS0002', '12');

COMMIT;

INSERT INTO PENERIMAAN VALUES ('IN2109150001', TO_DATE('2021-09-15', 'YYYY-MM-DD'), 'BVG-01', '00001', 'Penerimaan 10 Pocari Sweat', '10');
INSERT INTO PENERIMAAN VALUES ('IN2106120001', TO_DATE('2021-06-12', 'YYYY-MM-DD'), 'FTS-01', '00002', 'Penerimaan 10 kg Semangka', '10');
INSERT INTO PENERIMAAN VALUES ('IN2102200001', TO_DATE('2021-02-22', 'YYYY-MM-DD'), 'FDS-01', '00003', 'Penerimaan 11 pcs Keju Cheddar', '10');

commit;

INSERT INTO PENGELUARAN VALUES ('OUT2103120001', TO_DATE('2021-03-12', 'YYYY-MM-DD'), '00002', 'Pengeluaran 3 Pocari Sweat', '3');
INSERT INTO PENGELUARAN VALUES ('OUT2105230001', TO_DATE('2021-05-23', 'YYYY-MM-DD'), '00002', 'Pengeluaran 7 kg Semangka', '7');
INSERT INTO PENGELUARAN VALUES ('OUT2102110001', TO_DATE('2021-02-11', 'YYYY-MM-DD'), '00003', 'Pengeluaran 12 kg Melon', '12');

commit;