CREATE USER 'universal'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON edbms.user TO 'universal'@'localhost'

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin@123';
CREATE USER 'HRM'@'localhost' IDENTIFIED BY 'HRM@123';
CREATE USER 'EMP'@'localhost' IDENTIFIED BY 'EMP@123';

GRANT ALL PRIVILEGES ON edbms.address TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.department TO  'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.dependent_info TO  'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.emergency_details TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.employee TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.employee_leaves TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.employementdetails TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.employment_status TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.job_title TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.organization TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.payroll_info TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON edbms.pay_grade TO 'admin'@'localhost';