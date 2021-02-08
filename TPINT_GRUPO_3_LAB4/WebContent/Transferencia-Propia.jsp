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
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<title>Transferencias Propias</title>
    <style type="text/css">
    <jsp:include page="css/estilo-fondo.css"></jsp:include>
	</style>
</head>
<body>

<%
	Cliente c = (Cliente)session.getAttribute("cliente");				//Guardo el Objeto Cliente recibido de la Session
	String dni = Integer.toString(c.getDNI());
%>

<%
	Movimientos_y_CuentasNegocio MyC = new Movimientos_y_CuentasNegocioImpl();
	
	ArrayList<Cuentas> listaCuentas = null;
	listaCuentas = (ArrayList<Cuentas>)MyC.traerTodaslasCuentas(dni);
%>

<!-- Barra Título -->
	<jsp:include page="MasterPage_USUARIO.jsp"></jsp:include>
	<br>
		<div id="transferencia">
		<br>
		<h1 id="titulo">Transferencia entre Cuentas Propias</h1>
		
		<h5 style="text-align:left; color:white;">Seleccione cuenta de dónde se Transferirá:</h5>
		
		<form method="post" action="servletTraerMovimientos">
<%if(listaCuentas != null){ %>
		<table class="fondo">
			<tr>
    			<th></th>
    			<th>Tipo</th>
    			<th>Cuenta</th>
   				<th>Saldo</th>
  			</tr>
  			<%for(Cuentas ca:listaCuentas)
			{%>
  			<tr>
    			<td><input type="radio" name="salida" value="<%=ca.getNro_cuenta()%>" required></td>
    			<td><%=ca.gettCuenta().getDescripcion()%></td>
    			<td><%=ca.getNro_cuenta()%></td>
    			<td><%=ca.getSaldo()%></td>
  			</tr>
  			<%}%>
		</table>
		
		<br>
		
		<h5 style="text-align:left; color:white;">Seleccione cuenta a dónde se Transferirá:</h5>
		
		<table class="fondo">
			<tr>
    			<th></th>
    			<th>Tipo</th>
    			<th>Cuenta</th>
   				<th>Saldo</th>
  			</tr>
  			<%for(Cuentas ca:listaCuentas)
			{%>
  			<tr>
    			<td><input type="radio" name="destino" value="<%=ca.getNro_cuenta()%>" required></td>
    			<td><%=ca.gettCuenta().getDescripcion()%></td>
    			<td><%=ca.getNro_cuenta()%></td>
    			<td><%=ca.getSaldo()%></td>
  			</tr>
  			<%}%>
		</table>
<%} %>
		<br>
		
		<div class="fondo">
		<h4 style="text-align:left;">&nbsp;Detalle de la Operación:</h4>
		<br>
			<table>		
				<tr><td>&nbsp;Importe a Transferir: </td><td><input class="cajaTexto" type="text" name="txtMonto" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" required></td></tr>
				<!--<tr><td>&nbsp;Detalle: </td><td><input class="cajaTexto" type="text" name="txtDetalle" size="100"></td></tr>-->
				<tr><td></td><td><input type="submit" name="btnTransferir" value="Transferir" align="right"></td></tr>
			</table>		
		</div>
		
		</form>
	<br>
	</div>
	
<%
	boolean cuentasIguales = false;

	if(request.getAttribute("sonIguales")!=null) {cuentasIguales = (boolean)request.getAttribute("sonIguales");}
	if(cuentasIguales == true)
	{%>
			<script type="text/javascript">
  				alert("No se puede Transferir Dinero a la misma Cuenta.");
			</script>
	<%}
%>
	
<%
	boolean esMenor = false;

	if(request.getAttribute("esMenor")!=null) {esMenor = (boolean)request.getAttribute("esMenor");}
	if(esMenor == true)
	{%>
			<script type="text/javascript">
  				alert("No es posible realizar la Transacción, no le alcanza el Dinero para transferir.");
			</script>
	<%}
%>

<%
	boolean agrego = false;

	if(request.getAttribute("agrego")!=null) {agrego = (boolean)request.getAttribute("agrego");}
	if(agrego == true)
	{%>
			<script type="text/javascript">
  				alert("Transferencia Exitosa.");
			</script>
	<%}
%>

</body>
</html>