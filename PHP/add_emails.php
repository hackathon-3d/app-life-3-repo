<?php
header('Content-type: application/json');
include_once('database.php');
include_once('utils.php');

openDatabaseConnection();
$bodyRaw = file_get_contents('php://input');
//$body = secureParameters($bodyRaw);
$body = json_decode(str_replace ('\"','"', $bodyRaw), true);
$json_errors = array(
    JSON_ERROR_NONE => 'No error has occurred',
    JSON_ERROR_DEPTH => 'The maximum stack depth has been exceeded',
    JSON_ERROR_CTRL_CHAR => 'Control character error, possibly incorrectly encoded',
    JSON_ERROR_SYNTAX => 'Syntax error',
);
// echo 'Last error : ', $json_errors[json_last_error()], PHP_EOL, PHP_EOL;



//echo var_dump($body);

//Auth User



$emailArray = $body['emails'];

foreach($emailArray as $emailItem){
//echo $emailItem['email'];
$email_address = $emailItem['email'];
$name = $emailItem['name'];
$sql = "INSERT INTO users_emails_raw (email_address, name, user_id, email_list_id) VALUES ('$email_address', '$name', 1, 1)";
	$result = mysql_query($sql);

}

$responce['status'] = "Good";
$responce['message'] = "";
echo json_encode($responce)



?>