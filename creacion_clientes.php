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

function validateDate($date, $format = 'Y-m-d H:i:s'){
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
				$_POST['nombre'] = trim(strtoupper(reemGuion($_POST['nombre'])));
				$_POST['nit'] = trim(strtoupper(reemGuion($_POST['nit'])));
				$_POST['dpi'] = trim(strtoupper($_POST['dpi']));
				$_POST['genero'] = trim(strtoupper($_POST['genero']));
				$_POST['fnacimiento'] = trim(date_format(date_create($_POST['fnacimiento']), 'Y/m/d'));
				$_POST['email'] = trim(strtoupper($_POST['email']));				
				$_POST['tel1'] = trim(strtoupper($_POST['tel1']));
				$_POST['tel2'] = trim(strtoupper($_POST['tel2']));				
				$_POST['nomenclatura'] = trim(strtoupper($_POST['nomenclatura']));
				$_POST['zona'] = trim(strtoupper($_POST['zona']));
				$_POST['colonia'] = trim(strtoupper($_POST['colonia']));
				$_POST['municipio'] = trim(strtoupper(reemGuion($_POST['municipio'])));
				$_POST['departamento'] = trim(strtoupper(reemGuion($_POST['departamento'])));
			}
			
			if(isset($_POST['enviado'])){
				if($_POST['enviado'] == 1){
					if($_POST['nombre'] == ''){
						$errNombreCliente = 1;
						$error = 1;
					}
					if($_POST['nit'] == ''){
						$err_fregistro = 1;
						$error = 1;
					}
					if($_POST['dpi'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					if($_POST['genero'] == ''){
						$err_razonSocial = 1;
						$error = 1;
					}
					
					if($_POST['fnacimiento'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					
					if($_POST['email'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					
					if($_POST['tel1'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					
					if($_POST['tel2'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					
					if($_POST['nomenclatura'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					
					if($_POST['zona'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					
					if($_POST['colonia'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					
					if($_POST['municipio'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					
					if($_POST['departamento'] == ''){
						$err_nombrecomercial = 1;
						$error = 1;
					}
					
					/*if(isset($_POST['nombreRepresentante'])){
						if(alfanum($_POST['nombreRepresentante']) == 0){ 
							$err_nombreRepresentante = 1;
							$error = 1;
						}
					*/
					if($error == 0){
						$query = "INSERT INTO cc6.clientes (nombreCliente, fechaNacimiento, genero, nomenclaturaDireccion, zona, colonia, departamento, municipio, telefono1, telefono2, nit, dpi, email)
						  values('$_POST[nombre]','$_POST[fnacimiento]','$_POST[genero]','$_POST[nomenclatura]', '$_POST[zona]', '$_POST[colonia]', '$_POST[departamento]', '$_POST[municipio]', '$_POST[tel1]', '$_POST[tel2]', '$_POST[nit]', '$_POST[dpi]', '$_POST[email]')";
						$result = mysql_query($query);
						if(mysql_errno($con) > 0){
							$err_msg = "<center>ERROR: " . mysql_errno($con) . " - - - " . mysql_error($con);
							$error = 1;
						}else{
							$query_exitoso = 1;
						}
					}
				}
			}
			
			?>
			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-edit"></i> Formulario creacion de clientes </h2>
					</div>
					<div class="box-content">
						<form class="form-horizontal" method = 'post' action='creacion_clientes.php'>
							<fieldset>
								<?php
								if($error == 1){
									echo("
									<div class='alert alert-error'>
										<center>");
									if(mysql_errno($con) > 0){
										if(mysql_errno($con) == 1062){
											//echo("Este NIT ya fue ingresado al sistema, por favor verifique para no duplicar información");
											echo($err_msg);
										}else{
											echo($err_msg);
										}
									}else{
										echo("<p><strong>Datos inválidos</strong>, por favor verifique e intente de nuevo.</p>");
									}
									echo("
										</center>
									</div>
									");
								}else{
									if($query_exitoso == 1){
										echo("
									<div class='alert alert-success'>
										<center>
											<p>La información del cliente se ha guardado exitosamente.</p>
										</center>
									</div>
									");
									}else{
										echo("
										<div class='alert alert-block '>
											<center>
												<p> Todos los campos son obligatorios, por favor ingresarlos, antes de hacer click en el botón de 'Guardar'.</p>
											</center>
										</div>
										");
									}
								}
								?>
								
								<div class="alert alert-info">
									<center>
										<label>Datos Demograficos</label>
									</center>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['nombre'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Nombre: </label>
									<div class="controls">
										<input class="input-xlarge focused" name='nombre' type="text" <?php if(isset($_POST['nombre'])){echo("value = '" . $_POST['nombre'] . "'");} ?>>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['nit'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">NIT: </label>
									<div class="controls">
										<input class="input-xlarge focused" name='nit' type="text" <?php if(isset($_POST['nit'])){echo("value = '" . $_POST['nit'] . "'");} ?>>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['dpi'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">DPI: </label>
									<div class="controls">
										<input class="input-xlarge focused" name='dpi' type="text" <?php if(isset($_POST['dpi'])){echo("value = '" . $_POST['dpi'] . "'");} ?>>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['genero'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Genero: </label>
									<div class="controls">
										<input class="input-xlarge focused" name='genero' type="text" <?php if(isset($_POST['genero'])){echo("value = '" . $_POST['genero'] . "'");} ?>>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['fnacimiento'] == ''){ echo("error");} ?>">
									<label class="control-label" for="fnacimiento">Fecha de Nacimiento:</label>
									<div class="controls">
										<input type="text" class="input-xlarge datepicker" name="fnacimiento" <?php if(isset($_POST['fnacimiento'])){echo("value = '" . $_POST['fnacimiento'] . "'");} ?>>										
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
										<input class="input-xlarge focused" name='email' type="text" <?php if(isset($_POST['email'])){echo("value = '" . $_POST['email'] . "'");} ?>>
									</div>
								</div>								
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['tel1'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Telefono Fijo: </label>
									<div class="controls">
										<input class="input-xlarge focused" name='tel1' type="text" <?php if(isset($_POST['tel1'])){echo("value = '" . $_POST['tel1'] . "'");} ?>>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['tel2'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Telefono Móvil: </label>
									<div class="controls">
										<input class="input-xlarge focused" name='tel2' type="text" <?php if(isset($_POST['tel2'])){echo("value = '" . $_POST['tel2'] . "'");} ?>>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['nomenclatura'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Nomenclatura direccion: </label>
									<div class="controls">
										<input class="input-xlarge focused" name='nomenclatura' type="text" <?php if(isset($_POST['nomenclatura'])){echo("value = '" . $_POST['nomenclatura'] . "'");} ?>>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['zona'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Zona direccion: </label>
									<div class="controls">
										<input class="input-xlarge focused" name='zona' type="text" <?php if(isset($_POST['zona'])){echo("value = '" . $_POST['zona'] . "'");} ?>>
									</div>
								</div>
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['colonia'] == ''){ echo("error");} ?>">
									<label class="control-label" for="focusedInput">Colonia direccion: </label>
									<div class="controls">
										<input class="input-xlarge focused" name='colonia' type="text" <?php if(isset($_POST['colonia'])){echo("value = '" . $_POST['colonia'] . "'");} ?>>
									</div>
								</div>
								
								
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['municipio'] == ''){ echo("error");} ?>">
									<label class="control-label" for="municipio">Municipio:</label>
									<div class="controls">
										<select id="municipio" name='municipio' data-rel="chosen" <?php if(isset($_POST['municipio'])){echo("value = '" . $_POST['municipio'] . "'");} ?>>
											<?php
											$query = 'select *  from municipios';
											$resultado = mysql_query($query);
											while($items = mysql_fetch_array($resultado)){
												echo("<option value='$items[idMunicipio]'");
												if(isset($_POST['enviado'])){if($_POST['municipio'] == $items['idMunicipio']){echo(" selected ");};}
												echo(">$items[descripcion]</option>");
											}
											?>
										</select>
									</div>
								 </div>
								
								
								
								<div class="control-group <?php if($_POST['enviado'] == 1 && $_POST['departamento'] == ''){ echo("error");} ?>">
									<label class="control-label" for="departamento">Departamento:</label>
									<div class="controls">
										<select id="departamento" name='departamento' data-rel="chosen" <?php if(isset($_POST['departamento'])){echo("value = '" . $_POST['departamento'] . "'");} ?>>
											<?php
											$query = 'select *  from departamentos';
											$resultado = mysql_query($query);
											while($items = mysql_fetch_array($resultado)){
												echo("<option value='$items[idDepartamento]'");
												if(isset($_POST['enviado'])){if($_POST['departamento'] == $items['idDepartamento']){echo(" selected ");};}
												echo(">$items[descripcion]</option>");
											}
											?>
										</select>
									</div>
								 </div>
																
								<input type='hidden' name='enviado' value='1'>
							  
								<div class="form-actions">
								<center>
									<button type="submit" class="btn btn-primary">Guardar</button>
									<button class="btn">Cancelar</button>
								</center>
								</div>
							</fieldset>
						  </form>
					</div>
				</div><!--/span-->
			</div><!--/row-->
				
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