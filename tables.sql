create table department
(
	Department_ID varchar(7) not null
		primary key,
	Department_Name varchar(20) not null,
	Building varchar(20) not null,
	Description varchar(100) not null
)
;

create trigger department_id_validation
before INSERT on department
for each row
BEGIN
    IF NEW.Department_ID NOT LIKE "___" THEN
      SIGNAL SQLSTATE VALUE '45001'
        SET MESSAGE_TEXT = 'Invalid department id';
end if;
  END
;

create table employee
(
	Employee_id varchar(7) not null
		primary key,
	First_Name varchar(20) not null,
	Middle_Name varchar(20) not null,
	Last_Name varchar(20) not null,
	birthday date not null,
	Marital_Status enum('Unmarried', 'Married') not null,
	Gender enum('Male', 'Female') not null,
	supervisor_emp_id varchar(7) null,
	constraint Employee_Employee_Employee_id_fk
		foreign key (supervisor_emp_id) references employee (Employee_id)
			on update cascade on delete cascade
)
;

create table dependent_info
(
	Employee_id varchar(7) not null,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	birthday date not null,
	relationship varchar(20) not null,
	primary key (Employee_id, first_name),
	constraint Dependent_info_employee_Employee_id_fk
		foreign key (Employee_id) references employee (Employee_id)
			on update cascade on delete cascade
)
;

create trigger dependent_info_validation
before INSERT on dependent_info
for each row
BEGIN
    DECLARE p_birthday DATE;
    SELECT birthday INTO p_birthday FROM employee WHERE employee.Employee_id = NEW.Employee_id;

    IF NEW.relationship = 'Son' OR NEW.relationship = 'Daughter' THEN
      IF (EXTRACT(YEAR FROM NEW.birthday) - EXTRACT(YEAR  FROM p_birthday) <= 18) THEN
        SIGNAL SQLSTATE VALUE '45003'
          SET MESSAGE_TEXT = 'Unacceptable birthday for child';
      end if;
    end if;

  END
;

create table emergency_details
(
	Employee_id varchar(7) not null,
	contact_no int(10) not null,
	Relationship varchar(10) null,
	Address varchar(100) not null,
	name varchar(10) not null,
	primary key (Employee_id, name),
	constraint emergency_details_employee_Employee_id_fk
		foreign key (Employee_id) references employee (Employee_id)
)
;

create trigger employee_validation
before INSERT on employee
for each row
BEGIN
    
    IF NEW.Employee_id NOT LIKE "_____" THEN
      SIGNAL SQLSTATE VALUE '45000'
        SET MESSAGE_TEXT = 'Invalid employee id';
    end if;

    
    IF (EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR  FROM NEW.birthday) <= 18) OR (EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR  FROM NEW.birthday) > 100) THEN

      SIGNAL SQLSTATE VALUE '45002'
        SET MESSAGE_TEXT = 'Unacceptable birthday';
    end if;
  END
;

create table employee_leaves
(
	Leave_id varchar(7) not null
		primary key,
	Employee_id varchar(7) not null,
	start_date date not null,
	end_date date not null,
	Leave_Type enum('Annual', 'Casual', 'Maternity', 'No-pay') not null,
	Reason varchar(20) not null,
	status enum('Pending', 'Approved', 'Rejected') not null,
	constraint employee_leaves_employee_Employee_id_fk
		foreign key (Employee_id) references employee (Employee_id)
)
;

create trigger employee_leaves_validation
before INSERT on employee_leaves
for each row
BEGIN
    

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
;

create table employment_status
(
	Status_ID varchar(7) not null
		primary key,
	Status_name varchar(20) null
)
;

create table job_titile
(
	Job_ID varchar(7) not null
		primary key,
	Job_Name varchar(20) null
)
;

create table employementdetails
(
	Employee_id varchar(7) not null
		primary key,
	Employement_status_id varchar(7) not null,
	department_id varchar(7) not null,
	job_id varchar(7) not null,
	constraint EmployementDetails_department_Department_ID_fk
		foreign key (department_id) references department (Department_ID)
			on update cascade on delete cascade,
	constraint EmployementDetails_employee_Employee_id_fk
		foreign key (Employee_id) references employee (Employee_id)
			on update cascade on delete cascade,
	constraint EmployementDetails_employment_status_Status_ID_fk
		foreign key (Employement_status_id) references employment_status (Status_ID)
			on update cascade on delete cascade,
	constraint EmployementDetails_job_titile_Job_ID_fk
		foreign key (job_id) references job_titile (Job_ID)
			on update cascade on delete cascade
)
;

create table organization
(
	Reg_No int auto_increment
		primary key,
	name varchar(10) not null,
	Address varchar(100) not null
)
;

create table pay_grade
(
	pay_grade_id varchar(7) not null
		primary key,
	pay_grade varchar(20) not null,
	Annual_leaves int not null,
	Casual_leaves int null,
	Maternity_leaves int not null,
	No_pay_leaves int not null
)
;

create table payroll_info
(
	Employee_id varchar(7) not null
		primary key,
	pay_grade_id varchar(7) not null,
	epf_no varchar(10) not null,
	constraint payroll_info_employee_Employee_id_fk
		foreign key (Employee_id) references employee (Employee_id)
			on update cascade on delete cascade,
	constraint payroll_info_pay_grade_pay_grade_id_fk
		foreign key (pay_grade_id) references pay_grade (pay_grade_id)
			on update cascade on delete cascade
)
;

create table taken_no_of_leaves
(
	Employee_id varchar(20) not null
		primary key,
	Annual_count int not null,
	casual_count int not null,
	maternity_count int not null,
	no_pay_count int not null,
	constraint Taken_no_of_leaves_employee_Employee_id_fk
		foreign key (Employee_id) references employee (Employee_id)
			on update cascade on delete cascade
)
;

create table user
(
	user_id int auto_increment
		primary key,
	username varchar(20) null,
	password varchar(255) null,
	type enum('Admin', 'Employee') not null
)
;

create trigger user_validation
before INSERT on user
for each row
BEGIN
    
    
    IF LENGTH(NEW.password) < 6 THEN
      SIGNAL SQLSTATE VALUE '45004'
        SET MESSAGE_TEXT = 'Password should have 6 minimum number of characters';
    end if;

  END
;

