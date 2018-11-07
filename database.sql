-- we don't know how to generate schema edbms (class Schema) :(
create table department
(
	Department_ID varchar(7) not null
		primary key,
	Department_Name varchar(20) not null,
	Building varchar(20) not null,
	Description varchar(100) not null
)
;

create table emergency_details
(
	Employee_id varchar(7) not null,
	contact_no int(10) not null,
	Relationship varchar(10) null,
	Address varchar(100) not null,
	name varchar(10) not null,
	primary key (Employee_id, name)
)
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
	supervisor_emp_id varchar(7) not null,
	constraint Employee_Employee_Employee_id_fk
		foreign key (supervisor_emp_id) references employee (Employee_id)
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
)
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
	status enum('Pending', 'Approved', 'Rejected') not null
)
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
		foreign key (department_id) references department (Department_ID),
	constraint EmployementDetails_employee_Employee_id_fk
		foreign key (Employee_id) references employee (Employee_id),
	constraint EmployementDetails_employment_status_Status_ID_fk
		foreign key (Employement_status_id) references employment_status (Status_ID),
	constraint EmployementDetails_job_titile_Job_ID_fk
		foreign key (job_id) references job_titile (Job_ID)
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
		foreign key (Employee_id) references employee (Employee_id),
	constraint payroll_info_pay_grade_pay_grade_id_fk
		foreign key (pay_grade_id) references pay_grade (pay_grade_id)
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
)
;

create table user
(
	user_id int auto_increment
		primary key,
	username varchar(20) null,
	password varchar(255) null
)
;

