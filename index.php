<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Contact Us</title>
</head>
<body>
<h1>Contact Us</h1>

<form method="post">
	<label>Enter Name</label>
	<input type="text" name="name"> <br>
	<label>Enter Email</label>
	<input type="email" name="email"> <br>

	<label>Enter Message</label>
	<input type="text" name="message"> <br>

	<input type="submit" name="send" value="Send Message">
</form>

<?php 
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require('PHPMailer/Exception.php');
require('PHPMailer/SMTP.php');
require('PHPMailer/PHPMailer.php');

if(isset($_POST['send'])){
$name=$_POST['name'];
$email=$_POST['email'];
$message=$_POST['message'];

$mail = new PHPMailer(true);

try {
    //Server settings
    // $mail->SMTPDebug = SMTP::DEBUG_SERVER;              
            //Enable verbose debug output
    $mail->isSMTP();                                            //Send using SMTP
    $mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
    $mail->Username   = 'deepakmaholi422@gmail.com';                     //SMTP username
    $mail->Password   = 'Verma2002';                               //SMTP password
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
    $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

    //Recipients
    $mail->setFrom('deepakmaholi422@gmail.com', 'Deepak G Techno');
    $mail->addAddress('deepakmaholi422@gmail.com');     //Add a recipient
    // $mail->addAddress('ellen@example.com');               //Name is optional
    
    //Content
    $mail->isHTML(true);                                  //Set email format to HTML
    $mail->Subject = 'Deepak G Techno';
    $mail->Body    = "<table border='1' width='100%' cellspacing='0' cellpadding='5'>
<tr><th>Name</th> <td>$name</td></tr>
<tr><th>Email</th> <td>$email</td></tr>
<tr><th>Message</th> <td>$message</td></tr>
    </table>";

    $mail->send();
    echo "<script>alert('Mail has been send successfully..');</script>";
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}

}
?>
</body>
</html>