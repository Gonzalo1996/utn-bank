<%@page import="daoImpl.ClienteDAOlmpl"%>
<%@page import="dao.ClienteDAO"%>
<%@page import="negocioImpl.ClienteNegocioImpl"%>
<%@page import="negocio.ClienteNegocio"%>
<%@page import="entidad.Cliente"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<title>UTN BANC - Laboratorio IV</title>
    <style type="text/css">
    <jsp:include page="css/estilo-fondo.css"></jsp:include>
	</style>
	
</head>
<body>

<%
	Cliente c = (Cliente)session.getAttribute("cliente");
	
	//ClienteNegocio cNeg = new ClienteNegocioImpl();
	ClienteDAO cNeg = new ClienteDAOlmpl();
	String dni = Integer.toString(c.getDNI());
	float total = cNeg.totalCuentas(dni);
	
	
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
	<jsp:include page="MasterPage_USUARIO.jsp"></jsp:include>
	<br>
	<div id="general">
		<br>
		<h1 id="titulo">Bienvenido a UTN BANK</h1>
		<br>
		<p id="nombre">&nbsp;Nombre:
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<em><%=c.getNombre()%></em>
		</p>
		<br>
		<p id="nombre">&nbsp;Apellido:
			&nbsp;&nbsp;&nbsp;
			<em><%=c.getApellido()%></em>
		</p>
		<br>
		<p id="nombre">&nbsp;DNI:
			&nbsp;&nbsp;&nbsp;
			<em><%=c.getDNI()%></em>
		</p>		
		<br>
		<p id="montoTotal">&nbsp;Su Monto Total es:
			&nbsp;&nbsp;&nbsp;
<%if(total!=0){ %>
		<em>$ <%=total%></em>
<%}
else{ %>
		<em>Usted no posee Cuentas</em>
<%}%>
		</p>
		<br><br><br>
		
		<p id="textoFinal"> Trabajo Práctico Integrador - Laboratorio IV - Grupo 3</p>
	</div>
</body>
</html>