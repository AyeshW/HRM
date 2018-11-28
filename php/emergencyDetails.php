<?php

session_start();
if (!$_SESSION['loggedin']){ 
    header("Location:../index.html");
    die();
}
include '../config/db_connection.php';






if(isset($_GET["empID"])){
    $empID=$_GET["empID"];
    
    $conn = OpenCon();
    $stmt = $conn->prepare('CALL getEmergencyDetails(?)');
    $stmt->bind_param('s',$empID)
    $stmt->execute();
    
    $array = array();
    while($row = $q->fetch()){
        $array[] = $row;
    }

    



?>

<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <title>Emergency Details</title>
   
</head>
<body>
    <div class="container">
        <br><br>
        <table class="table">
        <thead>
            <tr>
            <th scope="col">Name</th>
            <th scope="col">Contact Number</th>
            <th scope="col">Relationship</th>
            <th scope="col">Address</th>
            
            

            </tr>
        </thead>
        <tbody>
            <?php
              foreach($array as $details){  
            ?>
            <tr>
            <td><?php echo $details["name"]; ?></td>
            <td><?php echo $details["contact_no"]; ?></td>
            <td><?php echo $details["Relationship"]; ?></td>
            <td><?php echo $details["Address"]; ?></td>
            
            
            
            </tr>
              <?php } ?>
        </tbody>
        </table>

       

    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>