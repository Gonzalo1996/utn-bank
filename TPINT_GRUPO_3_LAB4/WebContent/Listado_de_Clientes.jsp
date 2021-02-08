<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Cuentas" %>
<%@ page import="entidad.Cliente" %>
<%@ page import="negocio.CuentasNegocio" %>
<%@ page import="negocioImpl.CuentasNegocioImpl" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <!-- DATATABLES -->
    <!--  <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"> -->
    
    <!-- BOOTSTRAP -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css">
    
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<title>Seleccionar Cliente</title>
<link href="css/seleccionar-Cliente.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>

</head>
<body>

	<!-- Barra de Titulo -->

	<nav class="navbar navbar-light" style="background-color: #FFA500;">
	  	<span class="navbar-brand mb-0 h1">
	  		<img src="imagenes/UTN_BANC_2.png" width="300" height="50" alt="" loading="lazy"> BANCO DE LA UTN - LABORATORIO IV</span>
	  	<!-- Aquí se configuraría para poner el nombre del Usuario Logueado -->Nombre Administrador
	</nav>

<a href="Crear_Cuenta.jsp">REGRESAR</a>
	
<!-- Titulo del JSP -->	
	<h1 style="margin-left:35%;  color: white; font-weight:bold;margin-top:2%">SELECCIONAR CLIENTE ACTIVO</h1>

<%
	CuentasNegocio cNeg = new CuentasNegocioImpl();										//Creo Objeto CuentaNegocio
	ArrayList<Cliente> listaClientes = (ArrayList<Cliente>)cNeg.traerClientes();
%>
	
	<br>

<div id="tablita">
	<table id="tablax" class="display">
	<thead>
		<tr>
			<th>DNI</th>
			<th>CUIL</th>
			<th>Nombre</th>
			<th>Apellido</th>
			<th></th>
		</tr>
	</thead>
	<tbody>	
	<% if(listaClientes!=null)
	{
		for(Cliente c:listaClientes)
		{%>
		<tr>
		<form action="Crear_Cuenta.jsp" method="post">
			<td><%=c.getDNI()%>      <input type="hidden" name="nroDni" value="<%=c.getDNI()%>"> </td>
			<td><%=c.getCUIL()%>     <input type="hidden" name="nroCUIL" value="<%=c.getCUIL()%>"> </td>
			<td><%=c.getNombre()%>   <input type="hidden" name="nombre" value="<%=c.getNombre()%>"></td>
			<td><%=c.getApellido()%> <input type="hidden" name="apellido" value="<%=c.getApellido()%>"></td>
			<td><input type="submit" name="btnSeleccionar" value="Seleccionar"></td>
		</form>
		</tr>
		<%} 
	}%>
	</tbody>
	</table>
</div>

 <!-- JQUERY -->
    <script src="https://code.jquery.com/jquery-3.4.1.js"
        integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
        </script>
    <!-- DATATABLES -->
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js">
    </script>
    <!-- BOOTSTRAP -->
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js">
    </script>
    <script>
        $(document).ready(function () {
            $('#tablax').DataTable({
                language: {
                    processing: "Tratamiento en curso...",
                    search: "Buscar&nbsp;:",
                    lengthMenu: "Agrupar de _MENU_ items",
                    info: "Mostrando del item _START_ al _END_ de un total de _TOTAL_ items",
                    infoEmpty: "No existen datos.",
                    infoFiltered: "(filtrado de _MAX_ elementos en total)",
                    infoPostFix: "",
                    loadingRecords: "Cargando...",
                    zeroRecords: "No se encontraron datos con tu busqueda",
                    emptyTable: "No hay datos disponibles en la tabla.",
                    paginate: {
                        first: "Primero",
                        previous: "Anterior",
                        next: "Siguiente",
                        last: "Ultimo"
                    },
                    aria: {
                        sortAscending: ": active para ordenar la columna en orden ascendente",
                        sortDescending: ": active para ordenar la columna en orden descendente"
                    }
                },
                scrollY: 500,
                lengthMenu: [ [10, 5, 15, -1], [10, 5, 15, "Todos"] ],
            });
        });
    </script>
    
</body>
</html>