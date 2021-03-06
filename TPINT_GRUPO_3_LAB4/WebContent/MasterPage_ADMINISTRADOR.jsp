<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page session = "true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Master</title>
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">	
    <style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>
</head>
<body>

	<!-- Barra de Titulo -->

	<nav class="navbar navbar-light" style="background-color: #FFA500;">
	  	<span class="navbar-brand mb-0 h1">
	  		<img src="imagenes/UTN_BANC_2.png" width="300" height="50" alt="" loading="lazy"> BANCO DE LA UTN - LABORATORIO IV</span>
	  	<!-- Aqu� se configurar�a para poner el nombre del Usuario Logueado -->Hola, Administrador
	</nav>
	<form action="servletLogin" method="post">
		<ul class="ul-master"> <!-- class="nav flex-column" NO VA-->
  		<li class="nav-item">
    		<a class="nav-link" href="Inicio_Admin.jsp">Inicio</a>
  		</li>
  		<h4>Clientes</h4>
  		<li class="nav-item">
    		<a class="nav-link" href="Agregar_Cliente.jsp">Agregar Cliente</a>
  		</li>
  		<li class="nav-item">
    		<a class="nav-link" href="Clientes.jsp">Clientes</a>
  		</li>
  		<h4>Cuentas</h4>
  		<li class="nav-item">
    		<a class="nav-link" href="Crear_Cuenta.jsp">Crear Cuenta</a>
  		</li>
   		<li class="nav-item">
    		<a class="nav-link" href="Ver_Cuentas.jsp">Ver Cuentas</a>
  		</li>
  		<h4>Prestamos</h4>
  		<li class="nav-item">
    		<a class="nav-link" href="Prestamos.jsp">Ver Pr�stamos</a>
  		</li>
   		<li class="nav-item">
    		<a class="nav-link" href="Informes_Estadisticas.jsp">Informe/Estad�sticas</a>
  		</li>
  

   		<li class="nav-item">
    		<a class="nav-link" href="IngresoUsuario.jsp?cerrar=true">Cerrar Sesi�n</a>
  		</li>
		</ul>
	</form>
  	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
  	
</body>
</html>