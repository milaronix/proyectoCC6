<?php
session_start();
$tipo_uso = $_GET['tipo']
?>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="utf-8">
	<title>milaronix CRM</title>
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
<?php
if($tipo_uso == 1){
	session_destroy();
	?>
	<body>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12 center login-header">
						<h2>CERRAR SESION</h2>
					</div><!--/span-->
				</div><!--/row-->
				<div class="well span5 center login-box">
					<div class="alert alert-info">Su sesion se ha cerrado exitosamente.</div>
					<META HTTP-EQUIV='REFRESH' CONTENT='3;URL=index.php'>
				</div><!--/span-->
			</div><!--/row-->
		</div><!--/fluid-row-->
	</body>
	<?php
}
if($tipo_uso == 2){
	?>
	<body>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12 center login-header">
						<h2>SESION EXPIRADA</h2>
					</div><!--/span-->
				</div><!--/row-->
				<div class="well span5 center login-box">
					<div class="alert alert-info">Su sesion ha expirado, ingrese de nuevo por favor.</div>
					<META HTTP-EQUIV='REFRESH' CONTENT='3;URL=index.php'>
				</div><!--/span-->
			</div><!--/row-->
		</div><!--/fluid-row-->
	</body>
	<?php
}
if($tipo_uso == 3){
	?>
	<body>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12 center login-header">
						<h2>INGRESO INCORRECTO</h2>
					</div><!--/span-->
				</div><!--/row-->
				<div class="well span5 center login-box">
					<div class="alert alert-info">Por favor inicie sesion, para ingresar al sistema.</div>
					<META HTTP-EQUIV='REFRESH' CONTENT='3;URL=index.php'>
				</div><!--/span-->
			</div><!--/row-->
		</div><!--/fluid-row-->
	</body>
	<?php
}
?>

</html>
