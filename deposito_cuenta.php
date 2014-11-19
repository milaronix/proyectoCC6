<?php
include("/db/conexioni.php");
session_start();
	$usuario = 'root';
	$contra = '';
	$bd = 'proyecto_cc5';
	$con = mysql_connect('127.0.0.1', $usuario, $contra);


$Qtc = "select saldo, idCliente from cuentas where numeroDeCuenta =  $_POST[cuenta]";
$resultado = mysql_query($Qtc);
$saldo = mysql_fetch_array($resultado);

$query = "update cuentas set saldo = " . ($saldo['saldo'] + $_POST['monto']) . " where numeroDeCuenta = $_POST[cuenta]";
mysql_query($query);
$noautorizacion = mysql_insert_id();

$queryTRX = "insert into cc6.transacciones (numeroDeCuenta, idCliente, tipoTransaccion, concepto, fechaTransaccion, monto, hora) values ('$_POST[cuenta]', '$saldo[idCliente]', 'D', 'DEPOSITO DESDE OTRO BANCO POR Q$_POST[monto]', curdate(), '$_POST[monto]', curtime())";
mysql_query($queryTRX);

$cobro_response = array(
	'exitoso' => 's', 
);

$jsoncobroresponse = json_encode($cobro_response);
echo($jsoncobroresponse);


include("/db/conexionf.php");
?>