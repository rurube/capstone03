<?php
include 'db_setup.php';

$id = $_POST['id'];
$name = $_POST['name'];

$sqlQuery = "DELETE parts WHERE id='$id' AND name = '$name'";

$resultQuery = $conn -> query($sqlQuery);

if($resultQuery){
    echo json_encode(array("succcess" => true));
}else{
    echo json_encode(array("success"=> false));
}

$conn -> close();
?>