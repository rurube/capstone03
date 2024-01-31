<?php
include 'db_setup.php';

$name = $_POST['name'];
$id = $_POST['id'];
$pw = $_POST['pw'];

$sqlQuery = "INSERT INTO login SET name='$name', id='$id', pw='$pw'";
$sqlQuery2 = "INSERT INTO custom SET id = '$id'";

$resultQuery = $conn -> query($sqlQuery);
$resultQueary2 = $conn -> query($sqlQuery2);

if($resultQuery){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success" => false));
}


$conn->close();
?>