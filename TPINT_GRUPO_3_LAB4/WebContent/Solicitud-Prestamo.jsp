<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="entidad.Cliente"%>
<%@page import="entidad.Cuentas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="negocioImpl.CuentasNegocioImpl"%>
<%@page import="negocio.CuentasNegocio"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<title>Solicitud de Préstamo</title>
<link href="css/estilo-prestamos.css" rel="stylesheet" type="text/css"/>
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
	ArrayList<Cuentas> listaCuentas = null;
	if(request.getAttribute("listaCuentas")!=null) 									//Si el Atributo creado desde el Servlet es distinto de nulo 
	{
		listaCuentas = (ArrayList<Cuentas>) request.getAttribute("listaCuentas");		//Copio al ArrayList
	}
	else																		//Si es falso
	{
			//Esto ocurrirá la primera vez que entre al JSP, luego siempre irá por el IF
		CuentasNegocio cNeg2 = new CuentasNegocioImpl();
		listaCuentas = (ArrayList<Cuentas>) cNeg2.traerCuentas_x_dni(c.getDNI());		//Busco y copio todos los Registros
	}
%>
	
	<div id=cuadroprestamo>
	
	<h1 style="color:#1883ba;">Solicitud de prestamo</h1>
		<form action="servletPrestamos" method="post">
	
	<input type="hidden" name="dni" value="<%=c.getDNI()%>">
	
	Ingrese su monto solicitado:
		<input type="text" Style= "margin-left:10px;" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" name="monto"/>
	<br>
	<br>
	<br>
	
	Seleccione Cuenta:
		<select Style= "margin-left:10px;" name= "cuentas">
		 <% 
	    
	     if(listaCuentas!=null){
			for(Cuentas cuent:listaCuentas)
			{
				
			%>
			<option  value=<%=cuent.getNro_cuenta() %>> <%=cuent.getNro_cuenta()%></option>
			
			 <% }
	} %>
	</select>	
	<br>
	<br>
	<br>
	
	Seleccione Cuotas:
		<select name= "cuotas">
		<option value="3"> 3</option>
		<option value="6">6 </option>
		<option value="12">12 </option>
		<option value="18">18 </option>
		<option value="24">24 </option>
		
			</form>
	
		
	<br>
	<br>
	<br>
	
	<input type="submit" name="btnSolicitarPrestamo" value="Solicitar prestamo" Style= "padding:10px;margin-left:100px;border-radius:6px;background-color: #1883ba;opacity:1.0;">
	<input type="submit" name="btnCalc" value="Calcular" Style= "padding:10px;border-radius:6px;background-color: #1883ba;opacity:1.0;">
	
	
	
		
	
	<br>
	
	
	
	<br>
	
	<!-- 
	<h1 style="color:#1883ba;">Cantidad a pagar</h1>
	
	Monto a pagar:
		<input type="text" name = "to" Style= "margin-left:10px;">
	<br>
	<br>
	<br>
	
	Cantidad por mes:
		<input type="text" name="cu"Style= "margin-left:10px;">
	<br>
	<br>
	<br>
	
	
	<input type="submit" name="btnresetear" value="Resetear Informacion" Style= "padding:10px;margin-left:120px;border-radius:6px;background-color: #1883ba;opacity:1.0;">
	
	
	
	</div>
	
	 -->
	 <%
	boolean filas = false;
	boolean f = false;
	if(request.getAttribute("isInserted")!=null) {filas = (boolean)request.getAttribute("isInserted");}
	if(filas == true)
	{%>
			<script type="text/javascript">
  				alert("Solicitud enviada, espere su confirmacion");
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