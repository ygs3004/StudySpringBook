/*Spring Security 자동 로그인 테이블*/
CREATE TABLE persistent_logins(
    username VARCHAR2(64) NOT NULL,
    series VARCHAR2(64) PRIMARY KEY,
    token VARCHAR2(64) NOT NULL,
    last_used TIMESTAMP NOT NULL
);

SELECT * FROM persistent_logins;