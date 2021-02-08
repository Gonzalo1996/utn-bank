<%@page import="daoImpl.ClienteDAOlmpl"%>
<%@page import="dao.ClienteDAO"%>
<%@page import="java.util.Objects"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Cuentas" %>
<%@ page import="entidad.TipoCuenta" %>
<%@ page import="negocio.CuentasNegocio" %>
<%@ page import="negocioImpl.CuentasNegocioImpl" %>




<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" type="image/png" href="imagenes/UTN BANC 3.png">
<title>Informe/Estadísticas</title>
<link href="css/estilo-estadisticas.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
		<jsp:include page="css/estilos-admin.css"></jsp:include>
	</style>
	
	<!-- Importo Chart.js para crear el Gráfico -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	
</head>
<body>

<!-- Barra Título -->
	<jsp:include page="MasterPage_ADMINISTRADOR.jsp"></jsp:include>
	
	<h1 style="margin-left:44%;  color: white; font-weight:bold;margin-top:0%">INFORMES/ESTADÍSTICAS</h1>
	
<%
	ArrayList<Integer> totales = new ArrayList<Integer>();		//Creo un ArrayList de Enteros
	CuentasNegocio cNeg = new CuentasNegocioImpl();
	
	totales = (ArrayList)cNeg.traerTotalesCuentas();			//Cargo el ArrayList llamando a la Funcion traerTotalesCuentas();
	
%>

<%
	ArrayList<Integer> totalesM = new ArrayList<Integer>();		//Creo un ArrayList de Enteros
	totalesM = (ArrayList)cNeg.traerTotalesMovimientos();		//Cargo el ArrayList llamando a la Funcion traerTotalesMovimientos();
%>

<div style="background-color: RGB(255, 255, 0, 0.80); width: 35%; margin-left:20%">
	<canvas id="myChart" width="400" heigth="300"></canvas>
</div>

<div style="background-color: RGB(255, 255, 0, 0.80); width: 35%; margin-left:60%; margin-top: -17.5%">
&nbsp;Totales de Movimientos registrados en el Banco:
	<canvas id="myChart2" width="400" heigth="300"></canvas>
</div>

	
<%
	ClienteDAO cNe = new ClienteDAOlmpl();
	float montoTotMovimientos = cNe.MontoTotalMovimientos();
	
	
	float totalTipoMov = 0;
	boolean tipoMov = false;
	int numMovimiento = 0;
	String cartelMontoMov = " ";
	String cartelMovimiento = "-";
	
	if(request.getAttribute("montoTotal") != null)
	{
		 totalTipoMov = (float)request.getAttribute("montoTotal");
	}
	
	if(request.getAttribute("tipoMovNul") != null)
	{
		tipoMov = (boolean)request.getAttribute("tipoMovNul");
	}
	
	if(request.getAttribute("tipoMov") != null)
	{
		numMovimiento = (int)request.getAttribute("tipoMov");
		
		if(numMovimiento == 1)
		{
			cartelMovimiento = "Monto total de apertura cuentas";
		}
		else if(numMovimiento == 2)
		{
			cartelMovimiento = "Monto total de depositos prestamos";
		}
		else if(numMovimiento == 3)
		{
			cartelMovimiento = "Monto total de transaccion a terceros";
		}
		else if(numMovimiento == 4)
		{
			cartelMovimiento = "Monto total de transaccion a cuenta propias";
		}
		else if(numMovimiento == 5)
		{
			cartelMovimiento = "Monto total de pago prestamos";
		}
		else if(numMovimiento == 6)
		{
			cartelMovimiento = "Monto total de transaccion de terceros";
		}
		else if(numMovimiento == 7)
		{
			cartelMovimiento = "Monto total de transaccion de cuenta propia";
		}
	}
	
	if(tipoMov == true)
	{
		cartelMontoMov = "Seleccione un tipo de movimiento";
	}
	
%>

	
	
	
	
	
	
	
	<script type="text/javascript">
var ctx = document.getElementById('myChart').getContext('2d');
// Copio los totales de las Cuentas del ArrayList
var cuenta = <%=totales.get(0)%>;
var corriente = <%=totales.get(1)%>;
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'bar',
    // The data for our dataset
    data: {
        labels: ['Caja de Ahorro', 'Cuenta Corriente'],
        datasets: [{
            label: 'Cantidad de Cuentas Activas',
            backgroundColor: 'rgb(239, 127, 26)',
            borderColor: 'rgb(0, 47, 187)',
            data: [cuenta, corriente, 20]
        }]
    },
    // Configuration options go here
    options: {
    	scales:{
    		yAxes:[{
    			ticks:{
    				beginAtZero:true
    			}
    		}]
    	}
    }
});
</script>
	
	
	<script type="text/javascript">
var ctx = document.getElementById('myChart2').getContext('2d');

// Copio los totales de las Cuentas del ArrayList
var ap = <%=totalesM.get(0)%>;
var dep = <%=totalesM.get(1)%>;
var tat = <%=totalesM.get(2)%>;
var tacp = <%=totalesM.get(3)%>;
var pp = <%=totalesM.get(4)%>;
var tdt = <%=totalesM.get(5)%>;
var tdcp = <%=totalesM.get(6)%>;

var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'doughnut',
    
    // The data for our dataset
    data: {
        datasets: [{
            data: [ap, dep, tat, tacp, pp, tdt, tdcp],
            backgroundColor: [
                "#8E44AD",
                "#63FF84",
                "#E74C3C",
                "#D35400",
                "#283747",
                "#2ECC71",
                "#5DADE2"
            ]
        }],
        labels: [
            'Apertura Cuenta',
            'Deposito Prestamo',
            'Transaccion a terceros',
            'Transaccion a cuenta propia',
            'Pago Prestamo',
            'Transaccion de terceros',
            'Transaccion de cuenta propia'
        ]
    },

    // Configuration options go here
    options: {
    }
});
</script>
	
	
	
	<form action="servletClientes" method="get">
<div class="row" style="margin-left: 35%; margin-top: 10%;">
  <div class="col-sm-8">
  	 <h5 class="card-header" style="background-color: #FFA500; text-align: center;">Seleccionar Movimiento</h5>
    <div class="card">
      <div class="card-body">
	  
	      <table>
		      <tr>
			      <td>Desde:
			      <input type="text" name="fechaDesde" required placeholder="dd/mm/yyyy" style="text-align: center;"
			      		onkeypress="return ((event.charCode >= 48 && event.charCode <= 57) || (event.charCode == 47))"	></td>
			      <td>
			      Hasta:
			      <input type="text" name="fechaHasta" required placeholder="dd/mm/yyyy" style="text-align: center;" 
			      		onkeypress="return ((event.charCode >= 48 && event.charCode <= 57) || (event.charCode == 47))"	>
			      </td>
			      <td>
			      <br>
			      	<select  name="tipoMov">
			      		<option value="0">--- Tipo Movimiento ---</option>
			      		<option value="1">Apertura Cuenta</option>
			      		<option value="2">Deposito Prestamo</option>
			      		<option value="3">Transaccion a terceros</option>
			      		<option value="4">Transaccion a cuenta propia</option>
			      		<option value="5">Pago Prestamo</option>
			      		<option value="6">Transacción de terceros</option>
			      		<option value="7">Transaccion de cuenta propia</option>
			      	</select>
			      </td>
		      </tr>
	      </table>
	      <input type="submit" name="btnVerificarImporte" value="Monto">
	      <%=cartelMontoMov %>
			
      </div>
    </div>
  </div>
</div>
	
<div class="row" style="margin-left: 25%; margin-top: 5%;">
  <div class="col-sm-5">
  	 <h5 class="card-header" style="background-color: #FFA500; text-align: center;">Monto total de movimientos</h5>
    <div class="card">
      <div class="card-body">
        <h3 class="card-title" style="text-align: center;">$<%=montoTotMovimientos%></h3>
      </div>
    </div>
  </div>
  <div class="col-sm-5">
  	  	 <h5 class="card-header" style="background-color: #FFA500; text-align: center;"><%=cartelMovimiento %></h5>
    <div class="card">
      <div class="card-body">
        <h3 class="card-title" style="text-align: center;">$<%=totalTipoMov%></h3>
      </div>
    </div>
  </div>
</div>
</form>
	
	
	
	
	
</body>
</html>