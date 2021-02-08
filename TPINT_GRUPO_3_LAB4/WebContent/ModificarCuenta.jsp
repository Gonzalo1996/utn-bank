<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Cuentas" %>
<%@ page import="entidad.TipoCuenta" %>
<%@ page import="entidad.Cliente" %>
<%@ page import="negocio.CuentasNegocio" %>
<%@ page import="negocioImpl.CuentasNegocioImpl" %>

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
<title>Modificar Cuenta</title>
<link href="css/seleccionar-Cliente.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>
</head>
<body>

<!-- Barra Título -->
	<jsp:include page="MasterPage_ADMINISTRADOR.jsp"></jsp:include>
	<h1 style="margin-left:45%; color: white">MODIFICAR CUENTA</h1>
	
<%
		//CREO UN OBJETO CUENTASNEGOCIO
	CuentasNegocio cNeg = new CuentasNegocioImpl();
%>

<%
	/*Cuentas c = new Cuentas();*/

	final Cuentas c = (Cuentas)request.getAttribute("CUENTA");
	
	String dni = Integer.toString(c.getDNI());
	String nombre = c.getCliente().getNombre();
	String apellido = c.getCliente().getApellido();
	final String cuenta = c.getNro_cuenta();
	final String cbu = c.getCBU();
	
	if(request.getParameter("btnSeleccionar")!=null)
	{
		dni = request.getParameter("nroDni");
		nombre = request.getParameter("nombre");
		apellido = request.getParameter("apellido");
	}
	
%>

<form class="form-cuentas" style="margin-top: -6.5%; height: 25%;"action="servletCuentas" method="post">
	  <div class="form-row">
 		<div class="form-group col-md-4">
	      <label for="inputZip">DNI</label>
	      <input class="form-control" type="text" id="dniNUEVO" name="txtDni" readonly="readonly" value="<%=dni%>" required>
	    </div>

	    <div class="form-group col-md-4">
	      <label for="inputZip">Nombre</label>
	      <input class="form-control" type="text" id="nombreNUEVO" name="txtNombre" readonly="readonly" value="<%=nombre%>" required>
	    </div>
	    
	    <div class="form-group col-md-4">
	      <label for="inputZip">Apellido</label>
	      <input class="form-control" type="text" id="apellidoNUEVO" name="txtApellido" readonly="readonly" value="<%=apellido%>" required>
	    </div>
	  </div>
	    
	  <div class="form-row">
 		<div class="form-group col-md-4">
	      <label for="inputZip">Número Cuenta</label>
	      <input class="form-control" type="text" id="numeroCuenta" readonly="readonly" name="txtNumCuenta" value="<%=cuenta%>" required>
	    </div>

	    <div class="form-group col-md-4">
	      <label for="inputZip">CBU</label>
	      <input class="form-control readonly" type="text" id="numeroCBU" readonly="readonly" name="txtCBU" value="<%=cbu%>" required>
	    </div>
	    
	   	<div class="form-group col-md-4">
	      <label for="inputCity">Tipo Cuenta</label>
		      <select id="inputState" class="form-control" name="tCuentas">
		    <% 
					ArrayList<TipoCuenta> listaTipos = (ArrayList<TipoCuenta>)cNeg.traerTiposCuentas(); 
												
					if(listaTipos!=null)																	
						for(TipoCuenta tipo:listaTipos){ %>												  
						<option value="<%=tipo.getIdTipo()%>"><%=tipo.getDescripcion()%></option>		  
			<%}%>
		      </select>
	    
	    </div>
	  </div>  

	  <button type="submit" style="margin-left:45%;" class="btn btn-primary" name="btnModify" align>Modificar</button>
</form>

								<!--------------------------------------------- TABLA CLIENTES --------------------------------------------->

<%
	ArrayList<Cliente> listaClientes = (ArrayList<Cliente>)cNeg.traerClientes();
%>
	
	<br> <br>

<div id="tablita2">
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
		for(Cliente cc:listaClientes)
		{%>
		<tr>
		<form>
			<td><%=cc.getDNI()%>      <input type="hidden" id="dni" name="nroDni" value="<%=cc.getDNI()%>"> </td>
			<td><%=cc.getCUIL()%>     <input type="hidden" name="nroCUIL" value="<%=cc.getCUIL()%>"> </td>
			<td><%=cc.getNombre()%>   <input type="hidden" id="nombre" name="nombre" value="<%=cc.getNombre()%>"></td>
			<td><%=cc.getApellido()%> <input type="hidden" id="apellido" name="apellido" value="<%=cc.getApellido()%>"></td>
			<td><input type="button" name="btnSeleccionar" onclick="cargarInputs()" value="Seleccionar"></td>
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
	
	<!-- Para Obtener los Valores de la Fila Seleccionado y setearlos a los Input -->
<script type="text/javascript">
	function cargarInputs()
	{
		var dni = document.getElementById("dni").value;
		var nombre = document.getElementById("nombre").value;
		var apellido = document.getElementById("apellido").value;
		
			document.getElementById("dniNUEVO").value = dni;
			document.getElementById("nombreNUEVO").value = nombre;
			document.getElementById("apellidoNUEVO").value = apellido;
	}
</script>

</body>
</html>