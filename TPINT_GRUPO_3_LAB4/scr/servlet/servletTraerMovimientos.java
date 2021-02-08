package servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidad.Cuentas;
import entidad.Movimientos;
import entidad.TipoMovimientos;
import negocio.Movimientos_y_CuentasNegocio;
import negocioImpl.Movimientos_y_CuentasNegocioImpl;

@WebServlet("/servletTraerMovimientos")
public class servletTraerMovimientos extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public servletTraerMovimientos() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Movimientos_y_CuentasNegocio MyCneg = new Movimientos_y_CuentasNegocioImpl();
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//							CAJA DE AHORRO Y CUENTA CORRIENTE
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if(request.getParameter("btnCAJADEAHORRO")!=null)
		{
			//Se hizo click en el boton Seleccionar Cuenta
			
			String nroCBU = request.getParameter("nroCBU").toString();
			String saldo = request.getParameter("saldo").toString();
			
			ArrayList<Movimientos> listaMovimientos = (ArrayList<Movimientos>)MyCneg.traerMovimientosxCuenta_CA(nroCBU);
			request.setAttribute("listaMovimientos", listaMovimientos);
			request.setAttribute("CBU", nroCBU);
			request.setAttribute("SALDO", saldo);
			RequestDispatcher rd = request.getRequestDispatcher("/Caja-de-Ahorro.jsp");
			rd.forward(request, response);
		}
		
		if(request.getParameter("btnCUENTACORRIENTE")!=null)
		{
			//Se hizo click en el boton Seleccionar Cuenta
			
			String nroCBU = request.getParameter("nroCBU").toString();
			String saldo = request.getParameter("saldo").toString();
			
			ArrayList<Movimientos> listaMovimientos = (ArrayList<Movimientos>)MyCneg.traerMovimientosxCuenta_CA(nroCBU);
			request.setAttribute("listaMovimientos", listaMovimientos);
			request.setAttribute("CBU", nroCBU);
			request.setAttribute("SALDO", saldo);
			RequestDispatcher rd = request.getRequestDispatcher("/Cuenta-Corriente.jsp");
			rd.forward(request, response);
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//																TRANSFERENCIAS PROPIAS															//
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if(request.getParameter("btnTransferir")!=null)
		{
			String valorRadio = request.getParameter("salida");												//Guardo el Value del RadioButton seleccionado
			String valorRadio2 = request.getParameter("destino");											//Guardo el Value del RadioButton seleccionado
			float monto = Float.parseFloat(request.getParameter("txtMonto"));								//Guardo el monto a querer Transferir
			
			Cuentas cSalida = new Cuentas();																//Creo objeto Cuenta para obtener Cuenta de Salida
			Cuentas cDestino = new Cuentas();																//Creo objeto Cuenta para obtener Cuenta de Destino
			
			// Traigo las Cuentas
			cSalida = MyCneg.traerCuenta(valorRadio);														//Busco y pego Cuenta de Salida
			cDestino = MyCneg.traerCuenta(valorRadio2);														//Busco y pego Cuenta de Destubi
			
			// Consulto si las Cuentas seleccionadas son las mismas
			if(valorRadio.equals(valorRadio2))
			{
				boolean iguales = true;
				request.setAttribute("sonIguales", iguales);
				RequestDispatcher rd = request.getRequestDispatcher("/Transferencia-Propia.jsp");
				rd.forward(request, response);
			}
			
			// Pregunto si lo que tengo es menor a lo que quiero transferir
			else if(cSalida.getSaldo() < monto)
			{
				boolean menor = true;
				request.setAttribute("esMenor", menor);
				RequestDispatcher rd = request.getRequestDispatcher("/Transferencia-Propia.jsp");
				rd.forward(request, response);
			}
			else
			{	
				// Poner Date para la Fecha
				Date fecha = new Date();
				SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
				String fechaActual = formateador.format(fecha);
			
				// Guardar el Saldo en una variable y restarle/sumarle el Monto
				float saldoSalida = cSalida.getSaldo();
				float saldoDestino = cDestino.getSaldo();
			
				saldoSalida = saldoSalida - monto;
				saldoDestino = saldoDestino + monto;
			
				// Setear denuevo el Saldo
				cSalida.setSaldo(saldoSalida);
				cDestino.setSaldo(saldoDestino);
			
				// Guardar los Cambios en Cuenta
				MyCneg.actualizarCuenta(cSalida);
				MyCneg.actualizarCuenta(cDestino);
			
				// Crear Objeto Movimientos y agrego en la Tabla Movimientos
				Movimientos m1 = new Movimientos(); 			//Para la Salida de la Transaccion
				Movimientos m2 = new Movimientos();				//Para el Destino de la Transaccion
				TipoMovimientos tM = new TipoMovimientos();		//Para setear el ID Tipo Movimiento
			
				m1.setDNI(cSalida.getDNI());
					tM.setIdTipo(4);
				m1.settMove(tM);
				m1.setFecha(fechaActual);
				m1.setImporte(monto);
				m1.setObtener_cbu(cSalida);
			
				MyCneg.agregarMovimiento(m1);					//Agrego Movimiento
			
				m2.setDNI(cDestino.getDNI());
					tM.setIdTipo(7);
				m2.settMove(tM);
				m2.setFecha(fechaActual);
				m2.setImporte(monto);
				m2.setObtener_cbu(cDestino);
		
				MyCneg.agregarMovimiento(m2);					//Agrego Movimiento
					
				boolean agrego = true;
				request.setAttribute("agrego", agrego);
				RequestDispatcher rd = request.getRequestDispatcher("/Transferencia-Propia.jsp");
				rd.forward(request, response);
			}
		}
		
	}

}

