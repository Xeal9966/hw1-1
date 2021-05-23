<?php
if (!isset($_COOKIE['logged'])){
    
    require_once 'dbconnect.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());

    $email = mysqli_real_escape_string($conn, $_POST['Email']);
    $pass = mysqli_real_escape_string($conn, $_POST['l-password']);

    $query = "SELECT Email, Passwd, CF FROM `User` WHERE Email = '".$email."'";
    $res = mysqli_query($conn, $query);
    if (mysqli_num_rows($res) > 0){
        $val = mysqli_fetch_assoc(($res));
        if (password_verify($pass, $val['Passwd'])){
            session_start();
            $_SESSION['logged'] = 'true';
            $_SESSION['id'] = $val['CF'];
            echo json_encode('success');
        } else echo json_encode(array('error' => 'Wrong Username-Password combo'));
    } else echo json_encode(array('error' => 'Wrong Username-Password combo'));
    mysqli_close($conn);
    exit;

} else echo json_encode('logged');

?>