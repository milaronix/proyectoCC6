<?PHP
	$usuario = 'root';
	$contra = '';
	$bd = 'cc6';
	$con = mysql_connect('127.0.0.1', $usuario, $contra);
	if(!$con){
		die('no pudo conectar'.mysql_error());
	}
	mysql_select_db("cc6",$con);
?>