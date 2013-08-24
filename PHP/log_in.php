<?php
header('Content-type: application/json');
include_once('database.php');
include_once('utils.php');

openDatabaseConnection();
$params = secureParameters($_REQUEST);

//Check if login correct
$email_address = $params['email'];
$salty = $params['password'] . "ajjdlelsljeo";
$password_hash = hash('sha256', $salty);
$sql = "SELECT app_key FROM users WHERE email_address='$email_address' AND password_hash='$password_hash'";
$result = mysql_query($sql);
$num_rows = mysql_num_rows($result);
if($num_rows < 1){

$responce['status'] = "Failed";
$responce['message'] = "Email or Password Does not exist";
echo json_encode($responce);
exit;

}
else{
$row = mysql_fetch_assoc($result);
$app_key = $row['app_key'];
$responce['status'] = "Good";
$responce['message'] = "";
$responce['app_key'] = $app_key;
echo json_encode($responce);
	
}



?>