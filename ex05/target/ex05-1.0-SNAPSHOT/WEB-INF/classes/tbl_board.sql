DROP TABLE tbl_board;
DROP SEQUENCE seq_board;

CREATE SEQUENCE seq_board;

CREATE TABLE tbl_board(
    bno NUMBER(10,0),
    title VARCHAR2(200) not null,
    content VARCHAR2(2000) not null,
    writer VARCHAR2(50) not null,
    regDate DATE DEFAULT SYSDATE,
    updateDate DATE DEFAULT SYSDATE
);

ALTER TABLE tbl_board ADD CONSTRAINT pk_board PRIMARY KEY (bno);

INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');
INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');
INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');
INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');
INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');

COMMIT;

SELECT * FROM tbl_board WHERE bno > 0;

SELECT * FROM tbl_board ORDER BY BNO DESC;

INSERT INTO tbl_board (bno, title, content, writer) (SELECT seq_board.nextval, title, content, writer from tbl_board);

COMMIT;
SELECT /*+INDEX_DESC (tbl_board pk_board) */* from tbl_board;

ALTER TABLE tbl_board ADD (replyCnt NUMBER DEFAULT 0);

UPDATE tbl_board SET replyCnt = (SELECT count(rno) from tbl_reply WHERE tbl_reply.bno = tbl_board.bno);