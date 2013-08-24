<?php
header('Content-type: application/json');
include_once('database.php');
include_once('utils.php');

openDatabaseConnection();

$params = secureParameters($_REQUEST);

$sql = "INSERT INTO news_letter (user_id, news_letter_name) VALUES (1, 'test')";
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