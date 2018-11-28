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

$conn = OpenCon('root','');

$dbhost='localhost';
$dbname='edbms';
$username='root';
$password='';


/*if(isset($_POST["department"]) && isset($_POST["building"])&&isset($_POST["description"])&&isset($_POST["departmentid"])){
    $deptId = $_POST['departmentid'];
    $deptName = $_POST['departmentname'];
    $building = $_POST['building'];
    $description = $_POST['description'];
    try{
        $pdo = new PDO("mysql:host=$dbhost;dbname=$dbname", $username, $password);

        $sql = 'CALL addDepartment('.$deptId.','.$dbname.','.$building.','.$description.')';


        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);

        $array = array();
        while($row = $q->fetch()){
            $array[] = $row;
        }

    }
    catch (PDOException $e) {
        die("Error occurred:" . $e->getMessage());
    }
}*/
$conditionSet = isset($_POST["department"]) && isset($_POST["building"])&&isset($_POST["description"])&&isset($_POST["departmentid"]);
if($conditionSet){
    $deptId = $_POST['departmentid'];
    $deptName = $_POST['departmentname'];
    $building = $_POST['building'];
    $description = $_POST['description'];
}else{
    $deptId = $deptName=$building = $description  = null;
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
<h2>Department Adding Failed</h2>
<button href="../adminDashboard.html">Go to Home</button>
</body>
</html>
<?php
}
//$sql = 'CALL addDepartment(?,?,?,?)';
$sql = "INSERT INTO department(Department_ID,Department_Name, Building, Description) VALUES(?,?,?,?)";
if($stmt = $conn->prepare($sql)) {
    $stmt->bind_param('ssss',$deptId,$deptName,$building, $description);
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
        <h2>Department Succesfully Added</h2>
        <button href="../adminDashboard.html">Go to Home</button>
        </body>
        </html>
        <?php
    }
} else {
    $error = $conn->errno . ' ' . $conn->error;
    ?>

<?php
    //echo $error;
}

?>
<!-- if (!$stmt){
    header('location:../addDepartment.html');
}else {
    header('location:../adminDashboard.html');
<button onclick="window.location.href='../adminDashboard.html">Go to Home</button>
}
?> -->

