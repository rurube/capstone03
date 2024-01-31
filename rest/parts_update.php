<?php
include 'db_setup.php';

$id = $_POST['id']
$name = $_POST['name'];
$image = $_POST['image'];
$category = $_POST['category'];
$color = $_POST['color'];
$mesg = $_POST['mesg'];

$sqlQuery = "UPDATE parts SET name = '$name', image='$image', category='$category', color = '$color', mesg='$mesg' WHERE id = '$id'";

$resultQuery = $conn -> query($sqlQuery);

if($resultQuery){
    echo json_encode(array("succcess" => true));
}else{
    echo json_encode(array("success"=> false));
}

$conn -> close();
?>