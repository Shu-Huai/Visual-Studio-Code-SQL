DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS exams;
CREATE TABLE `exams`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `student_id` INT NOT NULL,
    `date` DATE NOT NULL,
    `is_pass` INT NOT NULL,
    PRIMARY KEY (`id`)
);
select student_id
from(
        select student_id,
            count(is_pass) as countUnpass
        from exams
        where is_pass = 0
        group by student_id
        order by countUnpass desc
        limit 1
    ) as x;