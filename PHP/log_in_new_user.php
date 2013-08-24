<?php
header('Content-type: application/json');
include_once('database.php');
include_once('utils.php');

openDatabaseConnection();

$params = secureParameters($_REQUEST);


//Check if user exits?
$email_address = $params['email'];
$sql = "SELECT email_address FROM users WHERE email_address='$email_address'";
$result = mysql_query($sql);
$num_rows = mysql_num_rows($result);
if($num_rows > 0){

$responce['status'] = "Failed";
$responce['message'] = "Email already exists";
echo json_encode($responce);
exit;

}

//Insert New User

$time = time();
$app_key = uniqid() . uniqid() . uniqid();
$salty = $params['password'] . "ajjdlelsljeo";
$password_hash = hash('sha256', $salty);

$sql = "INSERT INTO users (email_address, reginstration_time, app_key, password_hash) VALUES ('$email_address', $time, '$app_key','$password_hash')";
	$result = mysql_query($sql);
	
	if($result)
	{
		$responce['status'] = "success";
		$responce['message'] = "";
		$responce['app_key'] = $app_key;
		echo json_encode($responce);
	}
	else
	{
		$responce['status'] = "failed";
		$responce['message'] = $sql;
		$responce['vardump'] = $params;
		$responce['error_number'] = mysql_errno($result);
		echo json_encode($responce);
		exit;
	}











?>