<?php
if (session_status()<2) session_start();

if (isset($_SESSION['id']) && isset($_SESSION['logged']) && $_SESSION['logged']== 'true'){

    require_once 'dbconnect.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());
    $cf = $_SESSION['id'];
    $query = "SELECT `Name`, `Surname`, `Profile_img` FROM User WHERE CF = '".$cf."'";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode("Query Error");
        mysqli_close($conn);
        exit;
    };
    $val = mysqli_fetch_assoc($res);
    $query = "SELECT `Balance` FROM Subscription  s, Account a WHERE s.CF = '".$cf."'AND s.Account_ID = a.Account_ID";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode("Query Error");
        mysqli_close($conn);
        exit;
    };
    $val2 = mysqli_fetch_assoc($res);

    $response =  array("name" => $val['Name'], "surname" => $val['Surname'], "balance" => number_format( $val2['Balance'], 0, '','.'), "src" => $val['Profile_img']);
    echo json_encode($response);
    
    mysqli_close($conn);

    
} else echo json_encode(array('error' => 'Something bad happened!'));



?>