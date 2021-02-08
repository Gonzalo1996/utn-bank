<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<title>Crear Cuenta</title>
    <style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>
</head>
<body>

<!-- Barra Título -->
	<jsp:include page="MasterPage_ADMINISTRADOR.jsp"></jsp:include>
	<h1 style="margin-left:25%;  color: white">CREAR CUENTA A CLIENTE</h1>
	
<%
		//CREO UN OBJETO CUENTASNEGOCIO
	CuentasNegocio cNeg = new CuentasNegocioImpl();
%>

<%
		//PARA OBTENER LA FECHA DE HOY
	Date fecha = new Date();
	SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
	String fechaActual = formateador.format(fecha);
%>

<%
	String dni = "";
	String nombre = "";
	String apellido = "";
	
	if(request.getParameter("btnSeleccionar")!=null)
	{
		dni = request.getParameter("nroDni");
		nombre = request.getParameter("nombre");
		apellido = request.getParameter("apellido");
	}
	
%>

<form class="form-cuentas" action="servletCuentas" method="post">
	 
	 <div class="form-group">
	    <a href="Listado_de_Clientes.jsp"><img src="imagenes/Clientes_boton.png" width="200" height="45"></a>
	  </div>
	 
	  <div class="form-row">
 		<div class="form-group col-md-4">
	      <label for="inputZip">DNI</label>
	      <input class="form-control readonly" id="bloquear" type="text" name="txtDni" onkeypress="return false;" autocomplete="off" value="<%=dni%>" maxlength="8" required>
	    </div>

	    <div class="form-group col-md-4">
	      <label for="inputZip">Nombre</label>
	      <input class="form-control" type="text" name="txtNombre" readonly="readonly" value="<%=nombre%>" required>
	    </div>
	    
	    <div class="form-group col-md-4">
	      <label for="inputZip">Apellido</label>
	      <input class="form-control" type="text" name="txtApellido" readonly="readonly" value="<%=apellido%>" required>
	    </div>
	  </div>
	    
	  <div class="form-row">
 		<div class="form-group col-md-4">
	      <label for="inputZip">Número Cuenta</label>
	      <input class="form-control" type="text" id="numeroCuenta" autocomplete="off" name="txtNumCuenta" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" minlength="13" maxlength="13" required>
	    </div>

	    <div class="form-group col-md-4">
	      <label for="inputZip">CBU</label>
	      <input class="form-control readonly" type="text" id="numeroCBU" autocomplete="off" name="txtCBU" onclick="crearCBU()" onkeypress="return false;" maxlength="22" required>
	    </div>
	    
	   	<div class="form-group col-md-4">
	      <label for="inputZip">Saldo</label>
	      <input class="form-control" type="text" name="txtSaldo" value="$10000" readonly="readonly">
	    </div>
	  </div>  
	 
	  <!-- ---------------------------------------------------------------------------------------------------------------- -->
	  
	  <div class="form-row">
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

							<!-- FECHA REGISTRO -->

	    <div class="form-group col-md-4">
	      <label for="inputZip">Fecha Registro</label>
	      <input class="form-control" type="text" name="txtFechaReg" readonly="readonly" value="<%=fechaActual%>">
	    </div>
	  </div>

	  <button type="submit" class="btn btn-primary" name="btnRegistrar" align>Registrar</button>

<%
	boolean filas = false;

	if(request.getAttribute("isInserted")!=null) {filas = (boolean)request.getAttribute("isInserted");}
	
	if(request.getAttribute("noInserted")!=null)
	{%>
			<script>
			alert("Ya existe el Numero de Cuenta");
  			</script>
	<%}
	
	if(filas == true)
	{%>
			<script type="text/javascript">
  				alert("Se creó Cuenta.");
			</script>
	<%}
%>

</form>


<!-- SCRIPT PARA READONLY DE DNI, PARA PODER USAR EL REQUIRED -->
<script type="text/javascript">
	$(".readonly").keydown(function(e){
   		 e.preventDefault();
	});
</script>

<script type="text/javascript">
window.onload = function() {
	  var myInput = document.getElementById('bloquear');
	  myInput.onpaste = function(e) {
	    e.preventDefault();
	    alert("Está Prohibido Pegar");
	  }
	  
	  myInput.oncopy = function(e) {
	    e.preventDefault();
	    alert("Está Prohibido Copiar");
	  }
	}
</script>


<!-- SCRIPT PARA GENERAR CBU AUTOMATICAMENTE -->

<script type="text/javascript">
	function crearCBU()
	{
		var texto = document.getElementById("numeroCuenta").value;
		if(texto != "")
		{
			document.getElementById("numeroCBU").value = "28505909" + texto + "1";
		}
	}
</script>
	
</body>
</html>