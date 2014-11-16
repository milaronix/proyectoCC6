<?php
include("/db/conexioni.php");
session_start();
$_SESSION['tiempo_expira'] = 1800; //10 minutos
?>

<!DOCTYPE html>
<html lang="es">
<head>
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
	<div class="container-fluid">
		<div class="row-fluid">
		
			<div class="row-fluid">
				<div class="span12 center login-header">
					<h2>Bienvenido a Asistencia Digital</h2>
				</div><!--/span-->
			</div><!--/row-->
			
			<div class="row-fluid">
				<div class="well span5 center login-box">
			
				<?PHP
					if(isset($_POST['clave']) && $_POST['clave'] != ''){
						$sql = "select usuarios.idUsuario, usuarios.contrasenia, tipoUsuario.leer, tipoUsuario.crear, tipoUsuario.modificar, tipoUsuario.eliminar
								from usuarios, tipoUsuario
								where idUsuario = '" . $_POST["usuario"] . "'
								AND usuarios.tipoUsuario = tipoUsuario.idTipoUsuario"; 						
						$result = mysql_query($sql);
						if (false === $result) {
							echo mysql_error();
						}
						$resultado = mysql_fetch_array($result);
						if($resultado["contrasenia"] == $_POST["clave"]){
							$_SESSION['usuario'] = $resultado['idUsuario'];
							$_SESSION['clave'] = $resultado['contrasenia'];
							$_SESSION['leer'] = $resultado["leer"];
							$_SESSION['crear'] = $resultado["crear"];
							$_SESSION['modificar'] = $resultado["modificar"];
							$_SESSION['eliminar'] = $resultado["eliminar"];
							$_SESSION['UltimoMovimiento'] = time();
							echo('<div class=	"alert alert-info">
									Bienvenido '. $resultado['idUsuario'] . '
								  </div>');
							echo("<META HTTP-EQUIV='REFRESH' CONTENT='3;URL=inicio.php'>");
						}else{
							echo('<div class="alert alert-info">
									Usuario o contrase&ntildea incorrecto
								  </div>');
							echo("<META HTTP-EQUIV='REFRESH' CONTENT='3;URL=index.php'>");
						}
					}else{
					//echo('no esta seteada la contraseña');
				?>

					<div class="alert alert-info">
						Por favor ingrese sus datos, para iniciar sesion.
					</div>
					<form class="form-horizontal" action="index.php" method="post">
						<fieldset>
							<div class="input-prepend" title="Usuario" data-rel="tooltip">
								<span class="add-on"><i class="icon-user"></i></span><input autofocus class="input-large span10" name="usuario" id="usuario" type="text" placeholder="usuario" />
							</div>
							<div class="clearfix"></div>

							<div class="input-prepend" title="Clave" data-rel="tooltip">
								<span class="add-on"><i class="icon-lock"></i></span><input class="input-large span10" name="clave" id="clave" type="password" placeholder="clave" />
							</div>
							<div class="clearfix"></div>

							<p class="center span5">
							<button type="submit" class="btn btn-primary">Ingresar</button>
							</p>
						</fieldset>
					</form>
				</div><!--/span-->
			</div><!--/row-->
		</div><!--/fluid-row-->
		
	</div><!--/.fluid-container-->	
</body>
</html>
				<?PHP
					
					}
					include("/db/conexionf.php");
				?>