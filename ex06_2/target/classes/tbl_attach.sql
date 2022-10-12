CREATE TABLE tbl_attach(
  uuid VARCHAR2(100) not null,
  uploadPath VARCHAR2(200) not null,
  fileName VARCHAR2(200) not null,
  fileType char(1) default 'I',
  bno NUMBER(10, 0)
);

ALTER TABLE tbl_attach ADD CONSTRAINT pk_attach PRIMARY KEY (uuid);

ALTER TABLE tbl_attach ADD CONSTRAINT fk_board_attach FOREIGN KEY (bno) REFERENCES tbl_board(bno);

COMMIT;

SELECT * FROM tbl_attach;