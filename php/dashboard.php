<?php
    session_start();
    $userType = $_SESSION["usertype"];
    if($userType == 'Admin'){
        header("location:../adminDashboard.html");
    }elseif($userType = 'HRM'){
        header("location:../HRMDashboard.html");
    }elseif($userType = 'Employee'){
        header("location:../EmployeeDashboard");
    }
?>