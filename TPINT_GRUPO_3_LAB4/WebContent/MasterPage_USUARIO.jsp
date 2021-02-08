<%@page import="entidad.Cliente"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">	
</head>
<body>

<%
	Cliente c = (Cliente)session.getAttribute("cliente");
%>

	<!-- Barra de Titulo -->

<nav class="navbar navbar-light" style="background-color: #FCE553;">
  <span class="navbar-brand mb-0 h1">
  	<img src="imagenes/UTN_BANC_2.png" width="300" height="50" alt="" loading="lazy"> BANCO DE LA UTN - LABORATORIO IV</span>
  	<!-- Aquí se configuraría para poner el nombre del Usuario Logueado -->Hola, <%=c.getNombre()%> <%=c.getApellido()%>
</nav>

	<!-- Menú de la Página -->

<div style="background-color: #f2e381">
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" style="background-color: #F5F104" href="Inicio_Usuario.jsp">Inicio</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" style="background-color: #F5F104"href="Caja-de-Ahorro.jsp">Caja de Ahorro</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" style="background-color: #F5F104"href="Cuenta-Corriente.jsp">Cuenta Corriente</a>
  </li>
    <li class="nav-item">
    <a class="nav-link active" style="background-color: #F5F104"href="Transferencia-Propia.jsp">Transferencias Propias</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" style="background-color: #F5F104"href="Transferencia-Otras-Cuentas.jsp">Transferencias a otras Cuentas</a>
  </li>
    <li class="nav-item">
    <a class="nav-link active" style="background-color: #F5F104"href="Solicitud-Prestamo.jsp">Solicitud de Préstamo</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" style="background-color: #F5F104"href="Consulta_Pago-Prestamos.jsp">Consulta/Pago Préstamos</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="servletCerrarSesion?Param=1">Cerrar Sesión</a>
  </li>
</ul>
</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>

</body>
</html>