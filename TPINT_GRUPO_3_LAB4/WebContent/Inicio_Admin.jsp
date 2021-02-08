<%@page import="entidad.Cliente"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page session = "true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<title>Inicio</title>
    <style type="text/css">
	<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>
	 
</head>
<body>

<%
	Cliente c = (Cliente)session.getAttribute("cliente");

	/*String usuario="";
	String tipoUsu="";
	
	if(sesion.getAttribute("user") != null && 
	   sesion.getAttribute("tipo") != null)
	{
		usuario = sesion.getAttribute("user").toString();
		tipoUsu = sesion.getAttribute("tipo").toString();
		//out.print("<a href='servletSeguro?cerrar=true'>"<h5></a>");
	}*/
%>
	

<!-- Barra Título -->
	<jsp:include page="MasterPage_ADMINISTRADOR.jsp"></jsp:include>
<!-- 
<div>
	<span class="d-block p-3 bg-dark text-white bienvenido-admin">Bienvenido Admin</span>
</div>
-->

<div class="jumbotron jumbotron-fluid bg-dark text-white" style="height: 60px; ">
  <div class="container">
    <h1 class="display-5">Bienvenido Administrador</h1>
  </div>
</div>


<video autoplay="autoplay" loop="loop">
	<source src="videos/LOGO UTN BANK.mp4" type="video/mp4">
</video>

<!--  <div class="card-deck div-tarjeta">
  <div class="card">
    <div class="card-body" style="background-color: #FFA500;">
      <h3 class="card-title" style="text-align: center;">Datos Admin</h3>
      <p class="card-text">Nombre:</p>
      <p class="card-text">Apellido:</p>
      <p class="card-text">DNI:</p>
    </div>
  </div>
  <div class="card">
    <div class="card-body" style="background-color: #FFA500;">
    <div>
      <h3 class="card-title" style="text-align: center;">Datos Admin</h3>
    </div>
      <p class="card-text">Otro dato:</p>
      <p class="card-text">Otro dato:</p>
      <p class="card-text">Otro dato:</p>
    </div>
  </div>
</div>


<div>
	<div>Cuadro Izquierda</div>
	<div>Cuadro Derecha</div>
</div>
-->

</body>
</html>