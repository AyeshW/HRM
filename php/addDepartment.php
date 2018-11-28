<?php
/**
 * Created by PhpStorm.
 * User: Ayesh
 * Date: 11/28/2018
 * Time: 12:42 AM
 */

session_start();
if (!$_SESSION['loggedin']){
    header("Location:../index.html");
    die();
}
include '../config/db_connection.php';

$conn = OpenCon();

$deptName = $_POST['departmentname'];
$building = $_POST['building'];
$description = $_POST['description'];

//$sql = "CALL addDepartment(?,?,?)"; use the procedure
$sql = "INSERT INTO department(Department_Name, Building, Description) VALUES(?,?,?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param('sss',$deptName,$building, $description);
$stmt->execute();

if (!$stmt){
    header('location:../addDepartment.html');
}else {
    header('location:../adminDashboard.html');
}