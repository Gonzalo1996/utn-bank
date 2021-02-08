package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClienteDAO;
import daoImpl.ClienteDAOlmpl;
import entidad.Cliente;
import negocio.ClienteNegocio;
import negocioImpl.ClienteNegocioImpl;


@WebServlet("/servletClientes")
public class servletClientes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public servletClientes() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		
		
		
		
		if(request.getParameter("btnVerificarImporte") != null)
		{
			/*
			SimpleDateFormat sdf = new SimpleDateFormat("dd/mm/yyyy");
			Date fechaDes = new Date("20/11/2020");
			Date fechaHas = new Date("23/11/2020");
			String fechaDesde = sdf.format(fechaDes);
			String fechaHasta = sdf.format(fechaHas);
			*/
			String fechaDesde = request.getParameter("fechaDesde");
			String fechaHasta = request.getParameter("fechaHasta");
			int tipoMov = Integer.parseInt(request.getParameter("tipoMov"));
			ClienteDAO cNeg = new ClienteDAOlmpl();
			
			if(tipoMov != 0)
			{
				float montoTipoMovimientos = cNeg.MontoTotal_TipoMovimientos(tipoMov,fechaDesde,fechaHasta); //"20/11/2020", "23/11/2020");
				
				request.setAttribute("montoTotal", montoTipoMovimientos);
				request.setAttribute("tipoMov",tipoMov);
				RequestDispatcher rd = request.getRequestDispatcher("/Informes_Estadisticas.jsp");
				rd.forward(request, response);
			}
			else
			{
				boolean tipoMovNull = true;
				request.setAttribute("tipoMovNul", tipoMovNull);
				RequestDispatcher rd = request.getRequestDispatcher("/Informes_Estadisticas.jsp");
				rd.forward(request, response);
			}
			
			/*
			ClienteNegocio cNeg = new ClienteNegocioImpl();
			float montoTotMovimientos = cNeg.MontoTotalMovimientos();
			
			request.setAttribute("montoTotal", montoTotMovimientos);
			RequestDispatcher rd = request.getRequestDispatcher("/Informes_Estadisticas.jsp");
			rd.forward(request, response);
			
			
			float montoTotMovimientos = 200;
			
			request.setAttribute("montoTotal", montoTotMovimientos);
			RequestDispatcher rd = request.getRequestDispatcher("/Informes_Estadisticas.jsp");
			rd.forward(request, response);
			*/
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ClienteNegocio cNeg = new ClienteNegocioImpl();
		
		if(request.getParameter("btnConfirmar") != null)
		{
			boolean insert = false;
			boolean existe = cNeg.verificarDni(request.getParameter("txtDni"));
			
			if(existe == false)
			{
				int dni = Integer.parseInt(request.getParameter("txtDni"));
			
				Cliente clientes = new Cliente();
			
				clientes.setDNI(dni);
				clientes.setCUIL(request.getParameter("txtCuil"));
				clientes.setNombre(request.getParameter("txtNombre"));
				clientes.setApellido(request.getParameter("txtApellido"));
				clientes.setFecha(request.getParameter("txtFechaNac"));
				clientes.setSexo(request.getParameter("txtSexo"));
				clientes.setNacionalidad(request.getParameter("txtNacio"));
				clientes.setProvincia(request.getParameter("txtProv"));
				clientes.setLocalidad(request.getParameter("txtLocal"));
				clientes.setDireccion(request.getParameter("txtDirecc"));
				clientes.setMail(request.getParameter("txtEmail"));
				clientes.setUserName(request.getParameter("txtUsuario"));
				clientes.setPass(request.getParameter("txtContra"));

				insert = cNeg.agregarCliente(clientes);
				request.setAttribute("isInserted", insert);
			
				RequestDispatcher rd = request.getRequestDispatcher("/Agregar_Cliente.jsp");
				rd.forward(request, response);
			}
			else
			{
				String ya_existe = "ya existe";
				request.setAttribute("noInserted", ya_existe);
			
				RequestDispatcher rd = request.getRequestDispatcher("/Agregar_Cliente.jsp");
				rd.forward(request, response);
			}
		}
		
		if(request.getParameter("btnModificar")!=null)
		{
			
			Cliente cliente = new Cliente();
			String pass = request.getParameter("passCliente");	
			String dni = request.getParameter("dniCliente");
			String nombre = request.getParameter("nombreCliente");
			String apellido = request.getParameter("apellidoCliente");
			String cuil = request.getParameter("cuilCliente");
			String fecha = request.getParameter("fechaCliente");
			String sexo = request.getParameter("sexoCliente");
			String nacion = request.getParameter("nacionalidadCliente");
			String direc = request.getParameter("direccionCliente");
			String localidad = request.getParameter("localidadCliente");
			String prov = request.getParameter("provinciaCliente");
			String mail = request.getParameter("mailCliente"); 
			String user = request.getParameter("userCliente");
			
			cliente.setPass(pass);
			cliente.setDNI(Integer.parseInt(dni));
			cliente.setNombre(nombre);
			cliente.setApellido(apellido);
			cliente.setCUIL(cuil);
			cliente.setFecha(fecha);
			cliente.setSexo(sexo);
			cliente.setNacionalidad(nacion);
			cliente.setDireccion(direc);
			cliente.setLocalidad(localidad);
			cliente.setProvincia(prov);
			cliente.setMail(mail);
			cliente.setUserName(user);
			
					
				//cNeg.modificarUsuario(dni, pass);
			
			//ArrayList<Cliente> listaClientes = (ArrayList<Cliente>)cNeg.traerClientes();
			
			request.setAttribute("cliente", cliente);
			RequestDispatcher rd = request.getRequestDispatcher("/ModificarCliente.jsp");
			rd.forward(request, response);
				
		}
		
		if(request.getParameter("btnEliminar")!=null)
		{
			String dni = request.getParameter("dniCliente").toString();
			
			cNeg.eliminarCliente(dni);
			
			ArrayList<Cliente> listaClientes = (ArrayList<Cliente>)cNeg.traerClientes();
			request.setAttribute("listaClientes", listaClientes);
			RequestDispatcher rd = request.getRequestDispatcher("/Clientes.jsp");
			rd.forward(request, response);
		}
		
		if(request.getParameter("btnRestaurar")!=null)
		{
			String dni = request.getParameter("dniCliente").toString();
			
			cNeg.restaurarCliente(dni);
			
			ArrayList<Cliente> listaClientes = (ArrayList<Cliente>)cNeg.traerClientes();
			request.setAttribute("listaClientes", listaClientes);
			RequestDispatcher rd = request.getRequestDispatcher("/Clientes.jsp");
			rd.forward(request, response);
		}
		
		if(request.getParameter("btnMod")!=null) {
			
			String dni = request.getParameter("txtDni");
			String nombre = request.getParameter("txtNombre");
			String apellido = request.getParameter("txtApellido");
			String cuil = request.getParameter("txtCuil");
			String fecha= request.getParameter("txtFechaNac");
			String sexo = request.getParameter("txtSexo");
			String nacio=request.getParameter("txtNacio");
			String prov = request.getParameter("txtProv");
			String local= request.getParameter("txtLocal");
			String direc= request.getParameter("txtDirecc");
			String mail = request.getParameter("txtEmail");
			String pass = request.getParameter("txtContra");
			
			String usuario = request.getParameter("txtUsuario");
			
			boolean modified = false;
			
			modified = cNeg.modificar(dni,nombre,apellido,cuil,fecha,sexo,nacio,prov,local,direc,mail,pass,usuario);
			
			ArrayList<Cliente> listaClientes = (ArrayList<Cliente>)cNeg.traerClientes();
			request.setAttribute("listaClientes", listaClientes);
			request.setAttribute("isModified", modified);
			RequestDispatcher rd = request.getRequestDispatcher("/Clientes.jsp");
			rd.forward(request, response);
			
		}
		
		if(request.getParameter("btnFiltro")!=null)
		{
			String texto = request.getParameter("txtFiltro");
			
			//cNeg.eliminarCliente(dni);
			ArrayList<Cliente> listaClientes = (ArrayList<Cliente>)cNeg.Filtrar(texto);
			
			//ArrayList<Cliente> listaClientes = (ArrayList<Cliente>)cNeg.traerClientes();
			request.setAttribute("listaClientes", listaClientes);
			RequestDispatcher rd = request.getRequestDispatcher("/Clientes.jsp");
			rd.forward(request, response);
		}
		
		
		
	}

}
