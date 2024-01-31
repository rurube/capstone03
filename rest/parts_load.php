<?php
include 'db_setup.php';

$id = $_POST['id'];

$sqlQuery = "SELECT name, category, image, location FROM parts WHERE id = '$id'";
$res = $conn -> query($sqlQuery);
$result = array();

while($row = mysqli_fetch_array($res)){
    array_push($result, array('name'=>$row[0], 'category'=>$row[1],'image'=>$row[2], 'location'=>$row[3]));
    #array_push($result, array('idx'=>$row[0], 'name'=>$row[1], 'category'=>$row[2], 'color'=>$row[3], 'rest'=>$row[4], 'mesg' =>$row[5],'location'=>$row[6], 'id'=>$row[7], 'image'=>$row[8], 'wgt'=>$row[9]));
}
echo json_encode($result,JSON_UNESCAPED_UNICODE);
$conn->close();
?>