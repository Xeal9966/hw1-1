<?php
if (session_status()<2) session_start();

if (isset($_SESSION['id']) && isset($_SESSION['logged']) && $_SESSION['logged']== 'true'){
    
    require_once 'dbconnect.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());
    $cf = $_SESSION['id'];

    $query = "SELECT Balance FROM Card c WHERE Card_ID = (SELECT ID FROM Card_Type WHERE Type = 'Bancomat') AND c.Account_ID = (SELECT Account_ID FROM Subscription where CF  = '".$cf."')";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };    
    $r = mysqli_fetch_assoc($res);
    $r['Balance'] = number_format( $r['Balance'], 0, '','.');
    
    echo json_encode($r);

    mysqli_close($conn);

} else echo json_encode(array('error' => 'Something bad happened!'));

?>