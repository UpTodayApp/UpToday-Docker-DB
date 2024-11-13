CREATE DATABASE IF NOT EXISTS slave;
USE slave;

DROP USER IF EXISTS slave@127.0.0.1; 

CREATE USER 'slave'@'%' IDENTIFIED BY '1234';
GRANT REPLICATION SLAVE ON *.* TO 'slave'@'%';