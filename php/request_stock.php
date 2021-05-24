<?php
if (session_status()<2) session_start();

if (isset($_SESSION['id']) && isset($_SESSION['logged']) && $_SESSION['logged']== 'true'){

    $symbols = ['AAPL', 'MSFT','NKE', 'SBUX'];
    $response = array();
    foreach($symbols as $sym ){
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, "https://cloud.iexapis.com/stable/stock/".$sym."/quote?token=pk_9bceca2c95c04eee8febdc0b538c89a6");
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $result = curl_exec($curl);
        curl_close($curl);
        $var = json_decode($result, true);
        array_push($response, $var);
    }
    echo json_encode($response);
    

} else echo json_encode(array('error' => 'Something bad happened!'));

?>

