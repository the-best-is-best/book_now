<?php
require_once('../Controller/db.php');
require_once('../Models/Response.php');

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

if ($_SERVER['REQUEST_METHOD']  !== 'GET') {
    $response = new Response();
    $response->setHttpStatusCode(405);
    $response->setSuccess(false);
    $response->addMessage('Request method not allowed');
    $response->send();
    exit;
}


try {
    $query = $readDB->prepare("select * from project_name");

    $query->execute();
    $row;
    $rowCount = $query->rowCount();
    if ($rowCount > 0) {
        $row = $query->fetchAll();
        foreach ($row as $key => $data) {
            if ($data['end_date'] <= date("Y-m-d H:i:s")) {
                unset($row[$key]);
                $query = $writeDB->prepare("delete from project_name where id =:id ");
                $query->bindParam(':id', $data['id'], PDO::PARAM_STR);
                $query->execute();
            }
        }
        $returnData = $row;
        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->setData($returnData);
        $response->send();
        exit;
    } else {
        exit;
    }
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating Project - please try again' . $ex);
    $response->send();
    exit;
}
