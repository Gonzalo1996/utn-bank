<%@page import="entidad.Movimientos"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidad.Cliente"%>
<%@page import="entidad.Cuentas"%>
<%@page import="negocio.*" %>
<%@page import="negocioImpl.*" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
	<link href="css/estilo-transferencia.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" 
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
	<style type="text/css"><jsp:include page="css/estilo-fondo.css"></jsp:include></style>
	<title>Transferencia a otras cuentas</title>

</head>


<body>
<!-- Barra Título -->
	<jsp:include page="MasterPage_USUARIO.jsp" ></jsp:include>

<%
	//HttpSession sesion = request.getSession();
	Cliente c = (Cliente)session.getAttribute("cliente");
	List<Cuentas> listarNroCuentas = null;

	if(request.getAttribute("Cuentas") != null)
	{
		listarNroCuentas = (List<Cuentas>) request.getAttribute("Cuentas");
	}
	else
	{
		Movimientos_y_CuentasNegocio MyCneg = new Movimientos_y_CuentasNegocioImpl();
		listarNroCuentas = (List<Cuentas>) MyCneg.NumerosCuentas(c.getDNI());
	}
	
	ArrayList<Movimientos> listaMovimientos = null;
	if(request.getAttribute("listaMovimientos")!=null) 									//Si el Atributo creado desde el Servlet es distinto de nulo 
	{
		listaMovimientos = (ArrayList<Movimientos>) request.getAttribute("listaMovimientos");		//Copio al ArrayList
	}
	else																		//Si es falso
	{
			//Esto ocurrirá la primera vez que entre al JSP, luego siempre irá por el IF
		Movimientos_y_CuentasNegocio MyCneg = new Movimientos_y_CuentasNegocioImpl();
		listaMovimientos = (ArrayList<Movimientos>) MyCneg.traerMovimientos_X_Cuentas();//Busco y copio todos los Registros
	}

%>
	
	
	<div id=cuadroprestamo style="width: 421px; ">
	
	<h1 style="color:#1883ba;">Transferencias</h1>
	
	<form action="servletCuentas" method="get">
		<table>
			<tr>
				<td>Ingrese el CBU:</td>
				<td><input type="text" name="txtCBU" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" Style= "height:25px;"></td>
				<td><label></label>
			</tr>
			<tr>
				<td></td>
				<td>	<input type="submit" name="VerificarCBU" value="Verificar" Style= " padding:10px; border-radius:6px;background-color: #1883ba;opacity:1.0;"></td>
			</tr>
			<tr>
				<td>Ingrese monto:</td>
				<td><input type="text" value="0" name="txtMonto" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" Style= "height:25px;"></td>
			</tr>
		<!--  	<tr>
				<td>Seleccione motivo:</td>
				<td>
					<select name= "dropMotivo">
					<option> Alquiler</option>
					<option>Haberes </option>
					<option>Varios </option>
					<option>Prestamo </option>
					<option>Facturas </option>
					<option> Seguros</option>
					</select>
				</td>
			</tr>-->
			<tr>
				<td>Seleccione cuenta: </td>
				<td>
					<select name="dropCuenta">
					<%
					//List<Cuentas> lista = (List<Cuentas>)request.getAttribute("cuentasUsu");
					
					if(listarNroCuentas != null)
					{
						for(Cuentas i:listarNroCuentas)
						{
					%>
							<option value="<%= i.getNro_cuenta() %>"><%= i.getNro_cuenta() %></option>
					<%	
						}
					}
					 %>
					 </select>
				<!--  
						<option value="1">3213546515346</option>
						<option value="2">4645684654654</option>
						<option value="3">5254312312312</option>	
				-->
				</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="btnSolicitarPrestamo" value="Transferir dinero" Style= "padding:10px;border-radius:6px;background-color: #1883ba;opacity:1.0;">
				</td>
				<td></td>
			</tr>
		</table>
	</form>
		
<%
	Cuentas cuentas = (Cuentas) request.getAttribute("cuentaReg");
	Cliente cliente = (Cliente) request.getAttribute("clienteReg");
	
	if(request.getAttribute("cuenta") != null)
	{
		boolean cuenta = (boolean)request.getAttribute("cuenta");
		
		if(cuenta == true)
		{
			%>
			<h5 style="text-align: center; color:#1883ba;">La cuenta existe</h5>
			<% 		
		}
		else{
			%>
			<h5 style="text-align: center; color:#1883ba;">La cuenta no existe</h5>
			<%
		}
	}
	
	
	if(request.getAttribute("Monto") != null)
	{
		boolean verMonto = (boolean)request.getAttribute("Monto");
		
		if(verMonto == true)
		{
			%>
			<h5 style="text-align: center; color:#1883ba;">Transferencia exitosa</h5>
			<% 	
		}
		else{
			%>
			<h5 style="text-align: center; color:#1883ba;">Monto insuficiente en cuenta</h5>
			<% 	
		}
	}
%>
</div>

<!-- 
	Ingrese el CBU:
	
	<input type="text"Style= "margin-left:10px;height:25px;">
	<br>	
	
	<br>
	<input type="submit" name="btnSolicitarPrestamo" value="Verificar" Style= "padding:10px;margin-left:140px;border-radius:6px;background-color: #1883ba;opacity:1.0;">
	<br>
	<br>
	Ingrese monto:
<input type="text"Style= "margin-left:10px;height:25px;">
	<br>
	<br>
	<br>
	
	
	Seleccione motivo:
		<select name= "cuotas">
		<option> Alquiler</option>
		<option>Haberes </option>
		<option>Varios </option>
		<option>Prestamo </option>
		<option>Facturas </option>
		<option> Seguros</option>
		</select>
	
		
	<br>
	<br>
	<br>
	
	<input type="submit" name="btnSolicitarPrestamo" value="Transferir dinero" Style= "padding:10px;margin-left:140px;border-radius:6px;background-color: #1883ba;opacity:1.0;">
	
	
	<br>
	<br>
	
	
 -->
<%!	
	int dni; 
	String cbu = "CBU persona";
	String nombre = "Nombre persona";
	String apellido = "Apellido persona";
	String nroCuenta = "Num. cuenta persona";
%>

<% 
	if(cuentas != null)
	{
		dni = cuentas.getDNI();
		cbu = cuentas.getCBU();
		nombre = cliente.getNombre();
		apellido = cliente.getApellido();
		nroCuenta = cuentas.getNro_cuenta();
	}
	else{
		dni = 0;
		cbu = "CBU persona";
		nombre = "Nombre persona";
		apellido = "Apellido persona";
		nroCuenta = "Num. cuenta persona";
	}
%> 
	
	<form action="servletCuentas" method="get">
		<div id=cuadroinfo>
		
			<h1 style="color:#1883ba;">Datos de la persona</h1>
			
			<table>
				<tr>
					<td>CBU:</td>
					<td><input type="text" value="<%= nroCuenta%>" disabled="disabled" Style= "margin-left:10px;height:25px;"></td>	
				</tr>
				<tr>
					<td>DNI:</td>
					<td><input type="text" value="<%= dni %>" disabled="disabled" Style="margin-left:10px;height:25px;"></td>	
				</tr>
				<tr>
					<td>Nombre:</td>
					<td><input type="text" value="<%= nombre %>" disabled="disabled" Style= "margin-left:10px;height:25px;"></td>	
				</tr>
				<tr>
					<td>Apellido:</td>
					<td><input type="text" value="<%= apellido %>" disabled="disabled" Style= "margin-left:10px;height:25px;"></td>	
				</tr>
				<tr>
					<td>Número cuenta:</td>
					<td><input type="text" name="cbuVerificado" value="<%= cbu %>" disabled="disabled" Style= "margin-left:10px;height:25px;"></td>	
				</tr>
				
			</table>
		</div>
	</form>	

		<!-- 
		CBU:
		
		<input type="text"Style= "margin-left:10px;height:25px;">
		<br>
		
		<br>
		
		
		DNI:
	<input type="text"Style= "margin-left:10px;height:25px;">
	
		<br>
		<br>
		
		Nombre:
	<input type="text"Style= "margin-left:10px;height:25px;">
		
		<br>
		<br>
		
		Apellido:
	<input type="text"Style= "margin-left:10px;height:25px;">
		<br>
		
		<br>
		
		Email:
	<input type="text"Style= "margin-left:10px;height:25px;">
		<br>
		<br>
	
		
		Telefono:
	<input type="text"Style= "margin-left:10px;height:25px;">
		<br>
		<br>
		
		-->
		
		
		
		
		
	
	 <div id="wrapper" style="margin-bottom:50px;">
  <h1>Historial de transferencias</h1>
  
  <table id="keywords" cellspacing="0" cellpadding="0">
    <thead>
      <tr>
        <th>DNI</th>
        <th><span>Tipo movimiento</span></th>
         <th><span>Fecha</span></th>
        <th><span>CBU</span></th>
        <th><span>Monto $</span></th>
      </tr>
    </thead>
    <tbody>
     <% 
     	if(listaMovimientos != null)
     	{
     		for(Movimientos i:listaMovimientos)
     		{
     			if(i.getDNI() == c.getDNI() )
     			{
     				
     			
     %>
        <tr>
	        <td><%=i.getDNI()%></td>
	        <td>Tran. de Terceros</td>
	        <td><%=i.getFecha()%></td>
	        <td><%=i.getObtener_cbu().getCBU()%></td>
	        <td><%=i.getImporte()%></td>
      	</tr>
     <% 
     			}
     		}
     	}
   	 %>


    </tbody>
  </table>
  
 </div> 
 
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
 	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	
</body>
</html>