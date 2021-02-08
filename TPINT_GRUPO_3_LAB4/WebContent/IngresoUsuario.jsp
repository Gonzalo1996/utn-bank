<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<link href="css/IniciarSesion.css" rel="stylesheet" type="text/css"/>
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
</head>
<body>

<section id="pantalla-dividida">
	<div class="izquierda">
	</div>
	<div class="derecha">
		
		
		<div class="logo-utn">
		<img src="imagenes/UTN_BANC_2.png" style="width: 300px; height: 50px">
		</div>
		
		<h2>BANCO DE LA UTN - LABORATORIO IV</h2>
		
		<div id="cuadro">
			<form action="servletLogin" method="post">
				<p id="titulo">INICIAR SESIÓN</p>
				<hr>
				<br/>
				<h4 id="subtitulo1">NOMBRE DE USUARIO</h4>
				<br/>
				<input type="text" class="entrada" placeholder="INGRESE USUARIO"  autocomplete="off" name="txtUsuario"/>
				<br/><br/>
				<h4 id="subtitulo2">CONTRASEÑA</h4>
				<br/>
				<input type="password" class="entrada" placeholder="INGRESE CONTRASEÑA"  name="txtPass"/>
				<br/><br/>
			
				<input type="submit" name="btnIngresar" value="Iniciar sesion" id="boton"/>
			</form>
			<br/>
			<p id="marca">Proyecto Lab4</p>
		</div>
	</div>
</section>

<%
	boolean login = false;

	if(request.getAttribute("isLogin")!=null) {login = (boolean)request.getAttribute("isLogin");}
	
	if(login == true)
	{%>
			<script type="text/javascript">
  				alert("No existe Usuario");
			</script>
	<%}
%>

<%
	boolean bloqueado = false;

	if(request.getAttribute("isBloqueado")!=null) {bloqueado = (boolean)request.getAttribute("isBloqueado");}
	
	if(bloqueado == true)
	{%>
			<script type="text/javascript">
  				alert("El Usuario ha sido dado de baja");
			</script>
	<%}
%>

</body>
</html>