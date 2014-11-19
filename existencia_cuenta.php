<?php
include("/db/conexioni.php");
session_start();
	$usuario = 'root';
	$contra = '';
	$bd = 'proyecto_cc5';
	$con = mysql_connect('127.0.0.1', $usuario, $contra);


$Qtc = "select numeroDeCuenta from cuentas where numeroDeCuenta =  $_POST[cuenta_verificar]";
$resultado = mysql_query($Qtc);
$ctaVerifica = mysql_num_rows($resultado);

if($ctaVerifica > 0){
	$cobro_response = array(
		'existe' => 's', 
	);

	$jsoncobroresponse = json_encode($cobro_response);
	echo($jsoncobroresponse);
}else{
	$cobro_response = array(
		'existe' => 'n', 
	);

	$jsoncobroresponse = json_encode($cobro_response);
	echo($jsoncobroresponse);
}


include("/db/conexionf.php");
?>



