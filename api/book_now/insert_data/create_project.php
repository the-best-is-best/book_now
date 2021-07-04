<?php
require_once('../Controller/db.php');
require_once('../Models/Response.php');

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

if (!isset($jsonData->project_name) || !isset($jsonData->end_date) || !isset($jsonData->house_name)) {
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->project_name) ?  $response->addMessage("Project Name not supplied") : false);
    (!isset($jsonData->end_date) ?  $response->addMessage("End date not supplied") : false);
    (!isset($jsonData->house_name) ?  $response->addMessage("House name not supplied") : false);
    $response->send();
    exit;
}

if (
    strlen($jsonData->project_name) < 1 || strlen($jsonData->project_name) > 255 || strlen($jsonData->house_name) < 1
    || strlen($jsonData->house_name) > 255
) {
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (strlen($jsonData->project_name) < 1 ?  $response->addMessage("Project Name cannot be black") : false);
    (strlen($jsonData->project_name) > 255 ?  $response->addMessage("Project Name cannot be greater than 255 characters") : false);

    (strlen($jsonData->house_name) < 1 ?  $response->addMessage("House Name cannot be black") : false);
    (strlen($jsonData->house_name) > 255 ?  $response->addMessage("House Name cannot be greater than 255 characters") : false);

    $response->send();
    exit;
}
if ($jsonData->end_date <= date("d-m-Y h:m")) {
    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    $response->addMessage("Date time not correct");
    $response->send();
    exit;
}
$date = date_create($jsonData->end_date);

$project_name = trim($jsonData->project_name);
$end_date = date_format($date, "Y/m/d H:i:s");
$house_name = trim($jsonData->house_name);

try {

    $query = $writeDB->prepare('select id from project_name where project_name = :name');
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

    $query = $writeDB->prepare('insert into project_name (project_name  , end_date )
    VALUES (:project_name , :end_date  )');

    $query->bindParam(':project_name', $project_name, PDO::PARAM_STR);
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
    $last_id = $writeDB->lastInsertId();

    $query = $writeDB->prepare('insert into houses (name  , project_id )
    VALUES (:name , :project_id  )');

    $query->bindParam(':name', $house_name, PDO::PARAM_STR);
    $query->bindParam(
        ':project_id',
        $last_id,
        PDO::PARAM_STR
    );

    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue creating House - please try again');
        $response->send();
        exit;
    }

    $returnData = array();
    $returnData['project_id'] = $last_id;
    $returnData['project_name'] = $project_name;
    $returnData['house_name'] = $house_name;

    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Project Created');
    $response->setData($returnData);
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
