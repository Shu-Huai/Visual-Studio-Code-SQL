DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS heroes;
CREATE TABLE `heroes`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `popularity` VARCHAR(50) NOT NULL,
    `ban` FLOAT NOT NULL,
    PRIMARY KEY (`id`)
);
select id,
    name,
    popularity,
    CONCAT(CAST(ban AS CHAR), '%') as probability
from heroes
where popularity != "T3"
    and id % 2 = 1
order by ban desc;