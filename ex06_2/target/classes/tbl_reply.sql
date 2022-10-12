CREATE TABLE tbl_reply(
  rno NUMBER(10, 0),
  bno NUMBER(10, 0) not null,
  reply VARCHAR2(1000) not null,
  replyer VARCHAR2(50) not null,
  replyDate DATE DEFAULT SYSDATE,
  updateDate DATE DEFAULT SYSDATE
);

CREATE SEQUENCE seq_reply;

ALTER TABLE tbl_reply ADD CONSTRAINT pk_reply primary key (rno);

ALTER TABLE tbl_reply ADD CONSTRAINT fk_reply_board foreign key (bno) references tbl_board(bno);

SELECT * FROM tbl_board WHERE rownum < 10 ORDER BY bno DESC;

SELECT * FROM tbl_reply ORDER BY rno DESC;

CREATE INDEX idx_reply ON tbl_reply ( bno DESC, rno ASC);

COMMIT;
