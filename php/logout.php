<?php 

if (session_status()<2) session_start();
$_SESSION = array();
session_destroy();
echo json_encode('success');
?>