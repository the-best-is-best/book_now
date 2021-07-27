<?php
require_once('../../controller/db.php');
require_once('../../models/response.php');

try {
    $readDB = DB::connectReadDB();
} catch (PDOException $ex) {
    error_log("connection Error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('Database connection error');
    $response->send();
    exit;
}
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
/*
if ($_SERVER['REQUEST_METHOD']  !== 'GET') {
    $response = new Response();
    $response->setHttpStatusCode(405);
    $response->setSuccess(false);
    $response->addMessage('Request method not allowed');
    $response->send();
    exit;
}*/


try {
    if (!isset($_GET['id'])) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('Not allowed id');
        $response->send();
        exit;
    }

    if (!isset($_GET['project_id'])) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('Not allowed project id');
        $response->send();
        exit;
    }

    $get_id_data =  $_GET["id"];
    $project_id = $_GET['project_id'];

    $query = $readDB->prepare('SELECT * FROM rel_people  WHERE id IN (' . implode(',', $get_id_data) . ') AND project_id = :project_id ');
    $query->bindParam(':project_id', $project_id, PDO::PARAM_STR);
    $query->execute();
    $row = $query->fetchAll();

    $returnData = $row;
    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->setData($returnData);
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue Get Houses - please try again' . $ex);
    $response->send();
    exit;
}
