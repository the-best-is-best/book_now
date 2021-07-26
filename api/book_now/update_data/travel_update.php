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

if (!isset($jsonData->id) || !isset($jsonData->name)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->floor) ?  $response->addMessage("Name not supplied") : false);

    $response->send();
    exit;
}

$id = $jsonData->id;
$name = $jsonData->name;


try {

    $query = $writeDB->prepare('SELECT id FROM travel WHERE name = :name AND id != :id');
    $query->bindParam(':name', $name, PDO::PARAM_STR);
    $query->bindParam(':id', $id, PDO::PARAM_STR);

    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount !== 0) {
        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('Travel name already exists');
        $response->send();
        exit;
    }

    $query = $writeDB->prepare('SELECT name FROM travel WHERE id = :id');
    $query->bindParam(':id', $id, PDO::PARAM_STR);
    $query->execute();
    $row = $query->fetch();


    $query = $writeDB->prepare('UPDATE travel SET name = :name WHERE id = :id');

    $query->bindParam(':name', $name, PDO::PARAM_STR);
    $query->bindParam(':id', $id, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();
    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue update name - please try again');
        $response->send();
        exit;
    }



    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Travel updated');

    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue update travel - please try again' . $ex);
    $response->send();
    exit;
}
