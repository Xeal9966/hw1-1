<?php

if (session_status()<2) session_start();

if (isset($_SESSION['id']) && isset($_SESSION['logged']) && $_SESSION['logged']== 'true'){
    
    require_once 'dbconnect.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());
    $cf = $_SESSION['id'];

    $query = "UPDATE Card SET Favorite = 0  WHERE Account_ID = (SELECT Account_ID FROM Subscription WHERE CF = '".$cf."')";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };
    $query = "UPDATE Card SET Favorite = 1  WHERE Account_ID = (SELECT Account_ID FROM Subscription WHERE CF = '".$cf."') AND Number LIKE '%".$_POST['Number']."'";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };


    echo json_encode("Success");

    mysqli_close($conn);

} else echo json_encode(array('error' => 'Something bad happened!'));


?>