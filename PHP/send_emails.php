<?php
header('Content-type: application/json');
include_once('database.php');
include_once('utils.php');

openDatabaseConnection();

$bodyRaw = file_get_contents('php://input');
//$body = secureParameters($bodyRaw);
$body = json_decode($bodyRaw, true);
$json_errors = array(
    JSON_ERROR_NONE => 'No error has occurred',
    JSON_ERROR_DEPTH => 'The maximum stack depth has been exceeded',
    JSON_ERROR_CTRL_CHAR => 'Control character error, possibly incorrectly encoded',
    JSON_ERROR_SYNTAX => 'Syntax error',
);
//echo 'Last error : ', $json_errors[json_last_error()], PHP_EOL, PHP_EOL;

$params = $body;
//echo var_dump($body);


class Mandrill
{
	//public static function __callStatic($method, $args)
	public static function request($method, $arguments = array())
	{

		// load api key
		$api_key = "Yg3Xg7-o9Gi7pwFknkkUZA";

		// determine endpoint
		$endpoint = 'https://mandrillapp.com/api/1.0/'.$method.'.json';

		// build payload
		$arguments['key'] = $api_key;

		// setup curl request
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $endpoint);
		curl_setopt($ch, CURLOPT_TIMEOUT, 30);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
		curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($arguments));
		$response = curl_exec($ch);

		// catch errors
		if (curl_errno($ch))
		{
			#$errors = curl_error($ch);
			curl_close($ch);

			// return false
			return false;
		}
		else
		{
			curl_close($ch);

			// return array
			return json_decode($response);
		}

	}

}


 $html = $params['email_html'];
 $subject = "Hackathon3D!";
 $list_id = $params['email_list_id'];
$app_key = $params['app_key'];
$sql = "SELECT * FROM users WHERE app_key='$app_key' LIMIT 1";
$result = mysql_query($sql);
$num_rows = mysql_num_rows($result);
if($num_rows < 1){

$responce['status'] = "Failed";
$responce['message'] = "No Match";
echo json_encode($responce);
exit;

}
$row = mysql_fetch_assoc($result);

$user_email = $row['email_address'];
$user_id = $row['id'];

$sql2 = "SELECT DISTINCT email_address FROM users_emails_raw WHERE email_list_id=$list_id";
$result2 = mysql_query($sql2);
while($row2 = mysql_fetch_assoc($result2))
  {
 $send_email = $row2['email_address'];
 $response = Mandrill::request('messages/send', array(
    'message' => array(
        'html' => $html,
        'subject' => $subject,
        'from_email' => 'news@52apps.com',
        'to' => array(array('email'=>$send_email)),
    ),
));
}
  
  $extra_addresses = explode(",",$params['extra_addresses']);
foreach($extra_addresses as $extra_address){
	$send_email = $extra_address;
 $response = Mandrill::request('messages/send', array(
    'message' => array(
        'html' => $html,
        'subject' => $subject,
        'from_email' => 'news@52apps.com',
        'to' => array(array('email'=>$send_email)),
    ),
));	
}
  
  $response = Mandrill::request('messages/send', array(
    'message' => array(
        'html' => $html,
        'subject' => $subject,
        'from_email' => 'news@52apps.com',
        'to' => array(array('email'=>$user_email)),
    ),
));
$responce['status'] = "Good";
$responce['message'] = "";
echo json_encode($responce);




?>