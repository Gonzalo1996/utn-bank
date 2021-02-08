<%@page import="java.util.Objects"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Cliente" %>
<%@ page import="negocio.ClienteNegocio" %>
<%@ page import="negocioImpl.ClienteNegocioImpl" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- BOOTSTRAP -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css">
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<link href="css/estilo-vercuentas.css" rel="stylesheet" type="text/css"/>
<title>Clientes</title>
    <style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>
</head>
<body>

<!-- Barra Título -->
	<jsp:include page="MasterPage_ADMINISTRADOR.jsp"></jsp:include>
	<h1 style="position: absolute; top: 15%; left: 50%; color: white;margin-top:-2%">LISTA DE CLIENTES</h1>
	
	
<% 
	ArrayList<Cliente> listaClientes = null;
	if(request.getAttribute("listaClientes")!=null) 									//Si el Atributo creado desde el Servlet es distinto de nulo 
	{
		listaClientes = (ArrayList<Cliente>) request.getAttribute("listaClientes");		//Copio al ArrayList
	}
	else																		//Si es falso
	{
			//Esto ocurrirá la primera vez que entre al JSP, luego siempre irá por el IF
		ClienteNegocio cCli = new ClienteNegocioImpl();
		listaClientes = (ArrayList<Cliente>) cCli.traerClientes();		//Busco y copio todos los Registros
	}
%>	
	

<div id="tablita" class="display" style="margin-top: 5%;">
	<table id="tablax">
	  <thead>
	    <tr>
	      <th>Nombres</th>
	      <th>Apellido</th>
	      <th>Dni</th>
	      <th>Cuil</th>
	      <th>Fecha Nac.</th>
	      <th>Sexo</th>
	      <th>Nacinalidad</th>
	      <th>Dirección</th>
	      <th>Localidad</th>
	      <th>Provincia</th>
	      <th>Email</th>
	      <th>Usuario</th>
	      <th>Contraseña</th>
	      <th>Estado</th>
	      <th>Acciones</th>

	    </tr>
	  </thead>
	  <tbody>
	   
	     <% 
	    
	     if(listaClientes!=null){
			for(Cliente cli:listaClientes)
			{
				
			%>
				<tr> 
				<form action="servletClientes" method="post">
				<td><%=cli.getNombre()%></td> <input type="hidden" name="nombreCliente" value="<%=cli.getNombre()%>"> </td> 	
				<td><%=cli.getApellido()%></td> <input type="hidden" name="apellidoCliente" value="<%=cli.getApellido()%>"> </td> 
				<td><%=cli.getDNI()%> <input type="hidden" name="dniCliente" value="<%=cli.getDNI()%>"> </td> 
				<td><%=cli.getCUIL()%></td> <input type="hidden" name="cuilCliente" value="<%=cli.getCUIL()%>"> </td> 
				<td><%=cli.getFecha()%></td> <input type="hidden" name="fechaCliente" value="<%=cli.getFecha()%>"> </td> 
				<td><%=cli.getSexo()%></td><input type="hidden" name="sexoCliente" value="<%=cli.getSexo()%>"> </td> 
				<td><%=cli.getNacionalidad()%></td><input type="hidden" name="nacionalidadCliente" value="<%=cli.getNacionalidad()%>"> </td> 
				<td><%=cli.getDireccion()%></td><input type="hidden" name="direccionCliente" value="<%=cli.getDireccion()%>"> </td> 
				<td><%=cli.getLocalidad()%></td><input type="hidden" name="localidadCliente" value="<%=cli.getLocalidad()%>"> </td> 
				<td><%=cli.getProvincia()%></td><input type="hidden" name="provinciaCliente" value="<%=cli.getProvincia()%>"> </td> 
				<td><%=cli.getMail()%></td><input type="hidden" name="mailCliente" value="<%=cli.getMail()%>"> </td> 
				<td><%=cli.getUserName()%></td><input type="hidden" name="userCliente" value="<%=cli.getUserName()%>"> </td> 
				<td><%=cli.getPass()%></td> <input type="hidden" name="passCliente" value="<%=cli.getPass()%>"> </td> 
				<td><%=cli.getEstado()%></td>
				
				<td>
				<div style="display: flex; justify-content: center;">
					<button type="submit" name="btnEliminar" style="border:none;"><img src="imagenes/bloquear.png" width="75" height="45"></button>&nbsp;
					<button type="submit" name="btnRestaurar" style="border:none;"><img src="imagenes/desbloquear.png" width="75" height="45"></button>&nbsp;
					<button type="submit" name="btnModificar" style="border:none;"><img src="imagenes/modificar.png" width="75" height="45"></button>
				</div>
				</td>
				
				<!--
					<td><input type="submit"  name="btnModificar" value="Modificar"></td>
					<td><input type="submit" name="btnEliminar" value="Eliminar"></td>
					<td><input type="submit" name="btnRestaurar" value="Restaurar"></td>
				-->
				
				</form>
				</tr> 
		  <% }
	} %>
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
                scrollY: 630,
                lengthMenu: [ [10, 5, 15, -1], [10, 5, 15, "Todos"] ],
            });
        });
    </script>
    
<%
	boolean filas = false;

	if(request.getAttribute("isModified")!=null) {filas = (boolean)request.getAttribute("isModified");}
	if(filas == true)
	{%>
			<script type="text/javascript">
  				alert("Se modificó Cliente.");
			</script>
	<%}
%>    
    
</body>
</html>