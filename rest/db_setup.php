<?php
header("Access-Control-Allow-Origin: *");
$mysql_hostname = 'localhost';
$mysql_username = 'seorap';
$mysql_password = 'tjfkq@cst03';
$mysql_database = 'seorap_godohosting_com';

$conn = new mysqli($mysql_hostname, $mysql_username, $mysql_password, $mysql_database);

if($conn -> connect_errno){
    echo '[연결실패...] : '.$connect -> connect_error.'';
}
?>