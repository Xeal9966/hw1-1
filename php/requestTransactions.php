<?php

if (session_status()<2) session_start();

if (isset($_SESSION['id']) && isset($_SESSION['logged']) && $_SESSION['logged']== 'true'){
    
    require_once 'dbconnect.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());
    $cf = $_SESSION['id'];

    $query = "SELECT t.Agent, t.InOut, t.Type, t.Amount ,t.Type , t.Number, t.Date FROM Transaction t WHERE Number IN (SELECT Number FROM Card WHERE Account_ID = (SELECT Account_ID FROM Subscription WHERE CF = '".$cf."'))";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };
    
    $response = array();
    while($r = mysqli_fetch_assoc($res)){
        $r['Number'] = substr($r['Number'], -4);
        $response[] = $r;
    }
    
    echo json_encode($response);

    mysqli_close($conn);

} else echo json_encode(array('error' => 'Something bad happened!'));

?>