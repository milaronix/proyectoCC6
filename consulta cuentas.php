<?php
include("/db/conexioni.php");
session_start();
	$usuario = 'root';
	$contra = '';
	$bd = 'proyecto_cc5';
	$con = mysql_connect('127.0.0.1', $usuario, $contra);
//$inactivo = 600; //10 minutos
$tiempo_expira = time() - $_SESSION['UltimoMovimiento'];
$error = 0;
$query_exitoso = 0;
$ctatrx = 0;
if(isset($_GET['id'])){
$id = $_GET['id'];
}
if(isset($_GET['ctatrx'])){
$ctatrx = $_GET['ctatrx'];
}

function reemGuion($cadena) {
	$patron = '/-/';
	$reemplazo = "";
	return preg_replace($patron, $reemplazo, $cadena);
	//return (preg_match($patron, $cadena));
}

function alfanum($cadena) {
	$patron = "/^[a-zA-Z0-9]+(\s*\.*\&*\-*\/*[a-zA-Z0-9]*)*([a-zA-Z0-9]|\.)+$/";
	$reemplazo = "";
	//return preg_replace($patron, $reemplazo, $cadena);
	//echo("el codigo devuelto es:" . preg_match($patron, $cadena));
	return (preg_match($patron, $cadena));
}

function esfecha($cadena) {
	$patron = "|[1-31]\/[1-12]\/[1900-3000]|";
	$reemplazo = "";
	//return preg_replace($patron, $reemplazo, $cadena);
	//echo("el codigo devuelto es:" . preg_match($patron, $cadena));
	return (preg_match($patron, $cadena));
}

function validateDate($date, $format = 'Y-m-d H:i:s')
{
    $d = DateTime::createFromFormat($format, $date);
    return $d && $d->format($format) == $date;
}

function tieneError($cadena){
return alfanum($_POST[$cadena]);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<!--
		Charisma v1.0.0

		Copyright 2012 Muhammad Usman
		Licensed under the Apache License v2.0
		http://www.apache.org/licenses/LICENSE-2.0

		http://usman.it
		http://twitter.com/halalit_usman
	-->
	<meta charset="utf-8">
	<title>Asistencia Digital</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="milaronix CRM, ayudando a manejar una mejor relacion con sus clientes.">
	<meta name="author" content="milaronix">

	<!-- The styles -->
	<link id="bs-css" href="css/bootstrap-cerulean.css" rel="stylesheet">
	<style type="text/css">
	  body {
		padding-bottom: 40px;
	  }
	  .sidebar-nav {
		padding: 9px 0;
	  }
	</style>
	<link href="css/bootstrap-responsive.css" rel="stylesheet">
	<link href="css/charisma-app.css" rel="stylesheet">
	<link href="css/jquery-ui-1.8.21.custom.css" rel="stylesheet">
	<link href='css/fullcalendar.css' rel='stylesheet'>
	<link href='css/fullcalendar.print.css' rel='stylesheet'  media='print'>
	<link href='css/chosen.css' rel='stylesheet'>
	<link href='css/uniform.default.css' rel='stylesheet'>
	<link href='css/colorbox.css' rel='stylesheet'>
	<link href='css/jquery.cleditor.css' rel='stylesheet'>
	<link href='css/jquery.noty.css' rel='stylesheet'>
	<link href='css/noty_theme_default.css' rel='stylesheet'>
	<link href='css/elfinder.min.css' rel='stylesheet'>
	<link href='css/elfinder.theme.css' rel='stylesheet'>
	<link href='css/jquery.iphone.toggle.css' rel='stylesheet'>
	<link href='css/opa-icons.css' rel='stylesheet'>
	<link href='css/uploadify.css' rel='stylesheet'>

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

	<!-- The fav icon -->
	<link rel="shortcut icon" href="img/favicon.ico">
		
</head>

<body>

<?php
	if(!isset($_SESSION['UltimoMovimiento'])){
		session_destroy(); header("Location: expirada.php?tipo=3");
	}
	else{
		if($tiempo_expira > $_SESSION['tiempo_expira']){
			header("Location: expirada.php?tipo=2");
		}else{
?>

	<!-- topbar starts -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".top-nav.nav-collapse,.sidebar-nav.nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<a class="brand" href="inicio.php"> <img alt="Charisma Logo" src="images/logo.jpg" /> <span>Egeo</span></a>
				
				<!-- user dropdown starts -->
				<div class="btn-group pull-right" >
					<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
						<i class="icon-user"></i><span class="hidden-phone"> <?php echo($_SESSION['usuario']); ?></span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="expirada.php?tipo=1">Salir</a></li>
					</ul>
				</div>
				<!-- user dropdown ends -->
			</div>
		</div>
	</div>
	<!-- topbar ends -->
	<div class="container-fluid">
		<div class="row-fluid">
				
			<!-- left menu starts -->
			<div class="span2 main-menu-span">
				<div class="well nav-collapse sidebar-nav">
					<ul class="nav nav-tabs nav-stacked main-menu">
						<li class="nav-header hidden-tablet">Administración</li>
						<li><a class="ajax-link" href="inicio.php"><i class="icon-home"></i><span class="hidden-tablet"> Inicio</span></a></li>
						<li class="nav-header hidden-tablet">Clientes</li>
						<?php 
						if ($_SESSION['leer'] == 1){
						echo("<li><a class='ajax-link' href='consulta clientes.php'><i class='icon-eye-open'></i><span class='hidden-tablet'> Consulta Clientes</span></a></li>");
						}
						if ($_SESSION['modificar'] == 1){
						echo("<li><a class='ajax-link' href='modificacion clientes.php'><i class='icon-edit'></i><span class='hidden-tablet'> Modificación Clientes</span></a></li>");
						}
						if ($_SESSION['crear'] == 1){
						echo("<li><a class='ajax-link' href='creacion_clientes.php'><i class='icon-plus-sign'></i><span class='hidden-tablet'> Creacion Clientes</span></a></li>");
						}
						?>
						<li class="nav-header hidden-tablet">Cuentas</li>
						<?php 
						if ($_SESSION['leer'] == 1){
						echo("<li><a class='ajax-link' href='cliente para consulta cuenta.php'><i class='icon-eye-open'></i><span class='hidden-tablet'> Consulta Cuentas</span></a></li>");
						}
						if ($_SESSION['crear'] == 1){
						echo("<li><a class='ajax-link' href='cliente para cuenta.php'><i class='icon-plus-sign'></i><span class='hidden-tablet'> Creacion Cuentas</span></a></li>");
						}
						if ($_SESSION['crear'] == 1){
						echo("<li><a class='ajax-link' href='cliente para deposito.php'><i class='icon-download-alt'></i><span class='hidden-tablet'> Depósito a cuenta</span></a></li>");
						}
						?>
					</ul>
				</div><!--/.well -->
			</div><!--/span-->
			<!-- left menu ends -->
			
			<noscript>
				<div class="alert alert-block span10">
					<h4 class="alert-heading">Warning!</h4>
					<p>You need to have <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a> enabled to use this site.</p>
				</div>
			</noscript>
			
			<div id="content" class="span10">
			
			<!-- content starts -->
			<?php
			
			if(isset($_POST['enviado'])){
				if($error == 0){
					$query ="select correlativo+1 as corre from bin where bin = $_POST[bin]";
					//echo("Q1 = ".$query."<br>");
					$correlativo = mysql_query($query);
					$correlativo = mysql_fetch_array($correlativo);
					//echo("correlativo = ".$correlativo['corre']."<br>");
					$cuenta = ($_POST['bin'] + $correlativo['corre']);
					$cuenta = number_format($cuenta,0,".","");
					//echo("cuenta = ".(string)$cuenta."<br>");
					$query ="update cc6.bin set correlativo = $correlativo[corre] where bin = $_POST[bin]";
					mysql_query($query);
					//echo("Q3 = ".$query."<br>");
					$query = "INSERT INTO cc6.cuentas (numeroDeCuenta, idCliente, fechaApertura, saldo, bin)
							values('$cuenta','$_POST[id]',CURDATE(),'0.00','$_POST[bin]')";
					//echo("Q2 = ".$query);
					$result = mysql_query($query);
					if(mysql_errno($con) > 0){
						$err_msg = "<center>ERROR: " . mysql_errno($con) . " - - - " . mysql_error($con);
						$error = 1;
					}else{
						$query_exitoso = 1;
					}
				}
			}
			
			if($query_exitoso == 1){
				echo("
					<div class='alert alert-success'>
						<center>
							<p>La cuenta se ha creado exitosamente.</p>
						</center>
					</div>
					");
			}else{
			
			?>
			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-edit"></i> Formulario creacion de cuentas </h2>
					</div>
					<div class="box-content">						
							
						<form class="form-horizontal" method = 'post' action='<?php $_SERVER['PHP_SELF'] ?>'>
							<fieldset>
								
								<?php
								if($error == 0){
									$query = "select clientes.*, departamentos.descripcion as depto, municipios.descripcion as muni, numeroDeCuenta, fechaApertura, saldo, bin.descripcion from clientes, departamentos, municipios, cuentas, bin where clientes.idCliente = '$id' and clientes.departamento = departamentos.iddepartamento and clientes.municipio = municipios.idMunicipio and cuentas.idCliente = clientes.idCliente and cuentas.bin = bin.bin";
									//echo("Q1 = " . $query . "<br>");
									$result = mysql_query($query);
									//echo("Q2 = " . $result . "<br>");
									if(mysql_errno($con) > 0){
										$err_msg = "<center>ERROR: " . mysql_errno($con) . " - - - " . mysql_error($con);
										$error = 1;
									}else{
										//$items = mysql_fetch_array($result);
									}
								}
								
								if($ctatrx > 0){
									?>
										<table class="table table-bordered table-striped table-condensed">
											<thead>
												<tr>
													<th>Autorizacion</th>
													<th>Numero de Cuenta</th>
													<th>Tipo de Transaccion</th>
													<th>Concepto</th>																					  
													<th>Fecha Transaccion</th>
													<th>Hora</th>
													<th>Monto</th>
												</tr>
											</thead>   
											<tbody>
												<tr>
													<?php
													$queryTRX = "select * from transacciones where numeroDeCuenta = $ctatrx";
													//echo("Q1 = " . $queryTRX);
													$resultado = mysql_query($queryTRX);
													while($transacciones = mysql_fetch_array($resultado)){
														echo("<tr>");
														echo("<td>$transacciones[autorizacion]</td>");
														echo("<td>$transacciones[numeroDeCuenta]</td>");
														echo("<td>$transacciones[tipoTransaccion]</td>");
														echo("<td>$transacciones[concepto]</td>");
														echo("<td>$transacciones[fechaTransaccion]</td>");
														echo("<td>$transacciones[hora]</td>");
														echo("<td class='center'>" . number_format($transacciones['monto'],2,".",",") . "</td>");
														echo("</tr>");
													}
													$result = mysql_query($query);
													$items = mysql_fetch_array($result);
													?>
																							
												</tr>
										</table>
									<?php
								}
								?>
								
								<div class="alert alert-info">
									<center>
										<label>Cuentas Asociadas</label>
									</center>
								</div>
								
								<table class="table table-bordered table-striped table-condensed">
									<thead>
										<tr>
											<th>Cuenta</th>
											<th>Producto</th>
											<th>Fecha Apertura</th>
											<th>Saldo</th>																					  
											<th>Consulta Bitacora</th>																					  
										</tr>
									</thead>   
									<tbody>
										<tr>
											<?php
											while($items = mysql_fetch_array($result)){
												echo("<tr>");
												echo("<td>$items[numeroDeCuenta]</td>");
												echo("<td class='center'>$items[descripcion]</td>");
												echo("<td class='center'>$items[fechaApertura]</td>");
												echo("<td class='center'>" . number_format($items['saldo'],2,".",",") . "</td>");
												echo("<td class='center'><a class='btn btn-success' href='$_SERVER[PHP_SELF]?ctatrx=$items[numeroDeCuenta]&id=$id'> Transacciones </a> </td>");
												echo("<input type='hidden' name='transacciones' value='1'>");
												echo("</tr>");
											}
											$result = mysql_query($query);
											$items = mysql_fetch_array($result);
											?>
																					
										</tr>
								</table>
								
								<div class="alert alert-info">
									<center>
										<label>Datos Demograficos</label>
									</center>
								</div>							
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['nombre'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Nombre: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['nombreCliente']); ?></span>
									</div>					
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['nit'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">NIT: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['nit']); ?></span>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['dpi'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">DPI: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['dpi']); ?></span>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['genero'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Genero: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['genero']); ?></span>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['fnacimiento'] == ''){ echo("error");} ?>">
									<label class="control-label" for="fnacimiento">Fecha de Nacimiento:</label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['fechaNacimiento']); ?></span>
									</div>
								</div>
								
								<div class="alert alert-info">
									<center>
										<label>Datos de Contacto</label>
									</center>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['email'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">e-mail: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['email']); ?></span>
									</div>
								</div>								
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['tel1'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Telefono Fijo: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['telefono1']); ?></span>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['tel2'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Telefono Móvil: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['telefono2']); ?></span>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['nomenclatura'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Nomenclatura direccion: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['nomenclaturaDireccion']); ?></span>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['zona'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Zona direccion: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['zona']); ?></span>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['colonia'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Colonia direccion: </label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['colonia']); ?></span>
									</div>
								</div>
								
								
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['municipio'] == ''){ echo("error");} ?>">
									<label class="control-label" for="municipio">Municipio:</label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['muni']); ?></span>
									</div>
								 </div>
								
								
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['bin'] == ''){ echo("error");} ?>">
									<label class="control-label" for="bin">Departamento:</label>
									<div class="controls">
									  <span class="input-xlarge uneditable-input"><?php echo($items['depto']); ?></span>
									</div>
								 </div>												
							  
							</fieldset>
						  </form>
					</div>
				</div><!--/span-->
			</div><!--/row-->
			<?php }?>
			<!-- content ends -->
			</div><!--/#content.span10-->
				</div><!--/fluid-row-->
				
		<hr>

		<div class="modal hide fade" id="myModal">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>Settings</h3>
			</div>
			<div class="modal-body">
				<p>Here settings can be configured...</p>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Close</a>
				<a href="#" class="btn btn-primary">Save changes</a>
			</div>
		</div>

		<footer>
			<p class="pull-left">&copy; <a href="http://usman.it" target="_blank">Asistencia Digital</a> 2014</p>
			<p class="pull-right">Elaborado por: <a href="http://usman.it/free-responsive-admin-template">milaronix</a></p>
		</footer>
		
	</div><!--/.fluid-container-->

<?php	
		}
		$_SESSION['UltimoMovimiento'] = time();
	}
?>
	

	<!-- external javascript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->

	<!-- jQuery -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<!-- jQuery UI -->
	<script src="js/jquery-ui-1.8.21.custom.min.js"></script>
	<!-- transition / effect library -->
	<script src="js/bootstrap-transition.js"></script>
	<!-- alert enhancer library -->
	<script src="js/bootstrap-alert.js"></script>
	<!-- modal / dialog library -->
	<script src="js/bootstrap-modal.js"></script>
	<!-- custom dropdown library -->
	<script src="js/bootstrap-dropdown.js"></script>
	<!-- scrolspy library -->
	<script src="js/bootstrap-scrollspy.js"></script>
	<!-- library for creating tabs -->
	<script src="js/bootstrap-tab.js"></script>
	<!-- library for advanced tooltip -->
	<script src="js/bootstrap-tooltip.js"></script>
	<!-- popover effect library -->
	<script src="js/bootstrap-popover.js"></script>
	<!-- button enhancer library -->
	<script src="js/bootstrap-button.js"></script>
	<!-- accordion library (optional, not used in demo) -->
	<script src="js/bootstrap-collapse.js"></script>
	<!-- carousel slideshow library (optional, not used in demo) -->
	<script src="js/bootstrap-carousel.js"></script>
	<!-- autocomplete library -->
	<script src="js/bootstrap-typeahead.js"></script>
	<!-- tour library -->
	<script src="js/bootstrap-tour.js"></script>
	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>
	<!-- calander plugin -->
	<script src='js/fullcalendar.min.js'></script>
	<!-- data table plugin -->
	<script src='js/jquery.dataTables.min.js'></script>

	<!-- chart libraries start -->
	<script src="js/excanvas.js"></script>
	<script src="js/jquery.flot.min.js"></script>
	<script src="js/jquery.flot.pie.min.js"></script>
	<script src="js/jquery.flot.stack.js"></script>
	<script src="js/jquery.flot.resize.min.js"></script>
	<!-- chart libraries end -->

	<!-- select or dropdown enhancer -->
	<script src="js/jquery.chosen.min.js"></script>
	<!-- checkbox, radio, and file input styler -->
	<script src="js/jquery.uniform.min.js"></script>
	<!-- plugin for gallery image view -->
	<script src="js/jquery.colorbox.min.js"></script>
	<!-- rich text editor library -->
	<script src="js/jquery.cleditor.min.js"></script>
	<!-- notification plugin -->
	<script src="js/jquery.noty.js"></script>
	<!-- file manager library -->
	<script src="js/jquery.elfinder.min.js"></script>
	<!-- star rating plugin -->
	<script src="js/jquery.raty.min.js"></script>
	<!-- for iOS style toggle switch -->
	<script src="js/jquery.iphone.toggle.js"></script>
	<!-- autogrowing textarea plugin -->
	<script src="js/jquery.autogrow-textarea.js"></script>
	<!-- multiple file upload plugin -->
	<script src="js/jquery.uploadify-3.1.min.js"></script>
	<!-- history.js for cross-browser state change on ajax -->
	<script src="js/jquery.history.js"></script>
	<!-- application script for Charisma demo -->
	<script src="js/charisma.js"></script>
	
		
</body>
</html>

<?PHP
	include("/db/conexionf.php");
?>