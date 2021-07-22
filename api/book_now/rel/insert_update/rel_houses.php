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

if (!isset($jsonData->project_id) || !isset($jsonData->house_id)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->project_id) ?  $response->addMessage("project issue") : false);
    (!isset($jsonData->house_id) ?  $response->addMessage("house issue ") : false);

    $response->send();
    exit;
}
$project_id = $jsonData->project_id;
$house_id = $jsonData->house_id;
$active = $jsonData->active;


try {
    $query = $writeDB->prepare('SELECT * FROM rel_houses WHERE project_id = :project_id AND house_id = :house_id');
    $query->bindParam(':project_id', $project_id, PDO::PARAM_STR);
    $query->bindParam(':house_id', $house_id, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount > 0 && $active == false) {
        $row = $query->fetch();


        $query = $writeDB->prepare('DELETE FROM rel_houses  WHERE project_id = :project_id AND house_id=:house_id');

        $query->bindParam(':project_id', $project_id, PDO::PARAM_STR);
        $query->bindParam(':house_id', $house_id, PDO::PARAM_STR);

        $query->execute();

        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('Updated');

        $response->send();
        exit;
    } else if ($rowCount == 0 && $active == true) {
        $query = $writeDB->prepare('INSERT into rel_houses (project_id , house_id ,active ) VALUES (:project_id , :house_id , :active)');

        $query->bindParam(':project_id', $project_id, PDO::PARAM_STR);
        $query->bindParam(':house_id', $house_id, PDO::PARAM_STR);
        $query->bindParam(':active', $active, PDO::PARAM_STR);

        $query->execute();
        $rowCount = $query->rowCount();

        if ($rowCount === 0) {
            $response = new Response();
            $response->setHttpStatusCode(500);
            $response->setSuccess(false);
            $response->addMessage('There was an issue Select House - please try again');
            $response->send();
            exit;
        }
        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('Inserted');

        $response->send();
        exit;
    }
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue Select House - please try again' . $ex);
    $response->send();
    exit;
}
