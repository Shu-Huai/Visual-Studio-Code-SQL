DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS student_scores;
CREATE TABLE `student_scores`(
    `name` VARCHAR(50) NOT NULL,
    `chinese` INT NOT NULL,
    `math` INT NOT NULL,
    `english` INT NOT NULL,
    `cst` INT NOT NULL,
    PRIMARY KEY (`name`)
);
select name,
    math,
    cst
from student_scores
where math > 90
    or cst > 95;