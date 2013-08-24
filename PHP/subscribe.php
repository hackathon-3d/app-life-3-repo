<html>
<head>
<title>
Login page
</title>
</head>
<body>
<div style="position: absolute;
left: 50%;
top: 50%;
text-align: center;        
background-image: url('Images/loginBox.png');
width:546px;
height:265px;
margin-left: -273px; /*half width*/
margin-top: -132px; /*half height*/
font-family:Helvetica, Arial, Sans-Serif;">
<h1 style="font-family:Helvetica, Arial, Sans-Serif;color:#6955A9;text-align="center";font-size:20pt;
text-color:#6955A9;>
Subscribe to Emails
</h1>
<form name="login" action="subscribe.php" method="post">
Your Email: <input type="email" name="email_address"/>
<input type="hidden" id="ref_id" value="<?php echo $_GET['ref_id'];  ?>">
<input type="submit" value="Subscribe"/>
</form>

<?php
include_once('database.php');
include_once('utils.php');

openDatabaseConnection();
$params = secureParameters($_POST);
//$sql = "INSERT INTO users_emails_raw (email_address, user_id, name, email_list_id) VALUES ('$email_address', $time, '$app_key','$password_hash')";


?>


</div>
</body>
</html>