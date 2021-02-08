<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Cuentas" %>
<%@ page import="entidad.TipoCuenta" %>
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
<title>Ver Cuentas</title>
<link href="css/estilo-vercuentas.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>

</head>
<body>

<!-- Barra Título -->
	<jsp:include page="MasterPage_ADMINISTRADOR.jsp"></jsp:include>
	
<!-- Titulo del JSP -->	
	<h1 style="margin-left:50%;  color: white; font-weight:bold;margin-top:2%">CUENTAS</h1>

<%
	CuentasNegocio cNeg = new CuentasNegocioImpl();										//Creo Objeto CuentaNegocio
%>

<form action="servletCuentas" method="post">	

		<div  id="filtros">
		<h4 style="color:white;">Filtrar por: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Buscar por DNI:</h4>
		<select id="tipoCuentas" name="tipoCuentas">
			    <% 
						ArrayList<TipoCuenta> listaTipos = (ArrayList<TipoCuenta>)cNeg.traerTiposCuentas(); 
												
						if(listaTipos!=null)																	
							for(TipoCuenta tipo:listaTipos){ %>												  
							<option value="<%=tipo.getIdTipo()%>"><%=tipo.getDescripcion()%></option>		  
				<%}%>
		</select>
		<input type="submit" value="Filtrar" name="btnFiltrar">	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="text" class="textbox" autocomplete="off" name="txtDNI" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" maxlength="8">
			<input type="submit" value="Buscar" name="btnBuscar">
		&nbsp;&nbsp;
			<input type="submit" value="Mostrar Todo" name="btnMostrarTodo">
		</div>
		
		
</form>		
	
<% 
	ArrayList<Cuentas> listaCuentas = null;
	if(request.getAttribute("listaCuentas")!=null) 									//Si el Atributo creado desde el Servlet es distinto de nulo 
	{
		listaCuentas = (ArrayList<Cuentas>) request.getAttribute("listaCuentas");		//Copio al ArrayList
	}
	else																		//Si es falso
	{
			//Esto ocurrirá la primera vez que entre al JSP, luego siempre irá por el IF
		CuentasNegocio cNeg2 = new CuentasNegocioImpl();
		listaCuentas = (ArrayList<Cuentas>) cNeg2.traerCuentas();		//Busco y copio todos los Registros
	}
%>
	
	<br> <br> <br> <br>

<div id="tablita">
	<table id="tablax" class="display">
	<thead>
		<tr>
			<th>DNI</th>
			<th>Nombre</th>
			<th>Apellido</th>
			<th>Tipo de Cuenta</th>
			<th>Nº de Cuenta</th>
			<th>CBU</th>
			<th>Fecha de Creación</th>
			<th>Saldo</th>
			<th>Estado</th>
			<th>Acciones</th>

		</tr>
	</thead>
	<tbody>	
	<% if(listaCuentas!=null)
	{
		for(Cuentas c:listaCuentas)
		{%>
		<tr>
		<form action="servletCuentas" method="post">
			<td><%=c.getDNI()%> 						<input type="hidden" name="nroDNI" value="<%=c.getDNI()%>"></td>
			<td><%=c.getCliente().getNombre()%> 		<input type="hidden" name="nombre" value="<%=c.getCliente().getNombre()%>"></td>
			<td><%=c.getCliente().getApellido()%>		<input type="hidden" name="apellido" value="<%=c.getCliente().getApellido()%>"></td>
			<td><%=c.gettCuenta().getDescripcion()%></td>
			<td><%=c.getNro_cuenta()%> 					<input type="hidden" name="nroCuenta" value="<%=c.getNro_cuenta()%>"></td>
			<td><%=c.getCBU()%> 						<input type="hidden" name="nroCBU" value="<%=c.getCBU()%>"></td>
			<td><%=c.getFecha_creacion()%></td>
			<td><%=c.getSaldo()%></td>
			<td><%=c.getEstado()%></td>
			<!--<td><input type="image" name="btnBloquear" src="imagenes/bloquear.png" width="75" height="45" method="post"></td>-->
			<!--<td><input type="submit" name="btnDesbloquear" value="Unlock"></td>-->
			<td>
			<div style="display: flex; justify-content: center;">
				<button type="submit" name="btnBloquear" style="border:none;"><img src="imagenes/bloquear.png" width="75" height="45"></button>&nbsp;
				<button type="submit" name="btnDesbloquear" style="border:none;"><img src="imagenes/desbloquear.png" width="75" height="45"></button>&nbsp;
				<button type="submit" name="btnModificar" style="border:none;"><img src="imagenes/modificar.png" width="75" height="45"></button>
			</div>
			</td>
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
                scrollY: 550,
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
  				alert("Se modificó Cuenta.");
			</script>
	<%}
%>
    
</body>
</html>