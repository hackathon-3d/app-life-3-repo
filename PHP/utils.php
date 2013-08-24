<?php
date_default_timezone_set("America/Chicago");
	
$hostIP = $_SERVER['SERVER_ADDR'];
$publicHost = $hostIP;


/*
mb_language('uni');
mb_internal_encoding("UTF-8");
mb_http_output('UTF-8');
ob_start('mb_output_handler');
*/

// ===============================================================

function printArray($aArray)
{
	echo "<pre>";
	print_r($aArray);
	echo "</pre>";
}

// ===============================================================

function isDST(/* assumes "now" */)
{
	$result = false;
	if (date("T") == "CDT") $result = true;
	return $result;
}

// ===============================================================

function truncateSentence($sentence, $startIdx)
{
	// trim the sentence at the first space after specified position
	$sentenceLength = strlen($sentence);
	$spaceIdx = $startIdx;
	$continueLoop = true;
	$spaceFound = true;
	while ($continueLoop == true)
	{
		if ($spaceIdx >= $sentenceLength)
		{
			$continueLoop = false;
			$truncated = substr($sentence, 0, $sentenceLength);
		}
		if (substr($sentence, $spaceIdx, 1) == " ")
		{
			$continueLoop = false;
			$truncated = substr($sentence, 0, $spaceIdx) . "...";
		}
		if ($spaceIdx > ($startIdx + 16))
		{
			$continueLoop = false;
			$truncated = substr($sentence, 0, $startIdx) . "...";
		}
		$spaceIdx++;
	}
	return $truncated;
}

// ===============================================================

function trimElement($element)
{
	$result = strip_tags($element);
	$result = truncateSentence($result, 200);
	return $result;
}

// ===============================================================

function fixText($originalString)
{
	// equivalent ascii values of these characters.
	//`(96) ’(130) „(132) ‘(145) ’(146) “(147) ”(148) ´(180) 

/*
	$result = '';
	$s1 = iconv('UTF-8', 'ASCII//TRANSLIT', $originalString);

	$sourceEncoding = "ASCII";
	$t1 = iconv($sourceEncoding, 'utf-8', "`’„‘’´");
	$t2 = iconv($sourceEncoding, 'utf-8', "'','''");
	$t3 = iconv($sourceEncoding, 'utf-8', '“”');
	$t4 = iconv($sourceEncoding, 'utf-8', '""');

	for ($i = 0; $i < strlen($s1); $i++)
	{
		$ch1 = $s1[$i];
		$ch2 = mb_substr($s, $i, 1);
		$ch3 = $ch1=='?'?$ch2:$ch1;

		$ch3 = strtr($ch3, $t1, $t2);
		$ch3 = strtr($ch3, $t3, $t4); 
		
		$result .= $ch3;
	}
*/
	$result = $originalString;

	$t1 = "`’„‘’´";
	$t2 = "'','''";
	$t3 = '“”';
	$t4 = '""';

//	$result = strtr($result, $t1, $t2);
//	$result = strtr($result, $t3, $t4); 

	//$result = strtr($result, "\\", ""); 
	
	
	$result = str_replace("\n", " ", $result);
	$result = str_replace("\r", " ", $result);
	$result = str_replace("\t", " ", $result);
	$result = str_replace("\v", " ", $result);
	$result = str_replace("\f", " ", $result);
	$result = trim($result);
	
/*
	if ($originalString != $result)
	{
		echo "fixText changed line -<br>";
		echo $originalString . "<br>";
		echo $result . "<br>";
	}
*/

	return $result;
}

// ===============================================================

function addLeadingZeros($value, $positions)
{
	$result = $value;
	
	$valueLen = strlen($value);
	if ($valueLen < $positions)
	{
		$result = str_repeat("0", $positions - $valueLen) . $value;
	}
	
	return $result;
}

// ===============================================================

function secureParameters($aArray)
{
	$result = $aArray;
	$result = array_map("htmlspecialchars", $result);	# secure from XSS
	$result = array_map("trim", $result); # Remove leading/trailing spaces
	$result = array_map("stripslashes",$result);//Remove slashes
	$result = array_map("mysql_real_escape_string", $result); # SQL injections
	return $result;
}

function secureParametersMYSQLi($aArray)
{
	$result = $aArray;
	$result = array_map("htmlspecialchars", $result);	# secure from XSS
	$result = array_map("trim", $result); # Remove leading/trailing spaces
	$result = array_map("stripslashes",$result);//Remove slashes
	$result = array_map("mysql_escape_mimic", $result); # SQL injections
	return $result;
}

function mysql_escape_mimic($inp) { 
    if(is_array($inp)) 
        return array_map(__METHOD__, $inp); 

    if(!empty($inp) && is_string($inp)) { 
        return str_replace(array('\\', "\0", "\n", "\r", "'","'", '"', "\x1a"), array('\\\\', '\\0', '\\n', '\\r', "\\'", "\\'", '\\"', '\\Z'), $inp); 
    } 

    return $inp; 
} 

// ===============================================================

function dom2array($node) {
  $res = array();
  print $node->nodeType.'<br/>';
  if($node->nodeType == XML_TEXT_NODE){
      $res = $node->nodeValue;
  }
  else{
      if($node->hasAttributes()){
          $attributes = $node->attributes;
          if(!is_null($attributes)){
              $res['@attributes'] = array();
              foreach ($attributes as $index=>$attr) {
                  $res['@attributes'][$attr->name] = $attr->value;
              }
          }
      }
      if($node->hasChildNodes()){
          $children = $node->childNodes;
          for($i=0;$i<$children->length;$i++){
              $child = $children->item($i);
              $res[$child->nodeName] = dom2array($child);
          }
      }
  }
  return $res;
}

// ===============================================================

function dom2array_full($node)
{ 
    $result = array(); 
    
    $node_class = get_class($node);
    
    if ($node_class == "DOMElement")
    {
    	unset($newResult);
		$newResult["name"] = $node->nodeName;
		$newResult["value"] = $node->nodeValue;
				
		if ($node->hasAttributes()) 
		{ 
			$attributes = $node->attributes; 
			if(!is_null($attributes))
			{
				unset($attributeList);
				foreach ($attributes as $index=>$attr) 
				{
					$attribute["name"] = $attr->name;
					$attribute["value"] = $attr->value;
					
					$attributeList[] = $attribute; 
				}
				
				$newResult["attributes"] = $attributeList;
			}
		} 
		
		if ($node->hasChildNodes())
		{ 
			unset($childNodes);
			$children = $node->childNodes; 
			for($i = 0; $i < $children->length; $i++) 
			{ 
				$child = $children->item($i); 
				$childNodes[] = dom2array_full($child); 
			} 

			$newResult["childNodes"] = $childNodes;
		} 
 
 		$result[] = $newResult; 
	}
    elseif ($node_class == "DOMText")
    {
    	unset($newResult);
		$newResult["name"] = $node->nodeName;
		$newResult["value"] = $node->nodeValue;
 		$result[] = $newResult; 
    }
    elseif ($node_class == "DOMNodeList")
    {
		unset($childNodes);
		for($i = 0; $i < $node->length; $i++) 
		{ 
			$child = $node->item($i);
			$result[] = dom2array_full($child);
		} 
    }
    elseif ($node_class == "DOMCdataSection")
    {
		unset($newResult);
		$newResult["name"] = "cdata";
		$newResult["value"] = $node->data;
		
 		$result[] = $newResult; 		
    }
    else
    {
    	echo "node_class not handled: $node_class<br>";
    	//echo $node . "<br>";
    	//printArray($node);
    	echo "variable type = " . gettype($node) . "<br>";
    	echo "object class = " . get_class($node) . "<br>";
    }
    
    return $result; 
} 

// ===============================================================

function recursive_array_search($needle, $haystack) 
{ 
    foreach ($haystack as $key=>$value) 
    { 
    	$current_value = $value;
    	
        if ($needle === $key) 
        { 
            return $current_value; 
        } 
        else
        if (($needle === $key) OR (is_array($value) && 
        		recursive_array_search($needle, $value))) 
        { 
        	if (is_array($value))
        	{
        		$current_value = recursive_array_search($needle, $value);
        		if ($current_value !== false)
        		{
        			return $current_value;
        		}
        	}
        } 
    } 
    return false; 
} 

// ===============================================================

function find_tag($tag, $tagArray) 
{ 
	foreach ($tagArray as $item)
	{
		if ($item["name"] == $tag)
		{
			$value = $item["value"];
			if ($value > "")
			{
				return $value;
			}
		}
	}
	return null;
}


// ===============================================================

function getCharset($url)
{ 
	// extract the charset attribute from the HTTP header
	
	// get http header only
	$ch = curl_init(); 
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
	curl_setopt($ch, CURLOPT_URL, $url); 
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 20);
	curl_setopt ($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11');
	curl_setopt($ch, CURLOPT_HEADER, true); 
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'HEAD'); // HTTP request is 'HEAD'
	$header = curl_exec($ch); 
	curl_close($ch);
	$header_array = explode("\n", $header);
	printArray($header_array);
	
	$charset = "";
	
	foreach($header_array as $header_idx => $header_value)
	{
		$valueLength = strlen($header_value);
		$contentTypeTag = "Content-Type:";
		$contentTypeTagLength = strlen($contentTypeTag);
		
		$tagPos = stripos($header_value, $contentTypeTag);
		if ($tagPos !== false)
		{
			if ($tagPos == 0)
			{
				$charsetTag = "charset=";
				$charsetTagLength = strlen($charsetTag);
				$charsetPos = stripos($header_value, $charsetTag);
				{
					if ($charsetPos !== false)
					{
						$continueScan = true;
						$charsetPos += $charsetTagLength;
						while ($continueScan == true)
						{
							$aChar = substr($header_value, $charsetPos, 1);
							
							if ($aChar == ";")
							{
								$continueScan = false;
							}
							else
							{
								$charset .= $aChar;
							}
							
							$charsetPos++;
							if ($charsetPos >= $valueLength)
							{
								$continueScan = false;
							}
						}
					}
				}
			}
		}
	}
	
	return trim($charset);
}




?>