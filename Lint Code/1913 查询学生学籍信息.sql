DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS students;
CREATE TABLE `students`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `student_name` VARCHAR(32) NOT NULL,
    `phone` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`)
);
CREATE TABLE `enrollments`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `student_id` INT UNSIGNED,
    `hometown` VARCHAR(50),
    `address` VARCHAR(50),
    PRIMARY KEY (`id`)
);
select students.student_name,
    students.phone,
    enrollments.hometown,
    enrollments.address
from students
    left outer join enrollments on students.id = enrollments.student_id;