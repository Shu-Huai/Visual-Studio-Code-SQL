DROP DATABASE IF EXISTS judge;
CREATE DATABASE judge;
use judge;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS tenants;
CREATE TABLE `rooms`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `tenant_id` INT,
    `rent` INT NOT NULL,
    PRIMARY KEY (`id`)
);
CREATE TABLE `tenants`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
);
select rooms.id,
    rooms.rent,
    tenants.name
from rooms
    left outer join tenants on rooms.tenant_id = tenants.id;