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

if (!isset($jsonData->id) || !isset($jsonData->floor)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->floor) ?  $response->addMessage("floor not supplied") : false);

    $response->send();
    exit;
}

$id = trim($jsonData->id);
$floor = $jsonData->floor;


try {

    $query = $writeDB->prepare('SELECT floor FROM houses WHERE id = :id');
    $query->bindParam(':id', $id, PDO::PARAM_STR);
    $query->execute();
    $row = $query->fetch();

    $newTotalFloor = $row["floor"] + $floor;

    $query = $writeDB->prepare('UPDATE houses SET floor = :floor WHERE id = :id');

    $query->bindParam(':floor', $newTotalFloor, PDO::PARAM_STR);
    $query->bindParam(':id', $id, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();
    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue update floor - please try again');
        $response->send();
        exit;
    }



    $returnData = array();
    $returnData['id'] = $id;
    $returnData['floor'] = $newTotalFloor;

    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Floor updated');
    $response->setData($returnData);
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating House - please try again' . $ex);
    $response->send();
    exit;
}
