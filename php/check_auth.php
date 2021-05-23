<?php
if (session_status() < 2) session_start();
if (isset($_SESSION['logged']) && $_SESSION['logged'] == 'true'){
    echo json_encode('logged');
} else echo json_encode('not logged');
?>