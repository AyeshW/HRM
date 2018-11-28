<?php
    include '../config/db_connection.php';
    $con = Opencon();
    session_start();
    
    $sql="SELECT * FROM employee";
    $results = $con->query($sql);
    $array=array();
    while($row = mysqli_fetch_assoc($results)){
        $array[]=$row;
    }
?>


<html>
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
    