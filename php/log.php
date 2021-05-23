<?php
if (session_start() < 2) session_start();
echo json_encode($_SESSION);
?>