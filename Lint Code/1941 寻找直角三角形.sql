DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS line_segments;
CREATE TABLE `line_segments`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `a` INT NOT NULL,
    `b` INT NOT NULL,
    `c` INT NOT NULL,
    PRIMARY KEY (`id`)
);
select id,
    a,
    b,
    c,
    if (a * a + b * b = c * c, "Yes", "No") as right_triangle
from line_segments;