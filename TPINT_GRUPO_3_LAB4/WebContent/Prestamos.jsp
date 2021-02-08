<%@page import="entidad.Cliente"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidad.Prestamos"%>
<%@page import="negocio.PrestamosNegocio"%>
<%@page import="negocioImpl.PrestamosNegocioImpl"%>
<%@page import="entidad.cuotas"%>
<%@page import="entidad.Cuentas"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<title>Ver Préstamos</title>
    <style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>
</head>
<body>

<!-- Barra Título -->
	<jsp:include page="MasterPage_ADMINISTRADOR.jsp"></jsp:include>
	
	<% 
	ArrayList<Prestamos> listaPrestamos = null;
	
	
	if(request.getAttribute("listaPrestamos")!=null) 									//Si el Atributo creado desde el Servlet es distinto de nulo 
	{
		listaPrestamos = (ArrayList<Prestamos>) request.getAttribute("listaPrestamos");		//Copio al ArrayList
	}
	else																		//Si es falso
	{
			//Esto ocurrirá la primera vez que entre al JSP, luego siempre irá por el IF
		PrestamosNegocio cPres = new PrestamosNegocioImpl();
		listaPrestamos = (ArrayList<Prestamos>) cPres.traerPrestamoss();		//Busco y copio todos los Registros
	}%>
	
	
	<h1 style="margin-left:25%;  color: white">PRÉSTAMOS</h1>
	
	<div style="background-color: RGB(255, 165, 0, 0.70); margin-left:18%; margin-right:2%; border-radius: 5px;">
	<table class="table table-hover" id="tablax">
  <thead>
    <tr>
      <th scope="col">ID</th>
      <th scope="col">DNI</th>
      <th scope="col">Fecha</th>
      <th scope="col">CBU Cuenta a Depositar</th>
      <th scope="col">Importe Pedido</th>
      <th scope="col">Cuotas</th>
      <th scope="col">Monto x Mes</th>
      <th scope="col">Estado</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
   <% 
	    
	     if(listaPrestamos!=null){
			for(Prestamos pre:listaPrestamos)
			{
				if(pre.getEstado().equals("Pendiente")){
			%>
		<tr>
			<form action="servletPrestamos" method="post">
			
		<td ><%=pre.getIdPrestamo()%> <input type="hidden" name="idPres" value="<%=pre.getIdPrestamo()%>">  </td> 
		<td><%=pre.getDNI()%> </td> 
		<td ><%=pre.getFecha()%> </td> 
		<td  ><%=pre.getObtener_cbu().getCBU()%>  <input type="hidden" name="idcbu" value="<%=pre.getObtener_cbu().getCBU()%>"></td> 
		<td >$<%=pre.getImp_pedido()%> <input type="hidden" name="idimp" value="<%=pre.getImp_pedido()%>"> </td> 
		<td ><%=pre.getPlazo_pago()%></td> 
		<td >$<%=pre.getImp_a_pagar()%> </td> 
		<td><%=pre.getEstado()%></td>
		<td ><input type="submit"  name="btnAceptar" value="Aceptar" ></td>
		<td ><input type="submit"  name="btnRechazar" value="Rechazar" ></td> 
		
		
		
		
		</form>
		</tr>
			
		
			  <% 
			  
				}}
	} %>
  
  
  </tbody>
  
  
</table>
</div>
<br>
<br>
<div style="background-color: RGB(255, 165, 0, 0.70); margin-left:18%; margin-right:2%; border-radius: 5px;">
	<table class="table table-hover" id="tablax2">
  <thead>
    <tr>
      <th scope="col">ID</th>
      <th scope="col">DNI</th>
      <th scope="col">Fecha</th>
      <th scope="col">CBU Cuenta a Depositar</th>
      <th scope="col">Importe Pedido</th>
      <th scope="col">Cuotas</th>
      <th scope="col">Monto x Mes</th>
      <th scope="col">Estado</th>
    </tr>
  </thead>
  <tbody>
   <% 
	    
	     if(listaPrestamos!=null){
			for(Prestamos pre:listaPrestamos)
			{
				if(pre.getEstado().equals("Activo") || pre.getEstado().equals("Inactivo") || pre.getEstado().equals("Rechazado")){
			%>
		<tr>
			<form action="servletPrestamos" method="post">
			
		<td ><%=pre.getIdPrestamo()%></td> 
		<td><%=pre.getDNI()%> </td> 
		<td ><%=pre.getFecha()%> </td> 
		<td  ><%=pre.getObtener_cbu().getCBU()%></td> 
		<td >$<%=pre.getImp_pedido()%>  </td> 
		<td ><%=pre.getPlazo_pago()%></td> 
		<td >$<%=pre.getImp_a_pagar()%> </td> 
		<% if(pre.getEstado().equals("Activo")|| pre.getEstado().equals("Inactivo") ){%>
		<td>Aprobado</td>
		
		<%}
		if(pre.getEstado().equals("Rechazado")){ %>
		<td>Rechazado</td>
		<%} %>
		
		</form>
		</tr>
			
		
			  <% 
			  
				}}
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
                scrollY: 120,
                lengthMenu: [ [10, 5, 15, -1], [10, 5, 15, "Todos"] ],
            });
        });
    </script>



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
            $('#tablax2').DataTable({
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
                scrollY: 120,
                lengthMenu: [ [10, 5, 15, -1], [10, 5, 15, "Todos"] ],
            });
        });
    </script>
    
    <%
	boolean filas = false;

	if(request.getAttribute("isInserted")!=null) {filas = (boolean)request.getAttribute("isInserted");}
	if(filas == true)
	{%>
			<script type="text/javascript">
  				alert("Se actualizo correctamente");
			</script>
	<%}
%>    
    

</body>
</html>