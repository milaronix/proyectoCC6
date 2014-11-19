<?php
include("jorge.php");

$string="cuenta_verificar=45326000009";
$respuesta = request('http://172.20.10.5/proyecto/servicios/existencia_cuenta.php',TRUE,$string,FALSE);
echo($respuesta);
?>
