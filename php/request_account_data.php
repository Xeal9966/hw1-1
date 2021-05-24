<?php

if (session_status()<2) session_start();

if (isset($_SESSION['id']) && isset($_SESSION['logged']) && $_SESSION['logged']== 'true'){
    $response = array();

    require_once 'dbconnect.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());
    $cf = $_SESSION['id'];
    $query = "SELECT `Email`,`CF`,`Name`,`Surname`, `Residence`,`Phone`,`Dob`,`Profile_img` FROM `User` WHERE CF = '".$cf."'"; 

    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };
    $val = mysqli_fetch_assoc($res);
    foreach ($val as $key => $value){
        $response[$key] = $value;
    }


    $query = "SELECT `StartDate` FROM Subscription WHERE CF ='".$cf."'";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };
    $val = mysqli_fetch_assoc($res);
    foreach ($val as $key => $value){
        $response[$key] = $value;
    }
  
    $query = "SELECT `Balance`, `Fee`, `Type` FROM Subscription  s, Account a WHERE s.CF = '".$cf."'AND s.Account_ID = a.Account_ID";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };
    $val = mysqli_fetch_assoc($res);
    foreach ($val as $key => $value){
        $response[$key] = $value;
    }
    
    echo json_encode($response);

    mysqli_close($conn);

} else echo json_encode(array('error' => 'Something bad happened!'));




?>