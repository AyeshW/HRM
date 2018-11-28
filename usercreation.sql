CREATE USER 'universal'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON edbms.user TO 'universal'@'localhost'

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin@123';
CREATE USER 'HRM'@'localhost' IDENTIFIED BY 'HRM@123';
CREATE USER 'EMP'@'localhost' IDENTIFIED BY 'EMP@123';