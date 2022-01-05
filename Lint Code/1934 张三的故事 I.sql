DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS students;
CREATE TABLE `students`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `class_id` INT NOT NULL,
    PRIMARY KEY (`id`)
);
select name
from students
where name like ("zhang%")