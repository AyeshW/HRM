<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

session_start();
if (!$_SESSION['loggedin']){ 
    header("Location:../index.html");
    die();
}
include '../config/db_connection.php';

$dbuser = $_SESSION["dbuser"];
$dbpass = $_SESSION["dbpass"];
$conn = Opencon($dbuser,$dbpass);


#$empID= $_SESSION['Employee_id'];
$empID="10001";



$stmt = $conn->prepare('CALL remaining_annual_leaves_procedure(?)');
$stmt->bind_param('s',$empID);
$stmt->execute();

$remAnnual = $stmt->get_result();

$array = array();
while($row = mysqli_fetch_assoc($remAnnual)){
    $array[] = $row;
}
$remAnnual=$array[0]['number'];


$stmt->close();


if($stmt = $conn->prepare('CALL remaining_casual_leaves_procedure(?)')){
$stmt->bind_param('s',$empID);
$stmt->execute();
}
$remCasual = $stmt->get_result();

$array = array();
while($row = mysqli_fetch_assoc($remCasual)){
    $array[] = $row;
}
$remCasual=$array[0]['number'];

$stmt->close();


$stmt = $conn->prepare('CALL remaining_maternity_leaves_procedure(?)');
$stmt->bind_param('s',$empID);
$stmt->execute();

$remMaternity = $stmt->get_result();

$array = array();
while($row = mysqli_fetch_assoc($remMaternity)){
    $array[] = $row;
}
$remMaternity=$array[0]['number'];

$stmt->close();

$stmt = $conn->prepare('CALL remaining_no_pay_leaves_procedure(?)');
$stmt->bind_param('s',$empID);
$stmt->execute();

$remNoPay = $stmt->get_result();

$array = array();
while($row = mysqli_fetch_assoc($remNoPay)){
    $array[] = $row;
}
$remNoPay=$array[0]['number'];

$stmt->close();

CloseCon($conn);

?>

<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <title>Remaining Leaves</title>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item active">
              <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Features</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Pricing</a>
            </li>
            <li class="nav-item">
              <a class="nav-link disabled" href="#">Disabled</a>
            </li>
          </ul>
        </div>
      </nav>
</head>
<body>
    <div class="container">
        <br><br>
        <table class="table">
        <thead>
            <tr>
            <th scope="col">Remaining Annual Leaves</th>
            <th scope="col">Remaining Casual Leave</th>
            <th scope="col">Remaining Maternity Leave</th>
            <th scope="col">Remaining No Pay Leave</th>
            </tr>
        </thead>
        <tbody>
            <tr>
            <td><?php echo($remAnnual); ?></td>
            <td><?php echo($remCasual); ?></td>
            <td><?php echo($remMaternity); ?></td>
            <td><?php echo($remNoPay); ?></td>
            
            </tr>
              
        </tbody>
        </table>
            
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
