<?php
    include '../config/db_connection.php';
    $con = Opencon();
    session_start();
    if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){
        //header("location: logout.php");
        exit;
    }
    $username = $password = "";
    $u_error = $p_error ="";

    $username = $_POST['username'];
    $password = md5($_POST['password']);
    echo $username, $password;
    if(isset($username) && isset($password)){
        $sql = "SELECT * FROM user WHERE username = '$username' and password ='$password'";
        $results = $con -> query($sql);
        $count=mysqli_num_rows($results);
        if($count==1){
            $_SESSION["loggedin"]=true;
            $_SESSION["username"]=$username;
            
            header("location:../dashboard.html");
        }else{
            header('location:../index.html');
        }
    }
    CloseCon($con);
?>