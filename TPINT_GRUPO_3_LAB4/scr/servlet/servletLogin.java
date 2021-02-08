package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cliente;
import negocio.ClienteNegocio;
import negocioImpl.ClienteNegocioImpl;

@WebServlet("/servletLogin")

public class servletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public servletLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		ClienteNegocio usuario = new ClienteNegocioImpl();
		
		if(request.getParameter("btnIngresar") != null)
		{
			String nombre = request.getParameter("txtUsuario");
			String contra = request.getParameter("txtPass");
			HttpSession sesion = request.getSession();
			
			switch (usuario.Loguear(nombre, contra)) {
			case 1:
				sesion.setAttribute("user", nombre);
				sesion.setAttribute("tipo", "1");
				response.sendRedirect("Inicio_Admin.jsp");
				
				break;
			case 2:
				
				Cliente cli = usuario.obtenerCliente(nombre);
				
				if(cli.getEstado().equals("Activo")) {
					sesion.setAttribute("cliente", cli);
					response.sendRedirect("Inicio_Usuario.jsp");
				}
				else {
					boolean login = true;
					request.setAttribute("isLogin", login);
					RequestDispatcher rd = request.getRequestDispatcher("/IngresoUsuario.jsp");
					rd.forward(request, response);
				}
				
				break;

			default:
				boolean login = true;
				request.setAttribute("isLogin", login);
				RequestDispatcher rd = request.getRequestDispatcher("/IngresoUsuario.jsp");
				rd.forward(request, response);
				break;
			}
		}
	
	}
}
