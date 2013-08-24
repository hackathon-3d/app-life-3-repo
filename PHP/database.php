<?php

function openDatabaseConnection() {
	
	$hostname = "ec2-54-224-138-99.compute-1.amazonaws.com"; 
	
	$user = "root";
	
	$pass = "binarystargate"; //I hate chris's dumb password
	
	$dbase = "hackathon";
	
	$connection = mysql_connect($hostname, $user , $pass) 
			or die (@"{\"status\":\"failed\",\"message\":\"Could not connect to database. Code 1:1. Please try again.\"");
	
	$db = mysql_select_db($dbase , $connection) 
			or die (@"{\"status\":\"failed\",\"message\":\"Could not connect to database. Code 1:2. Please try again.\"");

	
	mysql_set_charset("utf8", $connection);
	
	return $db;
}

?>