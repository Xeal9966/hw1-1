<?php 
    if(session_status() != 2) session_start();
    if (isset($_GET['em'])){
        require_once 'dbconnect.php';
        $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error());
        $email = mysqli_real_escape_string($conn, $_GET['em']);
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)){
            $response = array(
                "error" => 'true',
                "response" => 'Insert a valid email!'
            );
            echo json_encode($response);
            mysqli_close($conn);
            exit;
        }

        $query = "SELECT * FROM User WHERE Email = '".$email."'";
        $res = mysqli_query($conn, $query);
        if (!$res){ 
            echo json_encode(mysqli_error($conn));
            exit;
        }

        if (mysqli_num_rows($res) > 0){
            echo json_encode(array(
                "error" => true, 
                "response" => "Email already exists!"
            ));
        } else {
            setcookie("r_mail", $email, time()+3600, '/'); 
            echo json_encode(array(
                "error" => false,
                "mail" => $email
            ));
        }
        
     
        mysqli_free_result($res);
        mysqli_close($conn);
        exit;
    } else {
        echo json_encode(array(
                         "error" => true, 
                         "response" => 'Nothing was received!' 
                         ));
    }
 ?>
 