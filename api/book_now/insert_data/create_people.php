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
    strlen($jsonData->name) < 1 || strlen($jsonData->name) > 255 ||
    strlen($jsonData->city) < 1 || strlen($jsonData->city) > 255
) {
    $response = new Response();

    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (strlen($jsonData->name) < 1 ?  $response->addMessage("People Name cannot be black") : false);
    (strlen($jsonData->name) > 255 ?  $response->addMessage("People Name cannot be greater than 255 characters") : false);

    (strlen($jsonData->city) < 1 ?  $response->addMessage("city  cannot be black") : false);
    (strlen($jsonData->city) > 255 ?  $response->addMessage("city  cannot be greater than 255 characters") : false);

    $response->send();
    exit;
}
$name = $jsonData->name;
$tel = $jsonData->tel;
$city = $jsonData->city;

try {

    $query = $writeDB->prepare('SELECT id FROM people WHERE name = :name ');
    $query->bindParam(':name', $name, PDO::PARAM_STR);

    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount !== 0) {
        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('People name already exists');
        $response->send();
        exit;
    }
    if ($tel != 0) {
        $query = $writeDB->prepare('SELECT id FROM people WHERE tel = :tel ');
        $query->bindParam(':tel', $tel, PDO::PARAM_STR);

        $query->execute();

        $rowCount = $query->rowCount();
        if ($rowCount !== 0) {
            $response = new Response();
            $response->setHttpStatusCode(409);
            $response->setSuccess(false);
            $response->addMessage('Telephone already exists');
            $response->send();
            exit;
        }
    }

    $query = $writeDB->prepare('INSERT INTO people (name , tel , city ) VALUES (:name , :tel , :city )');

    $query->bindParam(':name', $name, PDO::PARAM_STR);
    $query->bindParam(':tel', $tel, PDO::PARAM_STR);
    $query->bindParam(':city', $city, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue creating people - please try again');
        $response->send();
        exit;
    }


    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('People Created');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating people - please try again' . $ex);
    $response->send();
    exit;
}
