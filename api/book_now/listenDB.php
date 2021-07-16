<?php
require_once('controller/db.php');
require_once('models/response.php');

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
try {
    $row;
    $query = $readDB->prepare("SELECT id FROM book_now_log");
    $query->execute();
    $rowCount = $query->rowCount();
    if ($rowCount > 0) {
        if ($jsonData->book_now_log_count < $rowCount) {
            $countNewData =
                $rowCount - $jsonData->book_now_log_count;
            $query = $readDB->prepare("SELECT * FROM book_now_log ORDER BY id  desc Limit $countNewData ");
            $query->execute();
            $row = $query->fetchAll();
        } else {
            $response = new Response();
            $response->setHttpStatusCode(201);
            $response->setSuccess(true);
            $response->addMessage("No data changed");
            $response->send();
            exit();
        }

        $returnData = [];
        while ($countNewData > 0) {

            $returnData[$countNewData] = $row[count($row) - $countNewData];
            $countNewData--;
        }

        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage("data changed");
        $response->setData($returnData);
        $response->send();
        exit;
    } else {
        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage("no data changed");
        $response->send();
        exit;
    }
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue -  connect server' . $ex);
    $response->send();
    exit;
}
