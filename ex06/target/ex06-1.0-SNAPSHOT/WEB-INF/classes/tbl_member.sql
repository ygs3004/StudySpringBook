CREATE TABLE tbl_member(
    userid VARCHAR2(50) NOT NULL PRIMARY KEY,
    userpw VARCHAR2(100) not null,
    username VARCHAR2(100) not null,
    regdate DATE DEFAULT SYSDATE,
    updatedate DATE DEFAULT SYSDATE,
    enabled char(1) DEFAULT '1'
);

CREATE TABLE tbl_member_auth(
    userid VARCHAR2(50) NOT NULL,
    auth VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_member_auth FOREIGN KEY (userid) REFERENCES tbl_member(userid)

);


