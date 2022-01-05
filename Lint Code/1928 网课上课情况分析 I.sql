DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS online_class_situations;
CREATE TABLE `online_class_situations`(
    `student_id` INT NOT NULL,
    `device_id` INT NOT NULL,
    `date` DATE NOT NULL,
    `course_number` INT NOT NULL,
    PRIMARY KEY (`student_id`, `date`)
);
select student_id,
    min(date) as earliest_course_date
from online_class_situations
where course_number > '0'
group by student_id;