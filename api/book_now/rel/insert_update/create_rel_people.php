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


if ($_SERVER['REQUEST_METHOD']  !== 'POST') {
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

if (!isset($jsonData->people_id) || !isset($jsonData->travel_id) || !isset($jsonData->project_id) || !isset($jsonData->house_id) || !isset($jsonData->room_id)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->people_id) ?  $response->addMessage("People issue") : false);

    (!isset($jsonData->project_id) ?  $response->addMessage("project issue") : false);

    (!isset($jsonData->house_id) ?  $response->addMessage("house issue ") : false);
    (!isset($jsonData->room_id) ?  $response->addMessage("Room issue ") : false);

    (!isset($jsonData->travel_id) ?  $response->addMessage("Travel issue") : false);

    $response->send();
    exit;
}
$people_id = $jsonData->people_id;
$project_id = $jsonData->project_id;
$paid = $jsonData->paid;
$support = $jsonData->support;
$travel_id = $jsonData->travel_id;
$bones = $jsonData->bones;
$house_id = $jsonData->house_id;
$room_id = $jsonData->room_id;


try {
    $query = $writeDB->prepare('SELECT * FROM rel_people WHERE project_id = :project_id AND people_id = :people_id');
    $query->bindParam(':project_id', $project_id, PDO::PARAM_STR);
    $query->bindParam(':people_id', $people_id, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount !== 0) {

        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('People already exists');
        $response->send();
        exit;
    }

    $query = $writeDB->prepare('INSERT into rel_people (people_id , project_id , paid , support , travel_id , bones , house_id , room_id ) 
    VALUES (:people_id , :project_id , :paid , :support , :travel_id , :bones , :house_id , :room_id)');

    $query->bindParam(':people_id', $people_id, PDO::PARAM_STR);
    $query->bindParam(':project_id', $project_id, PDO::PARAM_STR);
    $query->bindParam(':paid', $paid, PDO::PARAM_STR);
    $query->bindParam(':support', $support, PDO::PARAM_STR);
    $query->bindParam(':travel_id', $travel_id, PDO::PARAM_STR);
    $query->bindParam(':bones', $bones, PDO::PARAM_STR);
    $query->bindParam(':house_id', $house_id, PDO::PARAM_STR);
    $query->bindParam(':room_id', $room_id, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue creating residence - please try again');
        $response->send();
        exit;
    }


    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Residence Created');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue Select residence - please try again' . $ex);
    $response->send();
    exit;
}
