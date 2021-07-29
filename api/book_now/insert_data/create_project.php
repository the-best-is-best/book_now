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

if (!isset($jsonData->project_name) || !isset($jsonData->end_date) || !isset($jsonData->price) || !isset($jsonData->houseId)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->project_name) ?  $response->addMessage("Project Name not supplied") : false);
    (!isset($jsonData->end_date) ?  $response->addMessage("End date not supplied") : false);
    (!isset($jsonData->price) ?  $response->addMessage("Price not supplied") : false);

    (!isset($jsonData->houseId) ?  $response->addMessage("House not supplied") : false);
    $response->send();
    exit;
}

if (
    strlen($jsonData->project_name) < 1 || strlen($jsonData->project_name) > 255
) {
    $response = new Response();

    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (strlen($jsonData->project_name) < 1 ?  $response->addMessage("Project Name cannot be black") : false);
    (strlen($jsonData->project_name) > 255 ?  $response->addMessage("Project Name cannot be greater than 255 characters") : false);


    $response->send();
    exit;
}

if ($jsonData->end_date <= date("Y-m-d")) {
    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    $response->addMessage("Date time not correct" . $jsonData->end_date . "-" . date("d-m-Y h:m") . "");
    $response->send();
    exit;
}

$date = date_create($jsonData->end_date);

$project_name = trim($jsonData->project_name);
$end_date = date_format($date, "Y/m/d H:i:s");
$price = trim($jsonData->price);
$houseId = $jsonData->houseId;
try {

    $query = $writeDB->prepare('SELECT id from project where project_name = :name');
    $query->bindParam(':name', $project_name, PDO::PARAM_STR);
    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount !== 0) {
        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('Project name already exists');
        $response->send();
        exit;
    }

    $query = $writeDB->prepare('INSERT INTO project (project_name  , price, house_id , end_date )
    VALUES (:project_name , :price , :houseId , :end_date  )');

    $query->bindParam(':project_name', $project_name, PDO::PARAM_STR);
    $query->bindParam(':price', $price, PDO::PARAM_STR);
    $query->bindParam(':houseId', $houseId, PDO::PARAM_STR);
    $query->bindParam(':end_date', $end_date, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue creating Project - please try again');
        $response->send();
        exit;
    }


    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Project Created');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating Project - please try again' . $ex);
    $response->send();
    exit;
}
