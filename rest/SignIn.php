<?php
include 'db_setup.php';

$id = $_POST['id']; 
$pw = $_POST['pw'];

$sqlQuery = "SELECT * FROM login WHERE id = '$id' AND pw = '$pw'";

$resultQuery = $conn -> query($sqlQuery);

if($resultQuery -> num_rows > 0){

  $userRecord = array();
  while($rowFound = $resultQuery->fetch_assoc()){
    $userRecord[] = $rowFound;
  }
  echo json_encode(array(
    "success" => true,
    "userData" => $userRecord[0]
  ));
}else{
  echo json_encode(array("success" => false));
}

$conn -> close();

?>