<?php
    include '../config/db_connection.php';
    
    session_start();
    $dbuser=$_SESSION["dbuser"];
    $dbpass = $_SESSION["dbpass"];
    $con = Opencon($dbuser,$dbpass);
    
    if(isset($_POST['submit'])) {
	
	
        $eid=$_POST['E_id'];
        $first_name=$_POST['first_name'] ;
        $middle_name=$_POST['middle_name'];
        $last_name=$_POST['last_name'];
        $b_day=$_POST['b_day'];
        $marital_state=$_POST['marital_status'];
        $gender=$_POST['gender'];
        $supervisor_id=$_POST['supervisor_id'];

        $sql_b="INSERT INTO employee VALUES ('$eid','$first_name','$middle_name','$last_name','$b_day','$marital_state','$gender','$supervisor_id')";
        $result_b=$con->query($sql_b);
        CloseCon($con);
        header("Location:../AddEmployee.html?msg=Inserted successfully!");            
        exit();
    }
    CloseCon($conn);
        
?>
    
    
    
