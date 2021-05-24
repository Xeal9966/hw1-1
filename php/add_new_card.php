<?php
if (session_status()<2) session_start();

if (isset($_SESSION['id']) && isset($_SESSION['logged']) && $_SESSION['logged']== 'true'){
    function completed_number($ccnumber, $length) {
        # generate digits
        while ( strlen($ccnumber) < ($length - 1) ) {
            $ccnumber .= rand(0,9);
        }
        # Calculate sum
        $sum = 0;
        $pos = 0;
        $reversedCCnumber = strrev( $ccnumber );
        while ( $pos < $length - 1 ) {
            $odd = $reversedCCnumber[ $pos ] * 2;
            if ( $odd > 9 ) {
                $odd -= 9;
            }
            $sum += $odd;
            if ( $pos != ($length - 2) ) {
                $sum += $reversedCCnumber[ $pos +1 ];
            }
            $pos += 2;
        }
        # Calculate check digit
        $checkdigit = (( floor($sum/10) + 1) * 10 - $sum) % 10;
        $ccnumber .= $checkdigit;
        return $ccnumber;
    }

    //check if user is pro, if not check that it has less than 3 debit cards


    require_once 'dbconnect.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());
    $cf = $_SESSION['id'];

    $query = "SELECT Type FROM Account WHERE Account_ID = (SELECT Account_ID FROM Subscription where CF  = '".$cf."')";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };  
    $r = mysqli_fetch_assoc($res);
    if ($r['Type'] != 'Pro'){
        //count debit cards
        $query = "SELECT Count(*) as count FROM Card c WHERE Card_ID = (SELECT ID FROM Card_Type WHERE Type = 'Debit') AND c.Account_ID = (SELECT Account_ID FROM Subscription where CF  = '".$cf."')";
        $res = mysqli_query($conn, $query);
        if (!$res) {
            echo json_encode(mysqli_error($conn));
            mysqli_close($conn);
            exit;
        };  
        $r = mysqli_fetch_assoc($res);
        if ($r['count'] >= 3){
            echo json_encode(array('Error' => 'User has already three cards'));
            mysqli_close($conn);
            exit;
        }
    }
    

    //get bancomat balance
    $query = "SELECT Balance, Number FROM Card c WHERE Card_ID = (SELECT ID FROM Card_Type WHERE Type = 'Bancomat') AND c.Account_ID = (SELECT Account_ID FROM Subscription where CF  = '".$cf."')";
    $res = mysqli_query($conn, $query);
    if (!$res) {
        echo json_encode(mysqli_error($conn));
        mysqli_close($conn);
        exit;
    };    
    $r = mysqli_fetch_assoc($res);
    $bancomat_balance = $r["Balance"];
    $bancomat_num = $r['Number'];
    

    //get user inserted amount
    $val = mysqli_real_escape_string($conn, $_POST['Value']);
    if ($val >  $bancomat_balance || $val > 1500 || !is_numeric($val)){
        echo json_encode(array('Error' => 'Insert a valid value!'));
        mysqli_close($conn);
        exit;
    }
    else {
        //generate a new card
        do {
            $f = true;
            $cc = completed_number('400311', 16);
            //check if this number exists
            $query = "SELECT Count(*) as count FROM Card c WHERE Number = '".$cc."'";
            $res = mysqli_query($conn, $query);
            $r = mysqli_fetch_assoc($res);
            if ($r['count'] == 0) $f = false;
        } while ($f);

        $month = sprintf("%02d", rand(01, 12));
        $year = rand(23, 26);
        $cvv = sprintf("%03d", rand(001, 999));
        $pin = sprintf("%04d", rand(0001, 9999));

        //get account id
        $query = "SELECT Account_ID FROM Subscription where CF  = '".$cf."'";
        $res = mysqli_query($conn, $query);
        if (!$res) {
            echo json_encode(mysqli_error($conn));
            mysqli_close($conn);
            exit;
        };    
        $r = mysqli_fetch_assoc($res);
        $acc_id = $r["Account_ID"];
        
        //Insert into db
        $today = date("Y-m-d");
        $query = "INSERT INTO `Card` (`Status`, `Number`, `Month`, `Year`, `CVV`, `PIN`, `Balance`, `Payment_Date`, `Card_ID`, `Account_ID`, `ActivationDate`, `Favorite`) 
        VALUES ('Active', '$cc', '$month', '$year', '$cvv', '$pin', '$val', NULL, '4', '$acc_id', '$today', '0')";
        $res = mysqli_query($conn, $query);
        if (!$res) {
            echo json_encode(mysqli_error($conn));
            mysqli_close($conn);
            exit;
        };    

        //Remove the balance from Bancomat
        $new_balance =  $bancomat_balance - $val;
        $query = "UPDATE Card SET Balance = '".$new_balance."' WHERE Number = '".$bancomat_num."'";
        $res = mysqli_query($conn, $query);
        if (!$res) {
            echo json_encode(mysqli_error($conn));
            mysqli_close($conn);
            exit;
        };   

        echo json_encode(array('Number' => $cc , 'Month' => $month,'Year' => $year, 'Type' =>'Debit', 'Vendor' => 'Visa',  'CVV' => $cvv, 'Pin' => $pin));
        mysqli_close($conn);
        exit;
    }

} else echo json_encode(array('error' => 'Something bad happened!'));


?>