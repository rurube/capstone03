<?php
include 'db_setup.php';

$id = $_POST['id'];
$low = $_POST['low'];
$mid = $_POST['mid'];

$sqlQuery = "UPDATE SET low = '$low', mid = '$mid' WHERE id = '$id";

$resultQuery = $conn -> query($sqlQuery);

if($resultQuery){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success" => false));
}

$conn -> close();
?>