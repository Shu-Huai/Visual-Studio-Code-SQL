DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS recharges;
CREATE TABLE `users`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`)
);
CREATE TABLE `recharges`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    PRIMARY KEY (`id`)
);
select name as player
from users
    where id not in (
        select user_id
        from recharges
    );