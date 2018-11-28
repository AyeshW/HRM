-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2018 at 10:58 PM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `edbms`
--

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `Department_ID` varchar(7) NOT NULL,
  `Department_Name` varchar(20) NOT NULL,
  `Building` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`Department_ID`, `Department_Name`, `Building`, `Description`) VALUES
('100', 'Computer Science', 'Sumanadasa', '128 students per batch'),
('101', 'Electronic', 'Watson', '100 students per batch'),
('102', 'Electrical', 'Sumanadasa', '100 students per batch');

--
-- Triggers `department`
--
DELIMITER $$
CREATE TRIGGER `department_id_validation` BEFORE INSERT ON `department` FOR EACH ROW BEGIN
    IF NEW.Department_ID NOT LIKE "___" THEN
      SIGNAL SQLSTATE VALUE '45001'
        SET MESSAGE_TEXT = 'Invalid department id';
end if;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dependent_info`
--

CREATE TABLE `dependent_info` (
  `Employee_id` varchar(7) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `birthday` date NOT NULL,
  `relationship` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dependent_info`
--

INSERT INTO `dependent_info` (`Employee_id`, `first_name`, `last_name`, `birthday`, `relationship`) VALUES
('10001', 'Kasun', 'Prasad', '2000-11-07', 'Son'),
('10002', 'Maria', 'George', '1974-06-12', 'Wife'),
('10002', 'Mary', 'Jane', '2017-11-23', 'Daughter'),
('10004', 'Tony', 'Maven', '2004-09-26', 'Son');

--
-- Triggers `dependent_info`
--
DELIMITER $$
CREATE TRIGGER `dependent_info_validation` BEFORE INSERT ON `dependent_info` FOR EACH ROW BEGIN
    DECLARE p_birthday DATE;
    SELECT birthday INTO p_birthday FROM employee WHERE employee.Employee_id = NEW.Employee_id;

    IF NEW.relationship = 'Son' OR NEW.relationship = 'Daughter' THEN
      IF (EXTRACT(YEAR FROM NEW.birthday) - EXTRACT(YEAR  FROM p_birthday) <= 18) THEN
        SIGNAL SQLSTATE VALUE '45003'
          SET MESSAGE_TEXT = 'Unacceptable birthday for child';
      end if;
    end if;

  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `emergency_details`
--

CREATE TABLE `emergency_details` (
  `Employee_id` varchar(7) NOT NULL,
  `contact_no` int(10) NOT NULL,
  `Relationship` varchar(10) DEFAULT NULL,
  `Address` varchar(100) NOT NULL,
  `name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emergency_details`
--

INSERT INTO `emergency_details` (`Employee_id`, `contact_no`, `Relationship`, `Address`, `name`) VALUES
('10001', 774522654, 'Mother', '20/A, Piliyandala', 'Kamala');

-- --------------------------------------------------------
-- Table structure for table `address`
--

CREATE TABLE `Address` (
  `Employee_id` varchar(7) PRIMARY KEY NOT NULL,
  `po_box` int(10) ,
  `street` varchar(20) NOT NULL,
  `town` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL
  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address`
--
INSERT INTO Address (Employee_id,po_box,street,town,country) values ('10002',100,'udugama street','Kalugamuwa','Sri lanka');

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `Employee_id` varchar(7) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Middle_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `birthday` date NOT NULL,
  `Marital_Status` enum('Unmarried','Married') NOT NULL,
  `Gender` enum('Male','Female') NOT NULL,
  `supervisor_emp_id` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`Employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`Employee_id`, `First_Name`, `Middle_Name`, `Last_Name`, `birthday`, `Marital_Status`, `Gender`, `supervisor_emp_id`) VALUES
('10001', 'Charith', 'Rajitha', 'Perera', '1964-11-07', 'Married', 'Male', NULL),
('10002', 'Ayesh', 'Malindu', 'Weerasinghe', '1980-11-07', 'Unmarried', 'Male', '10001'),
('10003', 'Kalana', 'Dhananjaya', 'Silva', '1956-11-17', 'Unmarried', 'Male', '10001'),
('10004', 'Lakmali', 'Chandrapraba', 'Piyarathna', '1985-08-12', 'Married', 'Female', '10003');

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `employee_validation` BEFORE INSERT ON `employee` FOR EACH ROW BEGIN
    -- checking length of id = 5 or not
    IF NEW.Employee_id NOT LIKE "_____" THEN
      SIGNAL SQLSTATE VALUE '45000'
        SET MESSAGE_TEXT = 'Invalid employee id';
    end if;

    -- checking age of the employee is greater than 18 and less than 100
    IF (EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR  FROM NEW.birthday) <= 18) OR (EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR  FROM NEW.birthday) > 100) THEN

      SIGNAL SQLSTATE VALUE '45002'
        SET MESSAGE_TEXT = 'Unacceptable birthday';
    end if;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_leaves`
--

CREATE TABLE `employee_leaves` (
  `Leave_id` INT(7) primary key NOT NULL AUTO_INCREMENT,
  `Employee_id` varchar(7) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `Leave_Type` enum('Annual','Casual','Maternity','No-pay') NOT NULL,
  `Reason` varchar(20) NOT NULL,
  `status` enum('Pending','Approved','Rejected') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_leaves`
--

INSERT INTO `employee_leaves` (`Leave_id`, `Employee_id`, `start_date`, `end_date`, `Leave_Type`, `Reason`, `status`) VALUES
('1', '10002', '2018-11-13', '2018-11-15', 'Casual', 'Sickness', 'Approved'),
('2', '10001', '2018-11-02', '2018-11-02', 'Casual', 'Personal', 'Approved'),
('3', '10002', '2018-11-08', '2018-11-08', 'Annual', 'Personal', 'Pending'),
('4', '10002', '2018-11-01', '2018-11-01', 'No-pay', 'Sickness', 'Rejected');

--
-- Triggers `employee_leaves`
--
DELIMITER $$
CREATE TRIGGER `employee_leaves_validation` BEFORE INSERT ON `employee_leaves` FOR EACH ROW BEGIN
    /*DECLARE gender ENUM("Male","Female");
    SELECT Gender INTO gender FROM employee WHERE NEW.Employee_id = employee.Employee_id;

    IF NEW.Leave_Type = "Maternity" AND gender = "Male" THEN
      SIGNAL SQLSTATE VALUE '45005'
        SET MESSAGE_TEXT = 'Maternity leaves are only for females';
    end if;*/

    DECLARE grade VARCHAR(7);
    DECLARE avail_annual int;
    DECLARE avail_casual int;
    DECLARE avail_maternity int;
    DECLARE avail_nopay int;
    DECLARE taken_annual_leaves int;
    DECLARE taken_casual_leaves int;
    DECLARE taken_maternity_leaves int;
    DECLARE taken_nopay_leaves int;

    SELECT pay_grade_id INTO grade FROM payroll_info WHERE  NEW.Employee_id = payroll_info.Employee_id;

    SELECT Annual_leaves INTO avail_annual FROM pay_grade WHERE grade = pay_grade.pay_grade_id;
    SELECT Annual_count INTO taken_annual_leaves FROM taken_no_of_leaves WHERE NEW.Employee_id = taken_no_of_leaves.Employee_id;

    IF NEW.Leave_Type = 'Annual' AND (avail_annual <= taken_annual_leaves) THEN
      SIGNAL SQLSTATE VALUE '45006'
        set  message_text = 'No more annual leaves are allowed';
    end if;

    SELECT Casual_leaves INTO avail_casual FROM pay_grade WHERE grade = pay_grade.pay_grade_id;
    SELECT casual_count INTO taken_casual_leaves FROM taken_no_of_leaves WHERE NEW.Employee_id = taken_no_of_leaves.Employee_id;

    IF NEW.Leave_Type = 'Casual' AND (avail_casual <= taken_casual_leaves) THEN
      SIGNAL SQLSTATE VALUE '45007'
        set  message_text = 'No more casual leaves are allowed';
    end if;

    SELECT Maternity_leaves INTO avail_maternity FROM pay_grade WHERE grade = pay_grade.pay_grade_id;
    SELECT maternity_count INTO taken_maternity_leaves FROM taken_no_of_leaves WHERE NEW.Employee_id = taken_no_of_leaves.Employee_id;

    IF NEW.Leave_Type = 'Maternity' AND (avail_maternity <= taken_maternity_leaves) THEN
      SIGNAL SQLSTATE VALUE '45008'
        set  message_text = 'No more maternity leaves are allowed';
    end if;

    SELECT No_pay_leaves INTO avail_nopay FROM pay_grade WHERE grade = pay_grade.pay_grade_id;
    SELECT no_pay_count INTO taken_nopay_leaves FROM taken_no_of_leaves WHERE NEW.Employee_id = taken_no_of_leaves.Employee_id;

    IF NEW.Leave_Type = 'No-pay' AND (avail_nopay <= taken_nopay_leaves) THEN
      SIGNAL SQLSTATE VALUE '45009'
        set  message_text = 'No more no-pay leaves are allowed';
    end if;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employementdetails`
--

CREATE TABLE `employementdetails` (
  `Employee_id` varchar(7) NOT NULL,
  `Employement_status_id` varchar(7) NOT NULL,
  `department_id` varchar(7) NOT NULL,
  `job_id` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employementdetails`
--

INSERT INTO `employementdetails` (`Employee_id`, `Employement_status_id`, `department_id`, `job_id`) VALUES
('10001', '2', '100', '1'),
('10002', '3', '100', '4'),
('10003', '1', '102', '3'),
('10004', '2', '102', '2');

-- --------------------------------------------------------

--
-- Table structure for table `employment_status`
--

CREATE TABLE `employment_status` (
  `Status_ID` varchar(7) NOT NULL,
  `Status_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employment_status`
--

INSERT INTO `employment_status` (`Status_ID`, `Status_name`) VALUES
('1', 'intern'),
('2', 'full time'),
('3', 'part time');

-- --------------------------------------------------------

--
-- Table structure for table `job_titile`
--

CREATE TABLE `job_titile` (
  `Job_ID` varchar(7) NOT NULL,
  `Job_Name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `job_titile`
--

INSERT INTO `job_titile` (`Job_ID`, `Job_Name`) VALUES
('1', 'HR Manager'),
('2', 'Accountant'),
('3', 'Software Engineer'),
('4', 'QA Engineer');

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `Reg_No` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `Address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`Reg_No`, `name`, `Address`) VALUES
(1, 'Jupiter', 'Union Place');

-- --------------------------------------------------------

--
-- Table structure for table `payroll_info`
--

CREATE TABLE `payroll_info` (
  `Employee_id` varchar(7) NOT NULL,
  `pay_grade_id` varchar(7) NOT NULL,
  `epf_no` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payroll_info`
--

INSERT INTO `payroll_info` (`Employee_id`, `pay_grade_id`, `epf_no`) VALUES
('10001', '1', '700239'),
('10002', '2', '800896'),
('10003', '2', '800756'),
('10004', '3', '900123');

-- --------------------------------------------------------

--
-- Table structure for table `pay_grade`
--

CREATE TABLE `pay_grade` (
  `pay_grade_id` varchar(7) NOT NULL,
  `pay_grade` varchar(20) NOT NULL,
  `Annual_leaves` int(11) NOT NULL,
  `Casual_leaves` int(11) DEFAULT NULL,
  `Maternity_leaves` int(11) NOT NULL,
  `No_pay_leaves` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pay_grade`
--

INSERT INTO `pay_grade` (`pay_grade_id`, `pay_grade`, `Annual_leaves`, `Casual_leaves`, `Maternity_leaves`, `No_pay_leaves`) VALUES
('1', 'level 1', 20, 15, 84, 5),
('2', 'level 2', 15, 10, 84, 3),
('3', 'level 3', 10, 7, 84, 2);

-- --------------------------------------------------------

--
-- Table structure for table `taken_no_of_leaves`
--

CREATE TABLE `taken_no_of_leaves` (
  `Employee_id` varchar(20) NOT NULL,
  `Annual_count` int(11) NOT NULL,
  `casual_count` int(11) NOT NULL,
  `maternity_count` int(11) NOT NULL,
  `no_pay_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `taken_no_of_leaves`
--

INSERT INTO `taken_no_of_leaves` (`Employee_id`, `Annual_count`, `casual_count`, `maternity_count`, `no_pay_count`) VALUES
('10001', 0, 1, 0, 0),
('10002', 1, 3, 0, 1),
('10003', 0, 0, 0, 0),
('10004', 0, 7, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `Employee_id` varchar(7) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `dbname` varchar(20) NOT NULL,
  `dbpass` varchar(255) NOT NULL,
  `type` enum('Admin','HRM','Employee') NOT NULL,
  PRIMARY KEY (`Employee_id`),
    FOREIGN KEY (`Employee_id`) REFERENCES `Employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE)  

 
 ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Employee_id`, `username`, `password`, `type`,`dbname`,`dbpass`) VALUES
(10001, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Admin','root',''),(10002, 'emp', '21232f297a57a5a743894a0e4a801fc3', 'Employee','root',''),(10003, 'emp', '21232f297a57a5a743894a0e4a801fc3', 'HRM','root','');

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `user_validation` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    
    -- checking password length
    IF LENGTH(NEW.password) < 6 THEN
      SIGNAL SQLSTATE VALUE '45004'
        SET MESSAGE_TEXT = 'Password should have 6 minimum number of characters';
    end if;

  END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`Department_ID`);

--
-- Indexes for table `dependent_info`
--
ALTER TABLE `dependent_info`
  ADD PRIMARY KEY (`Employee_id`,`first_name`);

--
-- Indexes for table `emergency_details`
--
ALTER TABLE `emergency_details`
  ADD PRIMARY KEY (`Employee_id`,`name`);

  
--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  
  ADD KEY `Employee_Employee_Employee_id_fk` (`supervisor_emp_id`);


--
-- Indexes for table `employementdetails`
--
ALTER TABLE `employementdetails`
  ADD PRIMARY KEY (`Employee_id`),
  ADD KEY `EmployementDetails_employment_status_Status_ID_fk` (`Employement_status_id`),
  ADD KEY `EmployementDetails_department_Department_ID_fk` (`department_id`),
  ADD KEY `EmployementDetails_job_titile_Job_ID_fk` (`job_id`);

--
-- Indexes for table `employment_status`
--
ALTER TABLE `employment_status`
  ADD PRIMARY KEY (`Status_ID`);

--
-- Indexes for table `job_titile`
--
ALTER TABLE `job_titile`
  ADD PRIMARY KEY (`Job_ID`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`Reg_No`);

--
-- Indexes for table `payroll_info`
--
ALTER TABLE `payroll_info`
  ADD PRIMARY KEY (`Employee_id`),
  ADD KEY `payroll_info_pay_grade_pay_grade_id_fk` (`pay_grade_id`);

--
-- Indexes for table `pay_grade`
--
ALTER TABLE `pay_grade`
  ADD PRIMARY KEY (`pay_grade_id`);

--
-- Indexes for table `taken_no_of_leaves`
--
ALTER TABLE `taken_no_of_leaves`
  ADD PRIMARY KEY (`Employee_id`);

--


--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `Reg_No` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--

-- Constraints for dumped tables
--

--
-- Constraints for table `dependent_info`
--
ALTER TABLE `dependent_info`
  ADD CONSTRAINT `Dependent_info_employee_Employee_id_fk` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Constraints for table `Address`
--
ALTER TABLE `Address`
  ADD CONSTRAINT `Address_employee_Employee_id_fk` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `Employee_Employee_Employee_id_fk` FOREIGN KEY (`supervisor_emp_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_leaves`
--
ALTER TABLE `employee_leaves`
   add FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employementdetails`
--
ALTER TABLE `employementdetails`
  ADD CONSTRAINT `EmployementDetails_department_Department_ID_fk` FOREIGN KEY (`department_id`) REFERENCES `department` (`Department_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EmployementDetails_employee_Employee_id_fk` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EmployementDetails_employment_status_Status_ID_fk` FOREIGN KEY (`Employement_status_id`) REFERENCES `employment_status` (`Status_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EmployementDetails_job_titile_Job_ID_fk` FOREIGN KEY (`job_id`) REFERENCES `job_titile` (`Job_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payroll_info`
--
ALTER TABLE `payroll_info`
  ADD CONSTRAINT `payroll_info_employee_Employee_id_fk` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payroll_info_pay_grade_pay_grade_id_fk` FOREIGN KEY (`pay_grade_id`) REFERENCES `pay_grade` (`pay_grade_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `taken_no_of_leaves`
--
ALTER TABLE `taken_no_of_leaves`
  ADD CONSTRAINT `Taken_no_of_leaves_employee_Employee_id_fk` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


/* Function for selecting employee on pay grade */

DELIMITER $$

CREATE PROCEDURE employeeByPayGrade(IN given_pay_grade_id VARCHAR(7))

BEGIN

SELECT Employee_id,first_name,last_name,birthday,Gender,supervisor_emp_id,Department_Name,Job_Name,Status_name FROM employee JOIN payroll_info using(Employee_id) JOIN employementdetails using (Employee_id) JOIN department using (department_id) JOIN employment_status on employementdetails.Employement_status_id=employment_status.Status_ID JOIN job_titile on employementdetails.job_id=job_titile.Job_ID WHERE payroll_info.pay_grade_id = given_pay_grade_id ;

END $$

DELIMITER ;


\
/* Function for selecting employee on Job Title */

DELIMITER $$

CREATE PROCEDURE employeeByJobTitle(IN given_job_title_id VARCHAR(7))

BEGIN

SELECT Employee_id,first_name,last_name,birthday,Gender,supervisor_emp_id,Department_Name,Job_Name,Status_name FROM employee JOIN employementdetails using(Employee_id) JOIN department using (department_id) jOIN employment_status on employementdetails.employement_status_id = employment_status.status_id JOIN job_titile using (Job_id) WHERE employementdetails.job_id = given_job_title_id ;

END $$

DELIMITER ;



/* Function for selecting employee on employement status*/

DELIMITER $$

CREATE PROCEDURE employeeByStatus(IN given_status_id VARCHAR(7))

BEGIN

SELECT Employee_id,first_name,last_name,birthday,Gender,supervisor_emp_id,Department_Name,Job_Name,Status_name FROM employee JOIN employementdetails using(Employee_id) JOIN department using (department_id) jOIN employment_status on employementdetails.employement_status_id = employment_status.status_id JOIN job_titile using (Job_id) WHERE employementdetails.Employement_status_id = given_status_id ;

END $$

DELIMITER ;



/* Function for selecting employee on department */

DELIMITER $$

DROP PROCEDURE IF EXISTS employeeByDepartment$$

CREATE PROCEDURE employeeByDepartment(IN given_department_id VARCHAR(7))

BEGIN

SELECT Employee_id,first_name,last_name,birthday,Gender,supervisor_emp_id,Department_Name,Job_Name,Status_name FROM employee JOIN employementdetails using(Employee_id) JOIN department using (department_id) jOIN employment_status on employementdetails.employement_status_id = employment_status.status_id JOIN job_titile using (Job_id) WHERE employementdetails.department_id = given_department_id ;

END $$

DELIMITER ;

--procedure for getting user details by user id--

DELIMITER $$

DROP PROCEDURE IF EXISTS getEmergencyDetails$$

CREATE PROCEDURE getEmergencyDetails(IN Employee_id VARCHAR(7))

BEGIN

SELECT name,contact_no,Relationship,Address from employee NATURAL JOIN emergency_details where Employee.Employee_id= Employee_id;

END $$

DELIMITER ;



--addEmployee procedure--

DELIMITER $$

CREATE PROCEDURE addEmployee(IN Employee_id varchar(7), username VARCHAR(20),password varchar(255), type enum('Admin','HRM','Employee'),dbuser varchar(20),dbpass varchar(255),First_name varchar(20),Middle_name varchar(20),Last_name varchar(20),birthday date,Marital_status enum('Unmarried','Married'),Gender enum('Male','Female'), supervisor_empid varchar(7),Employement_status_id varchar(7),department_id varchar(7),job_id varchar(7))

BEGIN
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
END $$

--procedure for add new departments to department table--

DELIMITER $$

DROP PROCEDURE IF EXISTS addDepartment$$

CREATE PROCEDURE addDepartment(IN Department_ID VARCHAR(7),Department_Name varchar(20),Building varchar(20),Description varchar(100))

BEGIN

INSERT INTO department (Department_ID,Department_Name,Building,Description) values (Department_ID,Department_Name,Building,Description);
END $$

DELIMITER ;

--procedure for add new Job titles to job_titiles table--

DELIMITER $$

DROP PROCEDURE IF EXISTS addJobTitle$$

CREATE PROCEDURE addJobTitle(IN Job_ID varchar(7), Job_Name varchar(20))

BEGIN

INSERT INTO job_titile (Job_ID, Job_Name) values (Job_ID, Job_Name);
END $$

DELIMITER ;

--procedure to add new employment status to employment_status table--

DELIMITER $$

DROP PROCEDURE IF EXISTS addEmploymentStatus$$

CREATE PROCEDURE addEmploymentStatus(IN Status_ID varchar(7), Status_name varchar(20))

BEGIN

INSERT INTO employment_status (Status_ID,Status_name) values (Status_ID,Status_name);
END $$

DELIMITER ;

--procedure to submit leave application form--


delimiter $$ 
CREATE PROCEDURE applyLeave(IN Employee_id varchar(7),start_date date, end_date date,Leave_Type enum('Annual','Casual','Maternity','No_pay'),reason varchar(20))

BEGIN
INSERT INTO employee_leaves (Employee_id,start_date,end_date,Leave_Type,reason,status) VALUES (Employee_id,start_date,end_date,Leave_Type,reason,'Pending');
END 
$$
DELIMITER ;



--Functions--
delimiter $$
create FUNCTION remaining_casual_leaves(E_id varchar(7))
RETURNS int(11)
BEGIN
DECLARE casual int(11);
set casual=(select((select casual_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select casual_count from taken_no_of_leaves where employee_id=E_id)));
return casual;
end
$$
delimiter ;


delimiter $$
create FUNCTION remaining_annual_leaves(E_id varchar(7))
RETURNS int(11)
BEGIN
DECLARE annual int(11);
set annual=(select((select annual_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select casual_count from taken_no_of_leaves where employee_id=E_id)));
return annual;
end
$$
delimiter ;

delimiter $$
create FUNCTION remaining_maternity_leaves(E_id varchar(7))
RETURNS int(11)
BEGIN
DECLARE maternity int(11);
set maternity=(select((select maternity_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select maternity_count from taken_no_of_leaves where employee_id=E_id)));
return maternity;
end
$$
delimiter ;

delimiter $$
create FUNCTION remaining_no_pay_leaves(E_id varchar(7))
RETURNS int(11)
BEGIN
DECLARE no_pay int(11);
set no_pay=(select((select no_pay_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select no_pay_count from taken_no_of_leaves where employee_id=E_id)));
return no_pay;
end
$$
delimiter ;

--procedures for getting remaining leave counts by employee_id--

delimiter $$
create PROCEDURE remaining_no_pay_leaves_procedure(IN E_id varchar(7))
BEGIN

select((select no_pay_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select no_pay_count from taken_no_of_leaves where employee_id=E_id)) as number;

end
$$
delimiter ;

delimiter $$
create PROCEDURE remaining_casual_leaves_procedure(IN E_id varchar(7))
BEGIN

select((select casual_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select casual_count from taken_no_of_leaves where employee_id=E_id)) as number;

end
$$
delimiter ;


delimiter $$
create PROCEDURE remaining_annual_leaves_procedure(IN E_id varchar(7))
BEGIN

select((select annual_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select annual_count from taken_no_of_leaves where employee_id=E_id)) as number;

end
$$
delimiter ;

delimiter $$
create PROCEDURE remaining_maternity_leaves_procedure(IN E_id varchar(7))
BEGIN

select((select maternity_leaves from employee NATURAL JOIN payroll_info NATURAL JOIN pay_grade where Employee.employee_id = E_id)- (select maternity_count from taken_no_of_leaves where employee_id=E_id)) as number;

end
$$
delimiter ;

/* Procedure for viewing personal information 

DELIMITER $$

DROP PROCEDURE IF EXISTS viewPersonalInfo$$

CREATE PROCEDURE viewPersonalInfo(IN given_employee_id VARCHAR(7))

BEGIN

SELECT Employee_id,first_name,supervisor_emp_id,Department_Name,Job_Name,Status_name,pay_grade_id FROM employee JOIN employementdetails using(Employee_id) JOIN department using (department_id) jOIN employment_status on employementdetails.employement_status_id = employment_status.status_id JOIN job_titile using (Job_id) JOIN payroll_info using (Employee_id) WHERE employementdetails.employee_id = given_employee_id ;

END $$

DELIMITER ;

/* Procedure for viewing personal information 

DELIMITER $$

DROP PROCEDURE IF EXISTS viewTakenLeaveInfo$$

CREATE PROCEDURE viewTakenLeaveInfo(IN given_employee_id VARCHAR(7))

BEGIN
if (select gender from employee where employee_id=given_employee_id) ='Male'THEN

SELECT Annual_count,casual_count,no_pay_count FROM taken_no_of_leaves WHERE taken_no_of_leaves.Employee_id=given_employee_id;

else

SELECT Annual_count,casual_count,maternity_count,no_pay_count FROM taken_no_of_leaves WHERE taken_no_of_leaves.Employee_id=given_employee_id;

END IF;
END $$

DELIMITER ;

*/

delimiter $$
create PROCEDURE viewEmployeeInfo(IN E_id varchar(7))
BEGIN

select * from all_employee_data_for_admin where all_employee_data_for_admin.Employee_id = E_id ;
end
$$
delimiter ;


-- database user adding --

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

