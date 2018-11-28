<?php

session_start();
if (!$_SESSION['loggedin']){ 
    header("Location:../index.html");
    die();
}
include '../config/db_connection.php';


$conn = OpenCon("root","");

if(isset($_GET["department"])){
    $dept=$_GET["department"];

    $stmt = $conn->prepare("CALL getEmployeeByDepartment($dept)");
    $stmt->execute();
    $allData = $stmt->get_result();

    $array = array();
    while($row = mysqli_fetch_assoc($allData)){
        $array[] = $row;
    }
}


if(isset($_GET["empStatus"])){
    $empStatus=$_GET["empStatus"];

    $stmt = $conn->prepare("CALL employeeByStatus($empStatus)");
    $stmt->execute();
    $allData = $stmt->get_result();


    $array = array();
    while($row = mysqli_fetch_assoc($allData)){
        $array[] = $row;
    }
}

if(isset($_GET["payGrade"])){
    $payGrade=$_GET["payGrade"];

    $stmt = $conn->prepare("CALL employeeByPayGrade($payGrade)");
    $stmt->execute();
    $allData = $stmt->get_result();


    $array = array();
    while($row = mysqli_fetch_assoc($allData)){
        $array[] = $row;
    }
}

if(isset($_GET["jobTitle"])){
    $jobTitle=$_GET["jobTitle"];

    $stmt = $conn->prepare("CALL employeeByJobTitle($jobTitle)");
    $stmt->execute();
    $allData = $stmt->get_result();


    $array = array();
    while($row = mysqli_fetch_assoc($allData)){
        $array[] = $row;
    }
}


CloseCon($conn);


?>

<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <title>Employee Details</title>
   
</head>
<body>
    <div class="container">
        <br><br>
        <table class="table">
        <thead>
            <tr>
            <th scope="col">Employee ID</th>
            <th scope="col">First Name</th>
            <th scope="col">Last Name</th>
            <th scope="col">Birthday</th>
            <th scope="col">Gender</th>
            <th scope="col">Supervisor Employee ID</th>
            <th scope="col">Job Name</th>
            <th scope="col">Status Name</th>
            

            </tr>
        </thead>
        <tbody>
            <?php
              foreach($array as $details){  
            ?>
            <tr>
            <th scope="row"><?php echo $details["Employee_id"]; ?></th>
            <td><?php echo $details["Contact Number"]; ?></td>
            <td><?php echo $details["Relationship"]; ?></td>
            <td><?php echo $details["Address"]; ?></td>
            <td><?php echo $details["Job_Name"]; ?></td>
            <td><?php echo $details["Name"]; ?></td>
            
            </tr>
              <?php } ?>
        </tbody>
        </table>

        <button href="../index.html">Go to Home</button>

    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>