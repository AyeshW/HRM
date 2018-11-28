CREATE USER 'universal'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON edbms.user TO 'universal'@'localhost';

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


GRANT SELECT ON edbms.all_employee_data_for_admin TO 'admin'@'localhost'
GRANT EXECUTE ON PROCEDURE addEmployee TO 'admin'@'localhost';
GRANT EXECUTE ON PROCEDURE addDepartment TO 'admin'@'localhost';

GRANT EXECUTE ON PROCEDURE getEmergencyDetails TO 'HRM'@'localhost';
GRANT EXECUTE ON PROCEDURE addEmployee TO 'HRM'@'localhost';
GRANT EXECUTE ON PROCEDURE EmployeeByDepartment TO 'HRM'@'localhost';
GRANT EXECUTE ON PROCEDURE EmployeeBypayGrade TO 'HRM'@'localhost';
GRANT EXECUTE ON PROCEDURE EmployeeByStatus TO 'HRM'@'localhost';
GRANT EXECUTE ON PROCEDURE employeeByJobTitle TO 'HRM'@'localhost';

GRANT SELECT ON edbms.all_employee_data_for_admin TO 'EMP'@'localhost'


GRANT EXECUTE ON PROCEDURE remaining_annual_leaves_procedure TO 'EMP'@'localhost';
GRANT EXECUTE ON PROCEDURE remaining_casual_leaves_procedure TO 'EMP'@'localhost';
GRANT EXECUTE ON PROCEDURE remaining_maternity_leaves_procedure TO 'EMP'@'localhost';
GRANT EXECUTE ON PROCEDURE remaining_no_pay_leaves_procedure TO 'EMP'@'localhost';
GRANT EXECUTE ON PROCEDURE applyleave TO 'EMP'@'localhost';