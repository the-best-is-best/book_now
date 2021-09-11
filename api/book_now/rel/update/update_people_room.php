<?php
require_once('../../controller/db.php');
require_once('../../models/response.php');

try {
    $writeDB = DB::connectionWriteDB();
} catch (PDOException $ex) {
    error_log("connection Error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('Database connection error');
    $response->send();
    exit;
}


if ($_SERVER['REQUEST_METHOD']  !== 'PUT') {
    $response = new Response();
    $response->setHttpStatusCode(405);
    $response->setSuccess(false);
    $response->addMessage('Request method not allowed');
    $response->send();
    exit;
}


if ($_SERVER['CONTENT_TYPE'] !== 'application/json') {
    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    $response->addMessage('Content Type header not json');
    $response->send();
    exit;
}

$rowPostData = file_get_contents('php://input');

if (!$jsonData = json_decode($rowPostData)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    $response->addMessage('Request body is not valid json');
    $response->send();
    exit;
}
if (
    !isset($jsonData->people_id) || !isset($jsonData->room_id) || !isset($jsonData->project) 
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->people_id) ?  $response->addMessage("people not supplied") : false);
    (!isset($jsonData->room_id) ?  $response->addMessage("room not supplied") : false);
    (!isset($jsonData->project) ?  $response->addMessage("project not supplied") : false);
  
    $response->send();
    exit;
}

$project_id = $jsonData->project;
$room_id =$jsonData->room_id;
$people_id =$jsonData->people_id;



try {

    $query = $writeDB->prepare('UPDATE rel_people SET room_id = :room_id  WHERE project_id = :project_id AND id=:id ');

    $query->bindParam(':room_id', $room_id, PDO::PARAM_STR);
    $query->bindParam(':project_id', $project_id, PDO::PARAM_STR);
    $query->bindParam(':id', $people_id, PDO::PARAM_STR);
  

    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue update people room - please try again .');
        $response->send();
        exit;
    }



    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('People room updated');
    $response->send();
    exit;

} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue update people room - please try again' . $ex);
    $response->send();
    exit;
}