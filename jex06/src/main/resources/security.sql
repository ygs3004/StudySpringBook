CREATE TABLE users(
    username VARCHAR2(50) NOT NULL PRIMARY KEY,
    password VARCHAR2(52) NOT NULL,
    enabled CHAR(1) default '1'
);
CREATE TABLE authorities(
    username VARCHAR2(50) NOT NULL,
    authority VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_authorities_users FOREIGN KEY (username) REFERENCES users(username)
);

CREATE UNIQUE INDEX ix_auth_username ON authorities(username, authority);

INSERT INTO users (username, password) VALUES('user00','pw00');
INSERT INTO users (username, password) VALUES('member00','pw00');
INSERT INTO users (username, password) VALUES('admin00','pw00');

INSERT INTO authorities (username, authority) VALUES('user00','ROLE_USER');
INSERT INTO authorities (username, authority) VALUES('member00','ROLE_MANAGER');
INSERT INTO authorities (username, authority) VALUES('admin00','ROLE_MANAGER');
INSERT INTO authorities (username, authority) VALUES('admin00','ROLE_ADMIN');

SELECT*FROM authorities;
SELECT*FROM users;
ROLLBACK ;
COMMIT;