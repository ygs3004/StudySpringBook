CREATE TABLE tbl_sample1 (col1 VARCHAR2(500));
CREATE TABLE tbl_sample2 (col2 VARCHAR2(50));

SELECT*FROM tbl_sample1 ;
SELECT*FROM tbl_sample2 ;


DELETE tbl_sample1;
DELETE tbl_sample2;
COMMIT ;