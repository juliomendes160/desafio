mysql -u root -pmysql -e "DROP DATABASE IF EXISTS cloudged; CREATE DATABASE IF NOT EXISTS cloudged;"

mysql -u root -pmysql

DROP DATABASE IF EXISTS `cloudged`;

CREATE DATABASE IF NOT EXISTS `cloudged`;

CREATE TABLE IF NOT EXISTS `cloudged`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `cloudged`.`user` (`name`, `email`, `password`) VALUES ('admin', 'admin@cloudged.com', 'cloudged');

SHOW DATABASES;
SHOW CREATE DATABASE cloudged;

EXIT

