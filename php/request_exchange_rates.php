<?php 
if (session_status()<2) session_start();

if (isset($_SESSION['id']) && isset($_SESSION['logged']) && $_SESSION['logged']== 'true'){
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, "https://api.coinbase.com/v2/exchange-rates?currency=EUR");
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $result = curl_exec($curl);
    curl_close($curl);
    $var = json_decode($result, true);
    $var = $var['data']['rates'];
    $response['EUR'] = array('USD' => round($var['USD'],3) , 'GBP' => round( $var['GBP'],3));

    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL,"https://api.coinbase.com/v2/exchange-rates?currency=USD");
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $result = curl_exec($curl);
    curl_close($curl);
    $var = json_decode($result, true);
    $var = $var['data']['rates'];
    $response['USD'] = array('GPB' => round($var['GBP'], 3)  , 'JPY' => round($var['JPY'], 3));

    
    echo json_encode($response);

} else echo json_encode(array('error' => 'Something bad happened!'));

?>