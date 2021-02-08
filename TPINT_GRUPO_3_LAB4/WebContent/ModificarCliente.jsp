<%@page import="entidad.Cliente"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<title>Modificar Cliente</title>
<style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>

</head>
<body>

<!-- Barra Título -->
	<jsp:include page="MasterPage_ADMINISTRADOR.jsp"></jsp:include>
	
	
	
	
	<% 
	
	Cliente cliente = null;
	cliente = (Cliente) request.getAttribute("cliente");
	
	
%>	

	<div class="Ingreso">
	
	
		<h4 style="text-align: center;">Modificar Cliente </h4>
		<form name="formCliente" action="servletClientes" method="post" autocomplete="off">
		<table style="margin-top:5%;"  >
			<tr>
				<td><h4>Nombre</h4></td>
				<td>
					<input type="text" value="<%=cliente.getNombre() %>" name="txtNombre" Style="margin-left:20px;" class="form-control"  required placeholder="escribe el nombre(s)"
					onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) || (event.charCode >= 97 && event.charCode <= 122) || (event.charCode == 32))"													required
					/>
				</td>
			</tr>
			<tr>
				<td><h4>Apellido</h4></td>
				<td>
					<input type="text" value="<%=cliente.getApellido()%>" name="txtApellido" Style="margin-left:20px;" class="form-control" required placeholder="escribe el apellido(s)"
					onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) || (event.charCode >= 97 && event.charCode <= 122)|| (event.charCode == 32))"/>
				</td>
			</tr>
			<tr>
				<td><h4>Dni</h4></td>
				<td>
					<input type="text" value="<%=cliente.getDNI() %>"name="txtDni" readonly="readonly" maxlength="8" Style="margin-left:20px;" class="form-control"  required placeholder="escribe el dni"
					onkeypress="return (event.charCode >= 48 && event.charCode <= 57)"/>
				</td>
			</tr>
			<tr>
				<td><h4>Cuil</h4></td>
				<td>
					<input type="text" value="<%=cliente.getCUIL() %>"name="txtCuil" readonly="readonly" Style="margin-left:20px;" class="form-control" maxlength="11" required placeholder="escribe el cuil"
					onkeypress="return (event.charCode >= 48 && event.charCode <= 57)"/>
				</td>
			</tr>
			<tr>
				<td><h4>Fecha Nacimiento</h4></td>
				<td>
					<input type="text" value="<%=cliente.getFecha() %>"name="txtFechaNac" Style="margin-left:20px;" class="form-control" maxlength="10" required placeholder="dd/mm/yyyy"
					onkeypress="return (event.charCode >= 48 && event.charCode <= 57)|| (event.charCode == 47))"/>
				</td>
			</tr>
			<tr>
				<td>
					<h4>Sexo</h4>
				</td>
								
				<td>
					<select name="txtSexo" class="form-control" Style="margin-left:20px;" required>
						<option selected><%=cliente.getSexo()%></option>
						<option disabled="disabled">------</option>
						<option value="Masculino">Masculino</option>
						<option value="Femenino">Femenino</option>
					</select>
				</td>
			
				<!--  
				<input type="text" name="txtSexo" onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) 
																	|| (event.charCode >= 97 && event.charCode <= 122)"
																	maxlength="10"
																	required
																	Style="margin-left:20px;" class="form-control"/>
				-->
				
			</tr>
			<tr>
			
				<td><h4>Nacionalidad</h4></td>
				<td>
					<select  id="nacion" class="form-control" name="txtNacio" Style="margin-left:20px;" required>
						<option selected><%=cliente.getNacionalidad()%></option>
						<option disabled="disabled">------</option>
						<option value="Argentina">Argentina</option>
					</select>
				</td>
				<!--
				
					  
				<input type="text" name="txtNacio" onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) 
																	|| (event.charCode >= 97 && event.charCode <= 122)
																	|| (event.charCode == 32))"
																	required
																	Style="margin-left:20px;" class="form-control"/>
				-->
				
			</tr>
			
			<tr>
				<td> 
					<h4>Provincia</h4>
				</td>
				<td>
					<select id="provincia" class="form-control" name="txtProv" Style="margin-left:20px;" required>
					<option selected><%=cliente.getProvincia()%></option>
					<option disabled="disabled">------</option>
					<option value="Buenos Aires">Buenos Aires</option>
					<option value="Chubut">Chubut</option>
					<option value="La Pampa">La Pampa</option>
					</select>
				
				</td>
				 	
				<!-- 
				<input type="text" name="txtProv" onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) 
																	|| (event.charCode >= 97 && event.charCode <= 122)
																	|| (event.charCode == 32)
																	|| (event.charCode >= 48 && event.charCode <= 57)
																	|| (event.charCode == 46))"
																	required
																	Style="margin-left:20px;" class="form-control"/>
				-->						
				
				
			</tr>
			<tr>
				<td><h4>Localidad</h4></td>
				<td>
					<input type="text" value="<%=cliente.getLocalidad() %>"name="txtLocal" Style="margin-left:20px;" class="form-control" required placeholder="escribe la localidad"
					onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) || (event.charCode >= 97 && event.charCode <= 122) || (event.charCode == 32))"/>
				</td>
			</tr>
			<tr>
				<td><h4>Dirección</h4></td>
				<td>
					<input type="text" value="<%=cliente.getDireccion() %>"name="txtDirecc" Style="margin-left:20px;" class="form-control" required placeholder="escribe la dirección"
					onkeypress="return ((event.charCode >= 65 && event.charCode <= 90)||(event.charCode >= 97 && event.charCode <= 122)||(event.charCode == 32))"/>
				</td>
			</tr>
			<tr>
				<td><h4>Email</h4></td>
				<td>
					<input type="email" value="<%=cliente.getMail()%>"name="txtEmail" Style="margin-left:20px;" class="form-control" required placeholder="Ej:mail@gmail.com"/>
				</td>
			</tr>
			<tr>
				<td><h4>Usuario</h4></td>
				<td>
					<input type="text" value="<%=cliente.getUserName()%>"readonly="readonly" name="txtUsuario" Style="margin-left:20px;" class="form-control" required placeholder="escribe el usuario"/></td>
			</tr>
			<tr>
				<td><h4>Contraseña</h4></td>
				<td>
					<input type="password" value="<%=cliente.getPass()%>"name="txtContra" Style="margin-left:20px;" class="form-control"
					required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}" placeholder="escribe la contraseña"
					title="Debe contener al menos un número, una letra mayúscula y entre 4 y 8 caracteres"
					autocomplete="off"
					/>
				</td>
			</tr>
			
			<tr>
				<td></td>
				<td>
				<br>
					<button type="submit" name="btnMod" class="btn btn-warning" Style="margin-left:20px;">Confirmar</button>
					<!--<button type="submit" name="btnResetear"class="btn btn-warning" Style="margin-left:20px;">Resetear</button>-->
				</td>
			</tr>
		</table>
		</form>
    </div>
    
<%
	boolean filas = false;

	if(request.getAttribute("isInserted")!=null) {filas = (boolean)request.getAttribute("isInserted");}
	
	if(filas == true)
	{%>
			<script type="text/javascript">
  				alert("Se registró Cliente.");
			</script>
	<%}
	
	if(request.getAttribute("noInserted")!=null)
	{
	%>
	
			<script type="text/javascript">
  				alert("El Cliente ya existe");
			</script>
	<%}
%>


</body>
</html>