<?php
function OpenCon(){
    $dbhost = "localhost";
    $dbuser =   "root";
    $dbpass = "";
    $db = "edbms";

    $conn = new mysqli($dbhost,$dbuser,$dbpass,$db) or die("Connection Field". $conn->error);
    //moda lakata git kiya denawa
    return $conn;
}

function CloseCon($conn){
    $conn -> close();
}

?>