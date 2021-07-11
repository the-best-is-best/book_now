<?php
error_reporting(E_ALL);

set_time_limit(0);

ob_implicit_flush();

$host = "192.168.1.6";
$port = "65534";

// create socket
$socket = socket_create(AF_INET, SOCK_STREAM, 0);

// bind socket to port
$result  = socket_bind($socket, $host, $port) or die('Could not bind to socket');
// start listening to connections
$result = socket_listen($socket, 3) or die('Could not set up socket listener');

while (true) {
    // accept incoming connections
    // spawn another socket to handle communication
    $spawn = socket_accept($socket) or die('Could not accept incoming connection');
    // read client input
    $input  = socket_read($spawn, 1024) or die('Could not read input');
    // clean up input string
    $input = trim($input);
    echo "Client Message: " . $input;
    // reverse the message and send back
    $output = strrev($input);
    socket_write($spawn, $output, strlen($output)) or die('Could not write output');
}

// Close sockets
socket_close($spawn);
socket_close($socket);
