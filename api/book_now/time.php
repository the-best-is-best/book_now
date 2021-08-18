<?php
require_once('models/response.php');

date_default_timezone_set("Africa/Cairo");

$date_zone = date("Y-m-d H:i:s");
$response = new Response();
$response->setHttpStatusCode(201);
$response->setSuccess(true);
$response->addMessage("Time is: ");
$response->setData($date_zone);
$response->send();
exit;

?>