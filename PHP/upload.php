<?php
header('Content-type: application/json');
//$allowedExts = array("gif", "jpeg", "jpg", "png");
//$temp = explode(".", $_FILES["file"]["name"]);
//$extension = end($temp);
if (($_FILES["file"]["size"] < 2000000))
  {
  if ($_FILES["file"]["error"] > 0)
    {
    $responce['message'] = $_FILES["file"]["error"];
    $responce['status'] = "Failed";
    
    echo json_encode($responce);
    exit;
    }
  else
    {
    $responce['status'] = "Good";
    
    /*
echo "Upload: " . $_FILES["file"]["name"] . "<br>";
    echo "Type: " . $_FILES["file"]["type"] . "<br>";
    echo "Size: " . ($_FILES["file"]["size"] / 1024) . " kB<br>";
    echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br>";
*/

      $file_folder = uniqid();
      mkdir("raw_files/" . $file_folder . "/");
      move_uploaded_file($_FILES["file"]["tmp_name"],
      "raw_files/" . $file_folder . "/" . $_FILES["file"]["name"]);
      $responce['file_url'] = "http://ec2-54-224-138-99.compute-1.amazonaws.com/raw_files/" . $file_folder . "/" . $_FILES["file"]["name"];
      echo json_encode($responce);
     
    }
  }
else
  {
  $responce['message'] = "Invalid File";
  $responce['status'] = "Failed";
    
  echo json_encode($responce);
  exit;
  }
?>