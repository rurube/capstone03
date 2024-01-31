<?php
include 'db_setup.php';

$id = $_POST['id'];
$name = $_POST['name'];
$image = $_POST['image'];
$category = $_POST['category'];
$color = $_POST['color'];
$mesg = $_POST['mesg'];
$location = $_POST['location'];
$wgt = $_POST['wgt'];

$sqlQuery = "INSERT INTO parts SET id = '$id', name = '$name', image='$image', category='$category', color = '$color', mesg='$mesg', location = '$location', wgt = '$wgt'";

$resultQuery = $conn -> query($sqlQuery);

if($resultQuery){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success" => false));
}

$conn->close();
?>