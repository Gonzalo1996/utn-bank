package negocioImpl;

import java.util.List;

import dao.PrestamosDAO;
import daoImpl.PrestamosDAOImpl;
import entidad.Cuentas;
import entidad.Prestamos;
import entidad.cuotas;
import negocio.PrestamosNegocio;

public class PrestamosNegocioImpl implements PrestamosNegocio {

	PrestamosDAO preDao = new PrestamosDAOImpl();
	
	
	public List<Prestamos> traerPrestamos(int dni){
		return preDao.traerPrestamos(dni);
		
	}


	public boolean agregarCuota(float x,String id, String nro,String imp,String cbu,String dni) {
		boolean estado =false;
		
		estado= preDao.agregarCuota(x,id, nro,imp,cbu,dni);
		return estado;
	}


	public List<cuotas> traerCuotas(int dni){
		
		return preDao.traerCuotas( dni);
	}
	
	
	public String obtenercbu(String cuenta) {
		return preDao.obtenercbu(cuenta);
	}
	
	public String obtenerUltimoid() {
		return preDao.obtenerUltimoid();
	}
	
	public boolean agregarSolicitud(String id, String cuotas, String cbu, String monto, String dni) {
		
		return preDao.agregarSolicitud(id, cuotas, cbu, monto, dni);
	}
	
	public List<Prestamos> traerPrestamoss(){
		return preDao.traerPrestamoss();
	}
	
	public boolean modifest(int dni,Float x,String id,String idcbu,String idimp){
	return preDao.modifest(dni,x,id,idcbu,idimp);	
	}
	
	public boolean modifestr(String id) {
		
		return preDao.modifestr(id);
	}
	
	public Cuentas traerCuenta(String idcbu) {
		return preDao.traerCuenta(idcbu);
	}
	
}
