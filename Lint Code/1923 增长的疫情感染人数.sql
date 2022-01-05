DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS new_cases;
CREATE TABLE `new_cases`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `date` DATE NOT NULL,
    `increased_count` INT NOT NULL,
    PRIMARY KEY (`id`)
);
select x.id
from new_cases x,
    new_cases y
where DATEDIFF(x.date, y.date) = 1
    and x.increased_count > y.increased_count