<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<!-- <script defer src="scriptClientes.js" type="text/javascript"></script> ANDA-->
<title>Agregar Cliente</title>
    <style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>
</head>
<body>

<!-- Barra T�tulo -->
	<jsp:include page="MasterPage_ADMINISTRADOR.jsp"></jsp:include>

	<div class="Ingreso">
	
	
		<h4 style="text-align: center;">Agregar Cliente </h4>
		<form name="formCliente" action="servletClientes" method="post">
		<table style="margin-top:5%;"  >
			<tr>
				<td><h4>Nombre</h4></td>
				<td>
					<input type="text" name="txtNombre" Style="margin-left:20px;" class="form-control"  autocomplete="off" required placeholder="escribe el nombre(s)"
					onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) || (event.charCode >= 97 && event.charCode <= 122) || (event.charCode == 32))"													required
					/>
				</td>
			</tr>
			<tr>
				<td><h4>Apellido</h4></td>
				<td>
					<input type="text" name="txtApellido" Style="margin-left:20px;" class="form-control" autocomplete="off" required placeholder="escribe el apellido(s)"
					onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) || (event.charCode >= 97 && event.charCode <= 122)|| (event.charCode == 32))"/>
				</td>
			</tr>
			<tr>
				<td><h4>Dni</h4></td>
				<td>
					<input type="text" name="txtDni" maxlength="8" Style="margin-left:20px;" class="form-control"  autocomplete="off" required placeholder="escribe el dni"
					onkeypress="return (event.charCode >= 48 && event.charCode <= 57)"/>
				</td>
			</tr>
			<tr>
				<td><h4>Cuil</h4></td>
				<td>
					<input type="text" name="txtCuil"Style="margin-left:20px;" class="form-control" maxlength="11" autocomplete="off" required placeholder="escribe el cuil"
					onkeypress="return (event.charCode >= 48 && event.charCode <= 57)"/>
				</td>
			</tr>
			<tr>
				<td><h4>Fecha Nacimiento</h4></td>
				<td>
					<input type="text" name="txtFechaNac" Style="margin-left:20px;" class="form-control" maxlength="10" autocomplete="off" required placeholder="dd/mm/yyyy"
					onkeypress="return (event.charCode >= 48 && event.charCode <= 57)|| (event.charCode == 47))"/>
				</td>
			</tr>
			<tr>
				<td>
					<h4>Sexo</h4>
				</td>
				<td>
					<select name="txtSexo" class="form-control" Style="margin-left:20px;" required>
					<option selected disabled="">--Seleccione una opci�n--</option>
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
						<option selected disabled="">--Seleccione una opci�n--</option>
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
					<option selected disabled="">--Seleccione una opci�n--</option>
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
					<input type="text" name="txtLocal" Style="margin-left:20px;" class="form-control" required autocomplete="off" placeholder="escribe la localidad"
					onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) || (event.charCode >= 97 && event.charCode <= 122) || (event.charCode == 32))"/>
				</td>
			</tr>
			<tr>
				<td><h4>Direcci�n</h4></td>
				<td>
					<input type="text" name="txtDirecc" Style="margin-left:20px;" class="form-control" autocomplete="off" required placeholder="escribe la direcci�n"/>
				</td>
			</tr>
			<tr>
				<td><h4>Email</h4></td>
				<td>
					<input type="email" name="txtEmail" Style="margin-left:20px;" class="form-control" autocomplete="off" required placeholder="Ej:mail@gmail.com"/>
				</td>
			</tr>
			<tr>
				<td><h4>Usuario</h4></td>
				<td>
					<input type="text" name="txtUsuario" Style="margin-left:20px;" class="form-control" autocomplete="off" required placeholder="escribe el usuario"/></td>
			</tr>
			<tr>
				<td><h4>Contrase�a</h4></td>
				<td>
					<input type="password" name="txtContra" Style="margin-left:20px;" autocomplete="off" class="form-control"
					required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}" placeholder="escribe la contrase�a"
					title="Debe contener al menos un n�mero, una letra may�scula y entre 4 y 8 caracteres"/>
				</td>
			</tr>
			<tr>
				<td><h4>Confirmar Contrase�a</h4></td>
				<td>
					<input type="password" name="txtConfirContra" Style="margin-left:20px;" autocomplete="off" class="form-control" required placeholder="confirme la contrase�a"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<button type="submit" name="btnConfirmar" class="btn btn-warning" Style="margin-left:20px;">Confirmar</button>
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
  				alert("Se registr� Cliente.");
			</script>
	<%}
	
	if(request.getAttribute("noInserted")!=null)
	{%>
	
			<script type="text/javascript">
  				alert("El Cliente ya existe");
			</script>
	<%}	
%>

    
</body>
</html>