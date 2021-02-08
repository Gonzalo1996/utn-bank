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

<title>Consulta/Pago de Préstamos</title>
<link href="css/estilo-estadisticas.css" rel="stylesheet" type="text/css"/>
<link href="css/estilos-consulta.css" rel="stylesheet" type="text/css"/>
   <style type="text/css">
    <jsp:include page="css/estilo-fondo.css"></jsp:include>
	</style>
</head>
<body>

<%
	Cliente c = (Cliente)session.getAttribute("cliente");				//Guardo el Objeto Cliente recibido de la Session
%>

<!-- Barra Título -->
	<jsp:include page="MasterPage_USUARIO.jsp"></jsp:include>
	
	
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
		listaPrestamos = (ArrayList<Prestamos>) cPres.traerPrestamos(c.getDNI());		//Busco y copio todos los Registros
	}
	
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	ArrayList<cuotas> listaCuotas=null;
	
	if(request.getAttribute("listaCuotas")!=null) 									//Si el Atributo creado desde el Servlet es distinto de nulo 
	{
		listaCuotas = (ArrayList<cuotas>) request.getAttribute("listaCuotas");		//Copio al ArrayList
	}
	else																		//Si es falso
	{
			//Esto ocurrirá la primera vez que entre al JSP, luego siempre irá por el IF
		PrestamosNegocio cCuo = new PrestamosNegocioImpl();
		listaCuotas = (ArrayList<cuotas>) cCuo.traerCuotas(c.getDNI());		//Busco y copio todos los Registros
	}
	
%>	
	
		<h1 style="margin-left:40%;  color: black; font-weight:bold;margin-top:1%">Consultas de pago </h1>
	<div id="tablita" class="display">
	<table id="tablax" >
	<thead>
		<tr>
			<th	>Fecha</th>
			<th>Codigo de prestamo</th>
			<th>Total cuotas a pagar</th>
			<th>Cuota a pagar</th>
			<th>Total de la cuota</th>
			
			<th>Total prestamo</th>
			<th>CBU</th>
			<th>Accion</th>
		</tr>
	</thead>
	<tbody>	
	
	
	
	 <% 
	    
	     if(listaPrestamos!=null){
			for(Prestamos pre:listaPrestamos)
			{
				if(pre.getEstado().equals("Activo")){
			%>
		<tr>
			<form action="servletPrestamos" method="post">
			
		<td style="text-align: center;"><%=pre.getFecha()%></td> 
		<td style="text-align: center;"><%=pre.getIdPrestamo()%> <input type="hidden" name="idPres" value="<%=pre.getIdPrestamo()%>"></td> 
		<td style="text-align: center;"><%=pre.getPlazo_pago()%> </td> 
		<td style="text-align: center;" ><%=pre.getNro_cuota()%><input type="hidden" name="nroCuota" value="<%=pre.getNro_cuota()%>"></td> 
		<td style="text-align: center;">$<%=pre.getImp_a_pagar()%> <input type="hidden" name="impCuota" value="<%=pre.getImp_a_pagar()%>"> </td> 
		<td style="text-align: center;">$<%=pre.getImp_pedido()%></td> 
		<td style="text-align: center;"><%=pre.getObtener_cbu().getCBU()%> <input type="hidden" name="cbu" value="<%=pre.getObtener_cbu().getCBU()%>"></td> 
		
		<td style="text-align: center;"><input type="submit"  name="btnPagar" value="Pagar" ></td> 
		
		<input type="hidden" name="dni" value="<%=c.getDNI()%>">	
		
		
		</form>
		</tr>
			
		
			  <% 
			  
				}}
	} %>
	</tbody>
		
</table>
</div>
	
	
	
	<div id="tablita3" class="display" style="width: 50%;top:1044px;position:absolute;left:500px;">
	<h1 align="center">        Historial de pagos pasados </h1>
	<table id="tablax2">
	<thead>
		<tr>
			<th>Codigo de prestamo</th>
			<th>Nro Cuota</th>
			<th>Fecha</th>
			<th>Importe</th>
			
			<th>CBU</th>
			
		</tr>
	</thead>
	<tbody>	
	
	
	<% 
	    
	     if(listaCuotas!=null){
			for(cuotas cuo:listaCuotas)
			{
				
					
			%>
	
		<tr>
		<td style="text-align: center;">   <%=cuo.getIdcuotas()%>   </td>
		<td style="text-align: center;"> <%=cuo.getNrocuota()%> </td>
		<td style="text-align: center;"><%=cuo.getFecha()%></td> 
		<td style="text-align: center;"> <%=cuo.getImporte()%>  </td>
		<td style="text-align: center;"> <%=cuo.getCbu()%>  </td>
		
		
			
		
			
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
                scrollY: 444,
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
                scrollY:200,
                lengthMenu: [ [10, 5, 15, -1], [10, 5, 15, "Todos"] ],
            });
        });
    </script>
    
    
    
    
    
    
    
<%
	boolean filas = false;
	boolean f = false;
	if(request.getAttribute("isInserted")!=null) {filas = (boolean)request.getAttribute("isInserted");}
	if(filas == true)
	{%>
			<script type="text/javascript">
  				alert("Cuota pagada");
			</script>
	<%}
    
	
	if(request.getAttribute("isInserto")!=null) {f = (boolean)request.getAttribute("isInserto");}
	if(f == true)
	{%>
			<script type="text/javascript">
  				alert("Saldo insuficiente");
			</script>
	<%}
%>    
</body>
</html>