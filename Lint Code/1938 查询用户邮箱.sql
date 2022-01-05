DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS users;
CREATE TABLE `users`(
    `username` VARCHAR(50) NOT NULL,
    `password` VARCHAR(16) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`username`)
);
select username,
    email
from users
where username = "zhangsan"
    and password = "zs789852";