<?php
  
if(isset($_COOKIE['r_mail'])){
    if(isset($_POST['cf']) && isset($_POST['r-password']) && isset($_POST['c-password']) && isset($_POST['name']) && isset($_POST['surname']) && isset($_POST['phone']) && isset($_POST['residence']) && isset($_POST['type']) && isset($_POST['dob'])) {
        $mail = $_COOKIE['r_mail'];
        require_once 'dbconnect.php';
        $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());
        $cf =  strtoupper(mysqli_real_escape_string($conn, $_POST['cf']));
        $type = mysqli_real_escape_string($conn, $_POST['type']);
        $CF_FILTER = '/^[a-z]{6}[0-9]{2}[a-z][0-9]{2}[a-z][0-9]{3}[a-z]$/i';

        

        if (!preg_match($CF_FILTER, $cf)){
            $response['cf'] = 'CF is not valid!';
        } else {
            $query = "SELECT * FROM User WHERE CF = '".$cf."'";
            $res = mysqli_query($conn, $query);
            if (!$res){ 
                echo json_encode(mysqli_error($conn));
                exit;
            }
            
    
            if (mysqli_num_rows($res) > 0) $response['cf'] = 'CF is already registered!';
            mysqli_free_result($res);
        }
      
        //get password 
        $r_password =mysqli_real_escape_string($conn, $_POST['r-password']);
        if (preg_match('/^(?=.*[!@#$%^&*.-])(?=.*[0-9])(?=.*[A-Z]).{8,20}$/', $r_password)){
            //get confirmation password
            $c_password =mysqli_real_escape_string($conn, $_POST['c-password']);
        if (strcmp($r_password, $c_password) == 0) {
                //calculate password for storing into db
                $pass = password_hash($r_password, PASSWORD_BCRYPT);
            } else $response['c-password'] ='Passwords do not match!';
        } else $response['r-password'] ='Password is not strong enough!';
        
        //get name and surname
        $name =mysqli_real_escape_string($conn, $_POST['name']);
        $name = ucfirst(strtolower($name));
        $surname =mysqli_real_escape_string($conn, $_POST['surname']);
        $surname = ucfirst(strtolower($surname));
        if (!ctype_alpha(str_replace(array(' ', "'", '-'), '', $name))) $response['name'] ='Only letters are allowed!';
        if (!ctype_alpha(str_replace(array(' ', "'", '-'), '', $surname))) $response['surname'] ='Only letters are allowed!';

        //get phone number
        $phone = mysqli_real_escape_string($conn, $_POST['phone']);
        $phone = preg_replace('/\s+/', "", $phone);
        if (!ctype_digit($phone)) $response['phone'] ='Insert a valid phone number!';

        //get residence
        $residence = mysqli_real_escape_string($conn, $_POST['residence']);
        if (!ctype_alpha(str_replace(array(' ', "'", '-'), '', $residence))) $response['residence'] ='Only letters are allowed!';

        $dob = mysqli_real_escape_string($conn, $_POST['dob']);
        if (!preg_match("/^(0[1-9]|[1-2][0-9]|3[0-1])-(0[1-9]|1[0-2])-[0-9]{4}$/",$dob)) $response['dob'] = 'Insert a valid date!';
        $type = mysqli_real_escape_string($conn, $_POST['type']);

        if (empty($response)){ 
            $today = date("Y-m-d");
            if ($type == 'Pro')
            $fee = 7.50;
            else $fee = 3.50;
            

            $query = "INSERT INTO `User` (`CF`, `Email`, `Name`, `Surname`, `Residence`, `Phone`, `Passwd`, `Dob`) VALUES ('$cf', '$mail', '$name', '$surname', '$residence', '$phone', '$pass', STR_TO_DATE('$dob','%d-%m-%Y'))";
            $res = mysqli_query($conn, $query);
            if (!$res){ 
                echo json_encode(mysqli_error($conn));
                exit;
            }
            
            $query = "INSERT INTO `Account` (`Fee`, `Type`) VALUES ('$fee','$type')";
            $res = mysqli_query($conn, $query);
            if (!$res){ 
                echo json_encode(mysqli_error($conn));
                exit;
            }
            $account_id = mysqli_insert_id($conn);
            
            $query = "INSERT INTO `Subscription` (`CF`, `Account_ID`, `StartDate`) VALUES ('$cf','$account_id', '$today')";
            $res = mysqli_query($conn, $query);
            if (!$res){ 
                echo json_encode(mysqli_error($conn));
                exit;
            }
            echo json_encode(array('success' => 'User has been registered successfully'));
            setcookie('r-mail', '',  time()-1000, '/');
        }
        else echo json_encode($response);
        mysqli_close($conn);
        exit;

    } else echo json_encode(array('error' => true, 'response' => "Something is missing"));

} else echo json_encode(array('error' => true, 'response' => "You should not be here"));

?>