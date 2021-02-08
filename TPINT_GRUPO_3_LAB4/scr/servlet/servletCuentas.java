package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;

import entidad.Cliente;
import entidad.Cuentas;
import entidad.TipoCuenta;
import negocio.CuentasNegocio;
import negocioImpl.CuentasNegocioImpl;

import javax.servlet.http.HttpSession;

import negocio.Movimientos_y_CuentasNegocio;

import negocioImpl.Movimientos_y_CuentasNegocioImpl;


@WebServlet("/servletCuentas")
public class servletCuentas extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String cbuGuardar;
       

    public servletCuentas() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		///VARIABLES DATOS DE PERSONA A TRANSFERIR DINERO
		String cbu = " ";
		int dni = 0;
		String nombre = " ";
		String apellido = " ";
		String nroCuenta = " ";
		///VARIABLES DE TRANSFERENCIA
		double monto = 0;
		int tipoMov = 0;
		String fechaTrans = " ";
		String nroCuentaTrans = " ";
		
		HttpSession sesion = request.getSession(); //A
		CuentasNegocioImpl cNeg = new CuentasNegocioImpl();
		Cuentas cuenta = new Cuentas();
		Cliente cliente = new Cliente();
		Cliente c = (Cliente)sesion.getAttribute("cliente");

		Movimientos_y_CuentasNegocio MyCneg = new Movimientos_y_CuentasNegocioImpl();
        Date fecha = new Date();
        SimpleDateFormat formatofecha = new SimpleDateFormat("dd/MM/YYYY");
		
		
		if(request.getParameter("VerificarCBU")!=null) 
		{
			
			cbu = request.getParameter("txtCBU").toString();
			boolean existe = cNeg.verificarCuentaCBU(cbu); //GUARDO TRUE O FALSE PARA SABER SI HAY REGISTRO O NO. 
			cuenta = cNeg.obtenerCuenta(cbu);
			
			if(cuenta != null) {
				cliente = cNeg.obtenerDatosCliente(cuenta.getDNI());
			}
			
			
			if(existe == true )
			{
				///DATOS PARA ALMACENAR EN REGISTRO/////////
				///////////////////////////////////////////
				cbuGuardar = cuenta.getNro_cuenta();
				request.setAttribute("cuenta", existe);
				request.setAttribute("cuentaReg", cuenta);
				request.setAttribute("clienteReg", cliente);
				RequestDispatcher rd = request.getRequestDispatcher("/Transferencia-Otras-Cuentas.jsp");
				rd.forward(request, response);
			}
			else {
				request.setAttribute("cuenta", existe);
				RequestDispatcher rd = request.getRequestDispatcher("/Transferencia-Otras-Cuentas.jsp");
				rd.forward(request, response);
			}
		}
		
		//cbu = request.getParameter("cbuVerificado");
		if(request.getParameter("btnSolicitarPrestamo") != null)
		{	
				nroCuentaTrans = request.getParameter("dropCuenta");
				monto = Double.parseDouble(request.getParameter("txtMonto").toString());
	
				boolean verMonto = cNeg.verificarMonto(nroCuentaTrans, monto);//A 
	
				if(verMonto == true)
				{
					dni = c.getDNI();
					tipoMov = 6;
					fechaTrans = formatofecha.format(fecha);
					
					MyCneg.agregarMovimiento(dni, tipoMov, fechaTrans, monto, cbuGuardar);
					request.setAttribute("Monto", verMonto);
					RequestDispatcher rd = request.getRequestDispatcher("/Transferencia-Otras-Cuentas.jsp");
					rd.forward(request, response);
					
				}
				else {
					request.setAttribute("Monto", verMonto);
					RequestDispatcher rd = request.getRequestDispatcher("/Transferencia-Otras-Cuentas.jsp");
					rd.forward(request, response);	
				}	
		}}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CuentasNegocio cNeg = new CuentasNegocioImpl();
		
		if(request.getParameter("btnRegistrar")!=null) {
			
				String nroCuenta = request.getParameter("txtNumCuenta");
				boolean existe = cNeg.verificarCuenta(nroCuenta);				//Para Verificar que no exista el mismo numero de cuenta
			
				if(existe == false) 
				{
					Cuentas newCuenta = new Cuentas();
					TipoCuenta tC = new TipoCuenta();
			
					newCuenta.setDNI(Integer.parseInt(request.getParameter("txtDni")));
						tC.setIdTipo(Integer.parseInt(request.getParameter("tCuentas")));
						newCuenta.settCuenta(tC);
						newCuenta.setNro_cuenta(request.getParameter("txtNumCuenta"));
						newCuenta.setCBU(request.getParameter("txtCBU"));
						newCuenta.setFecha_creacion(request.getParameter("txtFechaReg"));
						newCuenta.setSaldo(10000);
						newCuenta.setEstado("Activo");
			
						boolean insert = false;
			
						insert = cNeg.agregarCuenta(newCuenta);
						request.setAttribute("isInserted", insert);
			
						RequestDispatcher rd = request.getRequestDispatcher("/Crear_Cuenta.jsp");
						rd.forward(request, response);
				}
				else if(existe == true)
				{	
					String ya_existe = "ya existe";
					request.setAttribute("noInserted", ya_existe);
			
					RequestDispatcher rd = request.getRequestDispatcher("/Crear_Cuenta.jsp");
					rd.forward(request, response);
				}
				else
				{
					String ya_existe = "ya existe";
					request.setAttribute("tiene3cuentas", ya_existe);
			
					RequestDispatcher rd = request.getRequestDispatcher("/Crear_Cuenta.jsp");
					rd.forward(request, response);
				}
		}
		
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
		if(request.getParameter("btnModificar")!=null)
		{
			//Se hizo click en el boton Mostrar Modificar Cuenta
			int dni = Integer.parseInt(request.getParameter("nroDNI").toString());
			String nombre = request.getParameter("nombre").toString();
			String apellido = request.getParameter("apellido").toString();
			String nroCuenta = request.getParameter("nroCuenta").toString();
			String nroCBU = request.getParameter("nroCBU").toString();
			
			Cuentas c = new Cuentas();
			Cliente C = new Cliente();
			
			C.setNombre(nombre);
			C.setApellido(apellido);
			
			c.setDNI(dni);
			c.setCliente(C);
			c.setNro_cuenta(nroCuenta);
			c.setCBU(nroCBU);
					
			request.setAttribute("CUENTA", c);
			
			RequestDispatcher rd = request.getRequestDispatcher("/ModificarCuenta.jsp");
			rd.forward(request, response);
		}
		
		if(request.getParameter("btnModify")!=null)
		{
			Cuentas modifiyCuenta = new Cuentas();
			TipoCuenta tC = new TipoCuenta();
	
			modifiyCuenta.setDNI(Integer.parseInt(request.getParameter("txtDni")));
				tC.setIdTipo(Integer.parseInt(request.getParameter("tCuentas")));
			modifiyCuenta.settCuenta(tC);
			modifiyCuenta.setCBU(request.getParameter("txtCBU"));
	
			boolean modified = false;
	
			modified = cNeg.modificarCuenta(modifiyCuenta);
			request.setAttribute("isModified", modified);
	
			RequestDispatcher rd = request.getRequestDispatcher("/Ver_Cuentas.jsp");
			rd.forward(request, response);
		}
		
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if(request.getParameter("btnFiltrar")!=null) {
			//Se hizo click en el boton Filtrar
			int id = Integer.parseInt(request.getParameter("tipoCuentas"));						//Copio el ID del Item seleccionado del Combobox
			
			 										
			ArrayList<Cuentas> listaCuentas = (ArrayList<Cuentas>)cNeg.obtenerCuentas_x_Filtro(id);	//Lo paso como parametro para que filtre en la BD
			
			request.setAttribute("listaCuentas", listaCuentas);
			
			RequestDispatcher rd = request.getRequestDispatcher("/Ver_Cuentas.jsp");
			rd.forward(request, response);
		}
		
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if(request.getParameter("btnMostrarTodo")!=null)
		{
				//Se hizo click en el boton Mostrar Todo
			 										
			ArrayList<Cuentas> listaCuentas = (ArrayList<Cuentas>)cNeg.traerCuentas();		//Pido todos los registros de Seguros de la BD
			
			request.setAttribute("listaCuentas", listaCuentas);
			
			RequestDispatcher rd = request.getRequestDispatcher("/Ver_Cuentas.jsp");
			rd.forward(request, response);
		}
		
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if(request.getParameter("btnBuscar")!=null)
		{
				//Se hizo click en el boton Mostrar Buscar

			int param = Integer.parseInt(request.getParameter("txtDNI"));
			
			ArrayList<Cuentas> listaCuentas = (ArrayList<Cuentas>)cNeg.traerCuentas_x_dni(param);		//Pido todos los registros de Seguros de la BD
		
			request.setAttribute("listaCuentas", listaCuentas);
			
			RequestDispatcher rd = request.getRequestDispatcher("/Ver_Cuentas.jsp");
			rd.forward(request, response);

		}
		
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
		if(request.getParameter("btnBloquear")!=null)
		{
			//Se hizo click en el boton Mostrar Bloquear Cuenta
			
			String nroCuenta = request.getParameter("nroCuenta").toString();
			cNeg.bloquearCuenta(nroCuenta);
			
			ArrayList<Cuentas> listaCuentas = (ArrayList<Cuentas>)cNeg.traerCuentas();
			request.setAttribute("listaCuentas", listaCuentas);
			RequestDispatcher rd = request.getRequestDispatcher("/Ver_Cuentas.jsp");
			rd.forward(request, response);
		}
		
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if(request.getParameter("btnDesbloquear")!=null)
		{
			//Se hizo click en el boton Mostrar Bloquear Cuenta
			
			String nroCuenta = request.getParameter("nroCuenta").toString();
			cNeg.desbloquearCuenta(nroCuenta);
			
			ArrayList<Cuentas> listaCuentas = (ArrayList<Cuentas>)cNeg.traerCuentas();
			request.setAttribute("listaCuentas", listaCuentas);
			RequestDispatcher rd = request.getRequestDispatcher("/Ver_Cuentas.jsp");
			rd.forward(request, response);
		}
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	

}

