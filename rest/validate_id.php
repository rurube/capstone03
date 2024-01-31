<?php
include 'db_setup.php';

$id = $_POST['id'];


$sqlQuery = "SELECT * FROM login WHERE id='$id'";

$resultQuery = $conn -> query($sqlQuery);

if($resultQuery -> num_rows > 0){
    echo json_encode(array("existId" => true));
}else{
    echo json_encode(array("existId" => false));
}

$conn->close();
?>