<?php
if (session_status()<2) session_start();

if (isset($_SESSION['id']) && isset($_SESSION['logged']) && $_SESSION['logged']== 'true'){
    
    require_once 'dbconnect.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());
    $cf = $_SESSION['id'];

    $query = "SELECT Status, Number, Month, Year, Payment_Date, ActivationDate, Balance, Favorite, ct.Name, ct.Type, ct.Vendor, ct.Monthly_Max, ct.Daily_Max, ct.Tax FROM `Card`, Card_Type ct WHERE Card.Card_ID = ct.ID AND Card.Account_ID = (SELECT Account_ID FROM Subscription where CF  = '".$cf."')";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };
    
    $response = array();
    while($r = mysqli_fetch_assoc($res)){
        $r['Number'] = substr($r['Number'], -4);
        $r['Balance'] = number_format( $r['Balance'], 0, '','.');
        $response[] = $r;
    }
    
    echo json_encode($response);

    mysqli_close($conn);

} else echo json_encode(array('error' => 'Something bad happened!'));

?>