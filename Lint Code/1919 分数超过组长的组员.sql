DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS group_members;
CREATE TABLE `group_members`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `score` INT NOT NULL,
    `group_leader_id` INT,
    PRIMARY KEY (`id`)
);
select distinct x.name
from group_members x,
    group_members y
where x.group_leader_id = y.id
    and x.score > y.score;