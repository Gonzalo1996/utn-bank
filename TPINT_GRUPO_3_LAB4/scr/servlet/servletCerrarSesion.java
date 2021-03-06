package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/servletCerrarSesion")
public class servletCerrarSesion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public servletCerrarSesion() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("Param")!=null)
		{
			//Entra por haber hecho clic en el hyperlink Cerrar Sesion
			
			HttpSession sesion = request.getSession();
			sesion.removeAttribute("cliente");
			response.sendRedirect("IngresoUsuario.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
