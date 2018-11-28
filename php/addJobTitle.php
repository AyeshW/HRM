<?php
/**
 * Created by PhpStorm.
 * User: Ayesh
 * Date: 11/28/2018
 * Time: 6:29 PM
 */
session_start();
if (!$_SESSION['loggedin']){
    header("Location:../index.html");
    die();
}
include '../config/db_connection.php';

$conn = OpenCon('root','');

$conditionSet = isset($_POST["jobID"]) && isset($_POST["jobTitle"]);
if($conditionSet){
    $jobID = $_POST['jobID'];
    $jobTitle = $_POST['jobTitle'];
}else{
    $jobID = $jobTitle  = null;
    ?>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" media="screen" href="main.css" />
        <script src="main.js"></script>
    </head>
    <body>
    <h2>Job Title Adding Failed</h2>
    <button href="../adminDashboard.html">Go to Home</button>
    </body>
    </html>
    <?php
}
$sql = "INSERT INTO job_titile(Job_ID,Job_Name) VALUES(?,?)";
if($stmt = $conn->prepare($sql)) {
    $stmt->bind_param('ss',$jobID,$jobTitle);
    $stmt->execute();
    if($conditionSet) {

        ?>
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="utf-8"/>
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <title>Admin</title>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" type="text/css" media="screen" href="main.css"/>
            <script src="main.js"></script>
        </head>
        <body>
        <h2>Job Title Succesfully Added</h2>
        <button href="../adminDashboard.html">Go to Home</button>
        </body>
        </html>
        <?php
    }
} else {
    $error = $conn->errno . ' ' . $conn->error;
    echo $error;
    ?>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" media="screen" href="main.css" />
        <script src="main.js"></script>
    </head>
    <body>
    <h2>Job Title Adding Failed</h2>
    <button href="../adminDashboard.html">Go to Home</button>
    </body>
    </html>
    <?php
}
?>
