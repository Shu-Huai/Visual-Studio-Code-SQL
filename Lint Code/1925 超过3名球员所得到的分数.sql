DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS player_scores;
CREATE TABLE `player_scores`(
    `player` VARCHAR(32) NOT NULL,
    `score` INT NOT NULL,
    PRIMARY KEY (`player`)
);
select score
from player_scores
group BY score
having COUNT(*) >= 3;