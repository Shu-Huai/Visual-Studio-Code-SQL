DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS coins;
CREATE TABLE `coins`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `side` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`)
);
update coins
set side = if(side = 'p', 'n', 'p');