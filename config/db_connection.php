<?php
function OpenCon(){
    $dbhost = "localhost";
    $dbuser =   "root";
    $dbpass = "";
    $db = "edbms";

    $conn = new mysqli($dbhost,$dbuser,$dbpass,$db) or die("Connection Field". $conn->error);

    return $conn;
}

function CloseCon($conn){
    $conn -> close();
}

?>