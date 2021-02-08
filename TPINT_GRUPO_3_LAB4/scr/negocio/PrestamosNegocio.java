package negocio;

import java.util.List;

import entidad.Cuentas;
import entidad.Prestamos;
import entidad.cuotas;

public interface PrestamosNegocio {
	public List<Prestamos> traerPrestamos(int dni);
	public boolean agregarCuota(float x,String id, String nro,String imp,String cbu,String dni);
	public List<cuotas> traerCuotas(int dni);
	public String obtenerUltimoid();
	public String obtenercbu(String cuenta);
	public boolean agregarSolicitud(String id, String cuotas, String cbu, String monto, String dni);
	public List<Prestamos> traerPrestamoss();
	public boolean modifest(int dni,Float x,String id,String idcbu,String idimp);
	public boolean modifestr(String id);
	public Cuentas traerCuenta(String idcbu);
}
