<?php
include 'db_setup.php';

$id = $_POST['id'];

$sqlQuery = "SELECT name From login WHERE id = '$id'";
$res = $conn -> query($sqlQuery);
$result = array();
while($row = mysqli_fetch_array($res)){
    array_push($result, array('name'=>$row[0]));
}
echo json_encode($result, JSON_UNESCAPED_UNICODE);
$conn -> close();
?>