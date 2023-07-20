INSERT INTO a3_client VALUES (
    '12345678',
    'Jasser Abdelfattah',
    '12,Naser City,Cairo',
    '01005679978',
    NULL
);

INSERT INTO a3_client VALUES (
    '34789056',
    'Ahmed ELSayed',
    '56,Rehab City,Cairo',
    '01157878865',
    NULL
);

INSERT INTO a3_client VALUES (
    '56767965',
    'Tony James',
    '6,October City,Giza',
    '01137657743',
    NULL
);
 

INSERT INTO a3_outing(outing_id,tour_id,outing_start,guide)
VALUES (21000209,100345,TO_DATE('2022-06-17','yyyy-mm-dd'),982354)

INSERT INTO a3_participant VALUES (
    21000209,
    12345678
);

INSERT INTO a3_participant VALUES (
    21000209,
    34789056
);

INSERT INTO a3_participant VALUES (
    21000209,
    56767965
);