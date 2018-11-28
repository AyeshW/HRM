<?php

session_start();
if (!$_SESSION['loggedin']){ 
    header("Location:../index.html");
    die();
}
include '../config/db_connection.php';

$dbuser = $_SESSION["dbuser"];
$dbpass = $_SESSION["dbpass"];
$conn = OpenCon($dbuser,$dbpass);

$empID=$_POST["empID"];
$sDate=$_POST["sDate"];
$eDate=$_POST["eDate"];
$type=$_POST["type"];
$reason=$_POST["reason"];

echo($dbuser);
echo($dbpass);
echo ($empID);
echo ($sDate);
echo ($eDate);
echo ($type);
echo ($reason);



$stmt = $conn->prepare('CALL applyLeave(
?,?,?,?,?)');

$stmt->bind_param('siiss',$empID,$sDate,$eDate,$type,$reason);
$stmt->execute();
$allData = $stmt->get_result();
print_r($allData);
CloseCon($conn);


?>
