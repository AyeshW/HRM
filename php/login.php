<?php
    include '../config/db_connection.php';
    $dbuser = 'root';
    $dbpass = '';
    $conn = Opencon($dbuser,$dbpass);
    session_start();
    if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){
        //header("location: logout.php");
        exit;
    }
    $username = $password = "";
    $u_error = $p_error ="";

    $username = $_POST['username'];
    $password = md5($_POST['password']);
    
    if(isset($username) && isset($password)){
        $sql = "SELECT * FROM user WHERE username = ? and password = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ss',$username,$password);
        
    
        $stmt->execute();
        $res = $stmt->get_result();
        $count=count($res);

        if ($count > 0) {
            // output data of each row
            while($row = $res->fetch_assoc()) {
                $usertype = $row["type"];
                $dbuser = $row["dbname"];
                $dbpass = $row["dbpass"];
            }
        } else {
        }

        if($count==1){
            
            $_SESSION["loggedin"]=true;
            $_SESSION["username"]=$username;
            $_SESSION["usertype"]=$usertype;
            $_SESSION["dbuser"]=$dbuser;
            $_SESSION["dbpass"]=$dbpass;
            
            
            header('location:dashboard.php');
        }else{
            header('location:../index.html');
        }
    }
    CloseCon($conn);
?>