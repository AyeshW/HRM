<?php

session_start();
if (!$_SESSION['loggedin']){ 
    header("Location:../index.html");
    die();
}
include '../config/db_connection.php';


$conn = OpenCon("root","");

$empID=$_POST["empID"];
$fname=$_POST["fname"];
$mname=$_POST["mname"];
$lname=$_POST["lname"];
$bod=$_POST["bod"];
$marital=$_POST["marital"];
$gender=$_POST["gender"];
$supEmpID=$_POST["supEmpID"];
$empStatID=$_POST["empStatID"];
$depID=$_POST["depID"];
$jobID=$_POST["jobID"];

$dbuser=$_POST["dbuser"];
$dbpass=$_POST["dbpass"];
$type=$_POST["type"];


if(isset($_POST["password"])){
    $pass=md5($_POST["password"]);
}
else{
    $pass=null;
}

if(isset($_POST["username"])){
    $username=$_POST["username"];
}
else{
    $username=null;
}



$stmt = $conn->prepare('CALL addEmployee(
?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)');

$stmt->bind_param('sssssssssisssiii',$empID,$username,$pass,$type,$dbuser,$dbpass,$fname,$mname,$lname,$bod,$marital,$gender,$supEmpID,$empStatID,$depID,$jobID);
$stmt->execute();
$allData = $stmt->get_result();

CloseCon($conn);


?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>User Added</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" media="screen" href="main.css" />
    <script src="main.js"></script>
</head>
<body>
    <h2>User Succesfully Added</h2>
    <button href="../index.html">Go to Home</button>
</body>
</html>