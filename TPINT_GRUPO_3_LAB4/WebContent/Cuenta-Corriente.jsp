<%@page import="entidad.Movimientos"%>
<%@page import="entidad.Cuentas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="negocioImpl.Movimientos_y_CuentasNegocioImpl"%>
<%@page import="negocio.Movimientos_y_CuentasNegocio"%>
<%@page import="entidad.Cliente"%>
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
<title>Cuenta Corriente</title>
    <style type="text/css">
    <jsp:include page="css/estilo-fondo.css"></jsp:include>
	</style>
</head>
<body>

<%
	Cliente c = (Cliente)session.getAttribute("cliente");
	String dni = Integer.toString(c.getDNI());
%>

<%
	Movimientos_y_CuentasNegocio MyC = new Movimientos_y_CuentasNegocioImpl();
	
	ArrayList<Cuentas> listaCuentas = null;
	listaCuentas = (ArrayList<Cuentas>)MyC.traerCuentasxCliente_CC(dni);
%>

<!-- Barra Título -->
	<jsp:include page="MasterPage_USUARIO.jsp"></jsp:include>
		<br>
		<div id="general">
		<br>
		<h1 id="titulo">Cuentas Corriente</h1>
		<br>
		
<%if(listaCuentas != null || listaCuentas.size() != 0){ %>
<table class="fondo">
			<tr>
    			<th>Nº Cuenta</th>
    			<th>CBU</th>
   				<th>Saldo</th>
   				<th>Fecha Creación</th>
   				<th></th>
  			</tr>
		<%for(Cuentas ca:listaCuentas)
			{%>
		<tr>
		<form action="servletTraerMovimientos" method="post">
			<td><%=ca.getNro_cuenta()%></td>
			<td><%=ca.getCBU()%> 						<input type="hidden" name="nroCBU" value="<%=ca.getCBU()%>"></td>
			<td><%=ca.getSaldo()%>						<input type="hidden" name="saldo" value="<%=ca.getSaldo()%>"></td>		
			<td><%=ca.getFecha_creacion()%></td>
    		<td><input type="submit" name="btnCUENTACORRIENTE" value="Ver Movimientos"></td>
  			</form>
  			</tr>
  			<%}%>
		</table>
		
<% 
	ArrayList<Movimientos> listaMovimientos = null;
	String cbu = "";
	String saldo = "";
	if(request.getAttribute("listaMovimientos")!=null) 									//Si el Atributo creado desde el Servlet es distinto de nulo 
	{
		listaMovimientos = (ArrayList<Movimientos>) request.getAttribute("listaMovimientos");		//Copio al ArrayList
		cbu = (String)request.getAttribute("CBU");
		saldo = (String)request.getAttribute("SALDO");
	}
%>		
<% 
	if(listaMovimientos!=null){
%>	
		<br><br>
		<h1 id="titulo">Nro. de Cuenta: <%=cbu%>&nbsp; Saldo: $<%=saldo%></h1>
		<table id="tablax" class="fondo" style="text-align:left;">
			<thead>
			<tr>
    			<th>Fecha</th>
    			<th>Descripción</th>
   				<th>Importe</th>
  			</tr>
  			</thead>
  			<tbody>
		<%for(Movimientos m:listaMovimientos)
			{%>
			<tr>
				<td><%=m.getFecha()%></td>
				<td><%=m.gettMove().getDescripcion()%></td>
				<td><%=m.getImporte()%></td>		
  			</tr>
  			<%}%>
  		</tbody>
		</table>
	<%} %>
<%}
else{ %>
<div style="background-color: rgba(255,255,0,0.40); color: white;"><em>Usted no posee Cuentas de Cuenta Corriente</em></div>
<%} %>
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