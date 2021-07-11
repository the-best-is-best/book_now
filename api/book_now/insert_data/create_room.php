<?php
require_once('../controller/db.php');
require_once('../models/response.php');

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

if (!isset($jsonData->name)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->name) ?  $response->addMessage("Room Name not supplied") : false);

    $response->send();
    exit;
}

if (
    strlen($jsonData->name) < 1 || strlen($jsonData->name) > 255
) {
    $response = new Response();

    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (strlen($jsonData->name) < 1 ?  $response->addMessage("Room Name cannot be black") : false);
    (strlen($jsonData->name) > 255 ?  $response->addMessage("Room Name cannot be greater than 255 characters") : false);

    $response->send();
    exit;
}
$name = $jsonData->name;
$house_id = $jsonData->house_id;
$floor = $jsonData->floor;
$numbers_of_bed = $jsonData->numbers_of_bed;

try {

    $query = $writeDB->prepare('SELECT id FROM rooms WHERE name = :name && house_id = :house_id && floor= :floor');
    $query->bindParam(':name', $name, PDO::PARAM_STR);
    $query->bindParam(':house_id', $house_id, PDO::PARAM_STR);
    $query->bindParam(':floor', $floor, PDO::PARAM_STR);
 
    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount !== 0) {
        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('Room name already exists');
        $response->send();
        exit;
    }

    $query = $writeDB->prepare('INSERT INTO rooms (name , house_id , floor , numbers_of_bed ) VALUES (:name , :house_id , :floor , :numbers_of_bed)');

    $query->bindParam(':name', $name, PDO::PARAM_STR);
    $query->bindParam(':house_id', $house_id, PDO::PARAM_STR);
    $query->bindParam(':floor', $floor, PDO::PARAM_STR);
    $query->bindParam(':numbers_of_bed', $numbers_of_bed, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue creating Room - please try again');
        $response->send();
        exit;
    }
    $last_id = $writeDB->lastInsertId();



    $returnData = array();
    $returnData['id'] = $last_id;
    $returnData['name'] = $name;
    $returnData['house_id'] = $house_id;
    $returnData['floor'] = $floor;
    $returnData['numbers_of_bed'] = $numbers_of_bed;

    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Room Created');
    $response->setData($returnData);
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating Room - please try again' . $ex);
    $response->send();
    exit;
}
