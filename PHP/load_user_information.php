<?php

header('Content-type: application/json');
include_once('database.php');
include_once('utils.php');

openDatabaseConnection();
$params = secureParameters($_REQUEST);

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

$responce['user'] = $row;
$user_id = $row['id'];
//echo "$user_id";
$sql2 = "SELECT * FROM email_list WHERE user_id=$user_id";
$result2 = mysql_query($sql2);
$array1 = array();
while($row2 = mysql_fetch_assoc($result2))
  {
  //echo var_dump($row2);
  $array1[] = $row2;
  }
//echo var_dump($array1);
$responce['status'] = "Good";
$responce['email_lists'] = $array1;
echo json_encode($responce);


?>