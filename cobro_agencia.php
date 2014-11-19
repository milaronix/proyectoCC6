<?php
include("/db/conexioni.php");
session_start();
	$usuario = 'root';
	$contra = '';
	$bd = 'proyecto_cc5';
	$con = mysql_connect('127.0.0.1', $usuario, $contra);
//$inactivo = 600; //10 minutos
$error = 0;
$query_exitoso = 0;




//verifico cuenta cobro es mia
//si es mia opero cobro
//si no es mia no hago nada

if(isset($_POST['cliente_tarjeta']) && !empty($_POST['cliente_tarjeta'])){
	if((substr($_POST['cliente_tarjeta'],0,1) == '4') && (substr($_POST['agencia_cuenta'],0,1) == '4') && (substr($_POST['proveedor_cuenta'],0,1) == '4')){
		$Qtc = "select numeroDeCuenta from cuentas where numeroDeCuenta =  $_POST[cliente_tarjeta]";
		$resultado = mysql_query($Qtc);
		$ctaCliente = mysql_num_rows($resultado);

		$Qtc = "select numeroDeCuenta from cuentas where numeroDeCuenta =  $_POST[agencia_cuenta]";
		$resultado = mysql_query($Qtc);
		$ctaAgencia = mysql_num_rows($resultado);

		$Qtc = "select numeroDeCuenta from cuentas where numeroDeCuenta =  $_POST[proveedor_cuenta]";
		$resultado = mysql_query($Qtc);
		$ctaProveedor = mysql_num_rows($resultado);

		if(($ctaCliente > 0) && ($ctaProveedor > 0) && ($ctaAgencia > 0)){
			$Qsaldo = "select idCliente, saldo from cuentas where numeroDeCuenta =  $_POST[cliente_tarjeta]";
			$resultado = mysql_query($Qsaldo);
			$saldo = mysql_fetch_array($resultado);
			if(($saldo['saldo'] > 0) && ($saldo['saldo'] > $_POST['cliente_monto'])){
				$Qcobro = "update cuentas set saldo = " . ($saldo['saldo'] - $_POST['cliente_monto']) . " where cuentas.numeroDeCuenta = $_POST[cliente_tarjeta]";
				mysql_query($Qcobro);
				if(mysql_errno($con) > 0){
					//DEVUELVE ERROR EN LA TRANSACCION - ERROR DE BASE DE DATOS EN COBRO
					//echo("DEVUELVE ERROR EN LA TRANSACCION - ERROR DE BASE DE DATOS EN COBRO");
									$cobro_response = array(
										'codigo_reservacion' => $_POST['codigo_reservacion'], 
										'status' => 'denegada',
										'no_autorizacion' => 0,
										'mensaje' => 'ERROR DE BASE DE DATOS EN COBRO'
									);

									$jsoncobroresponse = json_encode($cobro_response);
									echo($jsoncobroresponse);
				}else{
					$queryTRX = "insert into transacciones (numeroDeCuenta, idCliente, tipoTransaccion, concepto, fechaTransaccion, monto, hora) values ('$_POST[cliente_tarjeta]', '$saldo[idCliente]', 'C', 'CONSUMO - RESERVA $_POST[codigo_reservacion] - POR Q$_POST[cliente_monto]', curdate(), '$_POST[cliente_monto]', curtime())";
					mysql_query($queryTRX);
					$noautorizacion = mysql_insert_id();
					if(substr($_POST['agencia_cuenta'],0,1) == '4'){
						//HACE EL DEPOSITO A LA AGENCIA
						//echo("HACE EL DEPOSITO A LA AGENCIA");
						$Qsaldo = "select idCliente, saldo from cuentas where numeroDeCuenta =  $_POST[agencia_cuenta]";
						$resultado = mysql_query($Qsaldo);
						$saldoAgencia = mysql_fetch_array($resultado);
						$Qdeposito = "update cuentas set saldo = " . ($saldoAgencia['saldo'] + $_POST['agencia_monto']) . " where cuentas.numeroDeCuenta = $_POST[agencia_cuenta]";
						mysql_query($Qdeposito);
						if(mysql_errno($con) > 0){
							//ERROR EN EL DEPOSITO A LA AGENCIA
							//echo("ERROR EN EL DEPOSITO A LA AGENCIA");
							$cobro_response = array(
								'codigo_reservacion' => $_POST['codigo_reservacion'], 
								'status' => 'denegada',
								'no_autorizacion' => 0,
								'mensaje' => 'ERROR EN EL DEPOSITO A LA AGENCIA'
							);

							$jsoncobroresponse = json_encode($cobro_response);
							echo($jsoncobroresponse);
						}else{
							$queryTRX = "insert into transacciones (numeroDeCuenta, idCliente, tipoTransaccion, concepto, fechaTransaccion, monto, hora) values ('$_POST[agencia_cuenta]', '$saldoAgencia[idCliente]', 'D', 'DEPOSITO - RESERVA $_POST[codigo_reservacion] - POR Q$_POST[agencia_monto]', curdate(), '$_POST[agencia_monto]', curtime())";
							mysql_query($queryTRX);
							if(substr($_POST['proveedor_cuenta'],0,1) == '4'){
								//HACE EL DEPOSITO AL PROVEEDOR
								//echo("HACE EL DEPOSITO AL PROVEEDOR");
								$Qsaldo = "select idCliente, saldo from cuentas where numeroDeCuenta =  $_POST[proveedor_cuenta]";
								$resultado = mysql_query($Qsaldo);
								$saldoProveedor = mysql_fetch_array($resultado);
								$Qdeposito = "update cuentas set saldo = " . ($saldoProveedor['saldo'] + $_POST['proveedor_monto']) . " where cuentas.numeroDeCuenta = $_POST[proveedor_cuenta]";
								mysql_query($Qdeposito);
								if(mysql_errno($con) > 0){
									//ERROR EN EL DEPOSITO AL PROVEEDOR
									//echo("ERROR EN EL DEPOSITO AL PROVEEDOR");
									$cobro_response = array(
										'codigo_reservacion' => $_POST['codigo_reservacion'], 
										'status' => 'denegada',
										'no_autorizacion' => 0,
										'mensaje' => 'ERROR EN EL DEPOSITO AL PROVEEDOR'
									);

									$jsoncobroresponse = json_encode($cobro_response);
									echo($jsoncobroresponse);
								}else{
									$queryTRX = "insert into transacciones (numeroDeCuenta, idCliente, tipoTransaccion, concepto, fechaTransaccion, monto, hora) values ('$_POST[proveedor_cuenta]', '$saldoProveedor[idCliente]', 'D', 'DEPOSITO - RESERVA $_POST[codigo_reservacion] - POR Q$_POST[proveedor_monto]', curdate(), '$_POST[proveedor_monto]', curtime())";
									mysql_query($queryTRX);
									$queryAUTO = "select autorizacion from transacciones where ";
									//LA TRANSACCION FUE EXITOSA 
									//echo("LA TRANSACCION FUE EXITOSA - AUTORIZACION = " . $noautorizacion);
									
									$cobro_response = array(
										'codigo_reservacion' => $_POST['codigo_reservacion'], 
										'status' => 'aceptada',
										'no_autorizacion' => $noautorizacion,
										'mensaje' => 'LA OPERACION CONCLUYO EXITOSAMENTE'
									);

									$jsoncobroresponse = json_encode($cobro_response);
									echo($jsoncobroresponse);

								}
							}else{
								//MANDA A DEPOSITAR AL PROVEEDOR EN OTRO BANCO
								//echo("MANDA A DEPOSITAR AL PROVEEDOR EN OTRO BANCO");
							}
							
						}
					}else{
						//MANDA A DEPOSITAR A LA AGENCIA EN OTRO BANCO
						//echo("MANDA A DEPOSITAR A LA AGENCIA EN OTRO BANCO");
					}
					
				}

			}else{
				//DEVUELVE ERROR EN LA TRANSACCION - SALDO INSUFICIENTE
				//echo("DEVUELVE ERROR EN LA TRANSACCION - SALDO INSUFICIENTE");
				$cobro_response = array(
					'codigo_reservacion' => $_POST['codigo_reservacion'], 
					'status' => 'denegada',
					'no_autorizacion' => 0,
					'mensaje' => 'SALDO INSUFICIENTE'
				);

				$jsoncobroresponse = json_encode($cobro_response);
				echo($jsoncobroresponse);
			}
		}else{
			//DEVUELVE ERROR EN LA TRANSACCION - CUENTA NO EXISTE
			//echo("DEVUELVE ERROR EN LA TRANSACCION - CUENTA NO EXISTE");
			$cobro_response = array(
				'codigo_reservacion' => $_POST['codigo_reservacion'], 
				'status' => 'denegada',
				'no_autorizacion' => 0,
				'mensaje' => 'ALGUNA DE LAS CUENTAS NO EXISTE EN EL SISTEMA'
			);

			$jsoncobroresponse = json_encode($cobro_response);
			echo($jsoncobroresponse);
		}
	}else{
		//CUENTA DEL CLIENTE ES DE OTRO BANCO - NO SE HACE NADA
		//echo("CUENTA DEL CLIENTE ES DE OTRO BANCO - NO SE HACE NADA");
		$cobro_response = array(
			'codigo_reservacion' => $_POST['codigo_reservacion'], 
			'status' => 'denegada',
			'no_autorizacion' => 0,
			'mensaje' => 'ALGUNA DE LAS CUENTAS ES DE OTRO BANCO O NO ES VALIDA'
		);

		$jsoncobroresponse = json_encode($cobro_response);
		echo($jsoncobroresponse);
	}
}else{
	echo("NO SETEADO EL POST");
	echo "<pre>";
	var_dump($_POST);
	echo "</pre>";
}

//verifico cuenta deposito es mia
//si es mia deposito
//si no es mia la mando al otro banco
?>


<?PHP
include("/db/conexionf.php");
?>