DROP TABLE IF EXISTS students;
CREATE TABLE `students`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
);
select distinct name
from students
group by name
having count(*) > 1;