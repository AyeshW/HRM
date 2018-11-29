<?php
    include '../config/db_connection.php';
    
    session_start();
    $dbuser=$_SESSION["dbuser"];
    $dbpass = $_SESSION["dbpass"];
    $conn = Opencon($dbuser,$dbpass);
    
    $sql="SELECT * FROM employee";
    $results = $con->query($sql);
    $array=array();
    while($row = mysqli_fetch_assoc($results)){
        $array[]=$row;
    }
    CloseCon($conn);
?>


<html>
    <head>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <!-- <a class="navbar-brand" href="#">Navbar</a> -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item active">
              <a class="nav-link" href="php/logout.php">Logout <span class="sr-only">(current)</span></a>
            </li>
          </ul>
        </div>
      </nav>
    </head>
    <table>
        <tr>
            <th>Employee ID</th>
            <th>First Name</th>
            <th>Middle Name</th>
            <th>Last Name</th>
            <th>Birthday</th>
            <th>Marital Status</th>
            <th>Gender</th>
            <th>Supervisor Employee ID</th>
        </tr>
        <?php foreach($array as $details){
        ?>
        <tr>
        <td><?php echo $details['Employee_id']?></td>
        <td><?php echo $details['First_Name']?></td>
        <td><?php echo $details['Middle_Name']?></td>
        <td><?php echo $details['Last_Name']?></td>
        <td><?php echo $details['birthday']?></td>
        <td><?php echo $details['Marital_Status']?></td>
        <td><?php echo $details['Gender']?></td>
        <td><?php echo $details['supervisor_emp_id']?></td>
        </tr>
        <?php } ?>
    </table>
</html>
    