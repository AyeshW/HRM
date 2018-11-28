CREATE DEFINER=`root`@`localhost` PROCEDURE `addDepartment` (IN `Department_ID` VARCHAR(7), `Department_Name` VARCHAR(20), `Building` VARCHAR(20), `Description` VARCHAR(100))  BEGIN

INSERT INTO department (Department_ID,Department_Name,Building,Description) values (Department_ID,Department_Name,Building,Description);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addEmployee` (IN `Employee_id` VARCHAR(7), `username` VARCHAR(20), `password` VARCHAR(255), `type` ENUM('Admin','HRM','Employee'), `dbuser` VARCHAR(20), `dbpass` VARCHAR(255), `First_name` VARCHAR(20), `Middle_name` VARCHAR(20), `Last_name` VARCHAR(20), `birthday` DATE, `Marital_status` ENUM('Unmarried','Married'), `Gender` ENUM('Male','Female'), `supervisor_empid` VARCHAR(7), `Employement_status_id` VARCHAR(7), `department_id` VARCHAR(7), `job_id` VARCHAR(7))  BEGIN
START TRANSACTION;
IF username is null or password is null then
INSERT INTO employee (Employee_id,First_Name,Middle_name,Last_name,birthday,Marital_status,Gender,supervisor_emp_id) values (Employee_id,First_name,Middle_name,Last_name,birthday,Marital_status,Gender,supervisor_empid);
INSERT INTO employementdetails (Employee_id,Employement_status_id,department_id,job_id) values (Employee_id,Employement_status_id,department_id,job_id);
else
INSERT INTO employee (Employee_id,First_Name,Middle_name,Last_name,birthday,Marital_status,Gender,supervisor_emp_id) values (Employee_id,First_name,Middle_name,Last_name,birthday,Marital_status,Gender,supervisor_empid);
INSERT INTO employementdetails (Employee_id,Employement_status_id,department_id,job_id) values (Employee_id,Employement_status_id,department_id,job_id);
INSERT INTO user (Employee_id,username,password,type,dbname,dbpass) values (Employee_id,username,password,type,dbuser,dbpass);

END IF;
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addEmploymentStatus` (IN `Status_ID` VARCHAR(7), `Status_name` VARCHAR(20))  BEGIN

INSERT INTO employment_status (Status_ID,Status_name) values (Status_ID,Status_name);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addJobTitle` (IN `Job_ID` VARCHAR(7), `Job_Name` VARCHAR(20))  BEGIN

INSERT INTO job_titile (Job_ID, Job_Name) values (Job_ID, Job_Name);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `applyLeave` (IN `Employee_id` VARCHAR(7), `start_date` DATE, `end_date` DATE, `Leave_Type` ENUM('Annual','Casual','Maternity','No_pay'), `reason` VARCHAR(20))  BEGIN
INSERT INTO employee_leaves (Employee_id,start_date,end_date,Leave_Type,reason,status) VALUES (Employee_id,start_date,end_date,Leave_Type,reason,'Pending');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeByDepartment` (IN `given_department_id` VARCHAR(7))  BEGIN

SELECT Employee_id,first_name,last_name,birthday,Gender,supervisor_emp_id,Department_Name,Job_Name,Status_name FROM employee JOIN employementdetails using(Employee_id) JOIN department using (department_id) jOIN employment_status on employementdetails.employement_status_id = employment_status.status_id JOIN job_titile using (Job_id) WHERE employementdetails.department_id = given_department_id ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeByJobTitle` (IN `given_job_title_id` VARCHAR(7))  BEGIN

SELECT Employee_id,first_name,last_name,birthday,Gender,supervisor_emp_id,Department_Name,Job_Name,Status_name FROM employee JOIN employementdetails using(Employee_id) JOIN department using (department_id) jOIN employment_status on employementdetails.employement_status_id = employment_status.status_id JOIN job_titile using (Job_id) WHERE employementdetails.job_id = given_job_title_id ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeByPayGrade` (IN `given_pay_grade_id` VARCHAR(7))  BEGIN

SELECT Employee_id,first_name,last_name,birthday,Gender,supervisor_emp_id,Department_Name,Job_Name,Status_name FROM employee JOIN payroll_info using(Employee_id) JOIN employementdetails using (Employee_id) JOIN department using (department_id) JOIN employment_status on employementdetails.Employement_status_id=employment_status.Status_ID JOIN job_titile on employementdetails.job_id=job_titile.Job_ID WHERE payroll_info.pay_grade_id = given_pay_grade_id ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeByStatus` (IN `given_status_id` VARCHAR(7))  BEGIN

SELECT Employee_id,first_name,last_name,birthday,Gender,supervisor_emp_id,Department_Name,Job_Name,Status_name FROM employee JOIN employementdetails using(Employee_id) JOIN department using (department_id) jOIN employment_status on employementdetails.employement_status_id = employment_status.status_id JOIN job_titile using (Job_id) WHERE employementdetails.Employement_status_id = given_status_id ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getEmergencyDetails` (IN `Employee_id` VARCHAR(7))  BEGIN

SELECT name,contact_no,Relationship,Address from employee NATURAL JOIN emergency_details where Employee.Employee_id= Employee_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `remaining_annual_leaves_procedure` (IN `E_id` VARCHAR(7))  BEGIN

select((select annual_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select annual_count from taken_no_of_leaves where employee_id=E_id)) as number;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `remaining_casual_leaves_procedure` (IN `E_id` VARCHAR(7))  BEGIN

select((select casual_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select casual_count from taken_no_of_leaves where employee_id=E_id)) as number;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `remaining_maternity_leaves_procedure` (IN `E_id` VARCHAR(7))  BEGIN

select((select maternity_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select maternity_count from taken_no_of_leaves where employee_id=E_id)) as number;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `remaining_no_pay_leaves_procedure` (IN `E_id` VARCHAR(7))  BEGIN

select((select no_pay_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select no_pay_count from taken_no_of_leaves where employee_id=E_id)) as number;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewPersonalInfo` (IN `given_employee_id` VARCHAR(7))  BEGIN

SELECT Employee_id,first_name,supervisor_emp_id,Department_Name,Job_Name,Status_name,pay_grade_id FROM employee JOIN employementdetails using(Employee_id) JOIN department using (department_id) jOIN employment_status on employementdetails.employement_status_id = employment_status.status_id JOIN job_titile using (Job_id) JOIN payroll_info using (Employee_id) WHERE employementdetails.employee_id = given_employee_id ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewTakenLeaveInfo` (IN `given_employee_id` VARCHAR(7))  BEGIN
if (select gender from employee where employee_id=given_employee_id) ='Male'THEN

SELECT Annual_count,casual_count,no_pay_count FROM taken_no_of_leaves WHERE taken_no_of_leaves.Employee_id=given_employee_id;

else

SELECT Annual_count,casual_count,maternity_count,no_pay_count FROM taken_no_of_leaves WHERE taken_no_of_leaves.Employee_id=given_employee_id;

END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `remaining_annual_leaves` (`E_id` VARCHAR(7)) RETURNS INT(11) BEGIN
DECLARE annual int(11);
set annual=(select((select annual_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select casual_count from taken_no_of_leaves where employee_id=E_id)));
return annual;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `remaining_casual_leaves` (`E_id` VARCHAR(7)) RETURNS INT(11) BEGIN
DECLARE casual int(11);
set casual=(select((select casual_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select casual_count from taken_no_of_leaves where employee_id=E_id)));
return casual;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `remaining_maternity_leaves` (`E_id` VARCHAR(7)) RETURNS INT(11) BEGIN
DECLARE maternity int(11);
set maternity=(select((select maternity_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select maternity_count from taken_no_of_leaves where employee_id=E_id)));
return maternity;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `remaining_no_pay_leaves` (`E_id` VARCHAR(7)) RETURNS INT(11) BEGIN
DECLARE no_pay int(11);
set no_pay=(select((select no_pay_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select no_pay_count from taken_no_of_leaves where employee_id=E_id)));
return no_pay;
end$$

DELIMITER ;
