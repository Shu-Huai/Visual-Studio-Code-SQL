DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS patients;
CREATE TABLE `patients`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `infected_by_id` INT,
    PRIMARY KEY (`id`)
);
select name
from patients
where name not in (
        select name
        from patients
        where infected_by_id = "2"
    );