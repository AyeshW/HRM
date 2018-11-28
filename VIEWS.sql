create view all_employee_data_for_admin as select `edbms`.`employee`.`Employee_id`                     AS `Employee_id`,
         `edbms`.`employementdetails`.`department_id`         AS `department_id`,
         `edbms`.`employementdetails`.`job_id`                AS `job_id`,
         `edbms`.`employee`.`First_Name`                      AS `First_Name`,
         `edbms`.`employee`.`Middle_Name`                     AS `Middle_Name`,
         `edbms`.`employee`.`Last_Name`                       AS `Last_Name`,
         `edbms`.`employee`.`birthday`                        AS `birthday`,
         `edbms`.`employee`.`Marital_Status`                  AS `Marital_Status`,
         `edbms`.`employee`.`Gender`                          AS `Gender`,
         `edbms`.`employee`.`supervisor_emp_id`               AS `supervisor_emp_id`,
         `edbms`.`employementdetails`.`Employement_status_id` AS `Employement_status_id`,
         `edbms`.`job_titile`.`Job_Name`                      AS `Job_Name`,
         `edbms`.`department`.`Department_Name`               AS `Department_Name`,
         `edbms`.`department`.`Building`                      AS `Building`,
         `edbms`.`department`.`Description`                   AS `Description`,
         `es`.`Status_ID`                                     AS `Status_ID`,
         `es`.`Status_name`                                   AS `Status_name`,
         `edbms`.`taken_no_of_leaves`.`Annual_count`          AS `Annual_count`,
         `edbms`.`taken_no_of_leaves`.`casual_count`          AS `casual_count`,
         `edbms`.`taken_no_of_leaves`.`maternity_count`       AS `maternity_count`,
         `edbms`.`taken_no_of_leaves`.`no_pay_count`          AS `no_pay_count`,
         `edbms`.`payroll_info`.`pay_grade_id`                AS `pay_grade_id`,
         `edbms`.`payroll_info`.`epf_no`                      AS `epf_no`
  from ((((((`edbms`.`employee` join `edbms`.`employementdetails` on ((`edbms`.`employee`.`Employee_id` =
                                                                       `edbms`.`employementdetails`.`Employee_id`))) join `edbms`.`job_titile` on ((
    `edbms`.`employementdetails`.`job_id` = `edbms`.`job_titile`.`Job_ID`))) join `edbms`.`department` on ((
    `edbms`.`employementdetails`.`department_id` =
    `edbms`.`department`.`Department_ID`))) join `edbms`.`employment_status` `es` on ((
    `edbms`.`employementdetails`.`Employement_status_id` = `es`.`Status_ID`))) join `edbms`.`taken_no_of_leaves` on ((
    `edbms`.`employee`.`Employee_id` = `edbms`.`taken_no_of_leaves`.`Employee_id`))) join `edbms`.`payroll_info` on ((
    `edbms`.`employee`.`Employee_id` = `edbms`.`payroll_info`.`Employee_id`)))
;

create view employee_details_hr as select `edbms`.`employee`.`Employee_id`       AS `Employee_id`,
         `edbms`.`employee`.`First_Name`        AS `First_Name`,
         `edbms`.`employee`.`Middle_Name`       AS `Middle_Name`,
         `edbms`.`employee`.`Last_Name`         AS `Last_Name`,
         `edbms`.`employee`.`birthday`          AS `birthday`,
         `edbms`.`employee`.`Marital_Status`    AS `Marital_Status`,
         `edbms`.`employee`.`Gender`            AS `Gender`,
         `edbms`.`job_titile`.`Job_Name`        AS `Job_Name`,
         `edbms`.`department`.`Department_Name` AS `Department_Name`,
         `es`.`Status_name`                     AS `Status_name`
  from (((((`edbms`.`employee` join `edbms`.`employementdetails` on ((`edbms`.`employee`.`Employee_id` =
                                                                      `edbms`.`employementdetails`.`Employee_id`))) join `edbms`.`job_titile` on ((
    `edbms`.`employementdetails`.`job_id` = `edbms`.`job_titile`.`Job_ID`))) join `edbms`.`department` on ((
    `edbms`.`employementdetails`.`department_id` =
    `edbms`.`department`.`Department_ID`))) join `edbms`.`employment_status` `es` on ((
    `edbms`.`employementdetails`.`Employement_status_id` = `es`.`Status_ID`))) join `edbms`.`taken_no_of_leaves` on ((
    `edbms`.`employee`.`Employee_id` = `edbms`.`taken_no_of_leaves`.`Employee_id`)))
;

create view employee_job_title as select `edbms`.`employee`.`Employee_id` AS `Employee_id`,
         `edbms`.`employee`.`First_Name`  AS `First_Name`,
         `edbms`.`employee`.`Middle_Name` AS `Middle_Name`,
         `edbms`.`employee`.`Last_Name`   AS `Last_Name`,
         `edbms`.`job_titile`.`Job_Name`  AS `Job_Name`
  from ((`edbms`.`employee` join `edbms`.`employementdetails` on ((`edbms`.`employee`.`Employee_id` =
                                                                   `edbms`.`employementdetails`.`Employee_id`))) join `edbms`.`job_titile` on ((
    `edbms`.`employementdetails`.`job_id` = `edbms`.`job_titile`.`Job_ID`)))
;

create view employees_department as select `edbms`.`employee`.`Employee_id`       AS `Employee_id`,
         `edbms`.`employee`.`First_Name`        AS `First_Name`,
         `edbms`.`employee`.`Middle_Name`       AS `Middle_Name`,
         `edbms`.`employee`.`Last_Name`         AS `Last_Name`,
         `edbms`.`department`.`Department_Name` AS `Department_Name`,
         `edbms`.`department`.`Building`        AS `Building`
  from ((`edbms`.`employee` join `edbms`.`employementdetails` on ((`edbms`.`employee`.`Employee_id` =
                                                                   `edbms`.`employementdetails`.`Employee_id`))) join `edbms`.`department` on ((
    `edbms`.`employementdetails`.`department_id` = `edbms`.`department`.`Department_ID`)))
;

