package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entidad.Cuentas;
import entidad.Prestamos;
import negocio.PrestamosNegocio;
import negocioImpl.PrestamosNegocioImpl;

/**
 * Servlet implementation class servletPrestamos
 */
@WebServlet("/servletPrestamos")
public class servletPrestamos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletPrestamos() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrestamosNegocio pNeg = new PrestamosNegocioImpl();
		
		if(request.getParameter("btnPagar") !=null) {
			
			Prestamos pre = new Prestamos();
			String id = request.getParameter("idPres").toString();
			String nro = request.getParameter("nroCuota").toString();
			String imp = request.getParameter("impCuota").toString();
			String cbu = request.getParameter("cbu").toString();
			String dni = request.getParameter("dni").toString();
			
			
			boolean insert = false;
			boolean inserto = false;
			Cuentas cu = new Cuentas();
			
			cu = pNeg.traerCuenta(cbu);
			
			float x = cu.getSaldo()-Float.parseFloat(imp);
			
			if(x >= 0) {
			
			
			insert= pNeg.agregarCuota(x,id, nro, imp,cbu,dni);
			
			request.setAttribute("isInserted", insert);
			RequestDispatcher rd = request.getRequestDispatcher("/Consulta_Pago-Prestamos.jsp");
			rd.forward(request, response);	
			}
			else {
				inserto = true;
				request.setAttribute("isInserto", inserto);
				RequestDispatcher rd = request.getRequestDispatcher("/Consulta_Pago-Prestamos.jsp");
				rd.forward(request, response);	
			}
			
					
			
		}
		
		
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if(request.getParameter("btnSolicitarPrestamo") !=null) {
			Prestamos pre =  new Prestamos();
			
			String id = pNeg.obtenerUltimoid();
			String cuotas = request.getParameter("cuotas");
			String cuenta = request.getParameter("cuentas");
			String cbu = pNeg.obtenercbu(cuenta);
			//String cbu = "0000";
			String monto = request.getParameter("monto");
			String dni = request.getParameter("dni");
			
			boolean insert = false;
			
			insert= pNeg.agregarSolicitud(id,cuotas,cbu,monto,dni);
			
			
			request.setAttribute("isInserted", insert);
			RequestDispatcher rd = request.getRequestDispatcher("/Solicitud-Prestamo.jsp");
			rd.forward(request, response);	
			
			
		}
		
		if(request.getParameter("btnAceptar") != null) {
			Prestamos pre = new Prestamos();
			String id = request.getParameter("idPres");
			String idcbu = request.getParameter("idcbu");
			String idimp = request.getParameter("idimp");
			
			
			boolean insert = false;
			
			Cuentas cu = new Cuentas();
			
			cu = pNeg.traerCuenta(idcbu);
			float x = cu.getSaldo() + Float.parseFloat(idimp);
			int dni = cu.getDNI();
		
			insert = pNeg.modifest(dni,x,id,idcbu,idimp);
			
			
			
			request.setAttribute("isInserted", insert);
			RequestDispatcher rd = request.getRequestDispatcher("/Prestamos.jsp");
			rd.forward(request, response);	
			
			
			
		}
		
		
		
		
		if(request.getParameter("btnRechazar") != null) {
			Prestamos pre = new Prestamos();
			String id = request.getParameter("idPres");
			
			boolean insert = false;
			
			insert = pNeg.modifestr(id);
			
			
			request.setAttribute("isInserted", insert);
			RequestDispatcher rd = request.getRequestDispatcher("/Prestamos.jsp");
			rd.forward(request, response);	
			
			
			
		}
		
		
		
		
		
		
		
	}

	

}
