<?php
error_reporting(0);
set_time_limit(0);
ob_implicit_flush();
$host = "127.0.0.1";
$port = 80;
echo "Waiting for connections... \n";
$socket = socket_create(AF_INET, SOCK_STREAM, 0) or die("Could not create socket\n");
echo "s";

$result = socket_bind($socket, $host, $port) or die("Could not bind to socket\n");

$result = socket_listen($socket) or die("Could not set up socket listener\n");
while (true) {
    $spawn[++$i] = socket_accept($socket) or die("Could not accept incoming connection\n");
    echo "\n";
    $input = socket_read($spawn[$i], 1024);
    $client = $input;

    echo $client . "\n";

    socket_close($spawn[$i]);
    echo "\n";
}
socket_close($socket);
