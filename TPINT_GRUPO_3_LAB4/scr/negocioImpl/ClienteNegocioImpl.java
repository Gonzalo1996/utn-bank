package negocioImpl;

import dao.ClienteDAO;
import java.util.List;
import daoImpl.ClienteDAOlmpl;
import entidad.Cliente;
import negocio.ClienteNegocio;

public class ClienteNegocioImpl implements ClienteNegocio{

	ClienteDAO cliDao = new ClienteDAOlmpl();
	
	public boolean agregarCliente(Cliente cliente) {
		boolean estado = false;
		
		estado = cliDao.agregarCliente(cliente);
		
		return estado;
	}
	
	public int Loguear(String us,String pass) {
		return cliDao.Loguear(us, pass);
	}

	public List<Cliente> traerClientes(){
		return cliDao.traerClientes();
	}

	public boolean modificar(String dni, String nombre, String apellido, String cuil, String fecha, String sexo, String nacio, String prov, String local, String direc, String mail, String pass, String usuario) {
		boolean estado = false;
		
		estado = cliDao.modificar(dni, nombre,apellido,cuil,fecha,sexo,nacio,prov,local,direc,mail,pass, usuario);
		
		return estado;
	}

	public void eliminarCliente(String dni) {

		cliDao.eliminarCliente(dni);
		
	}
	
	public void restaurarCliente(String dni) {

		cliDao.restaurarCliente(dni);
		
	}

	public boolean verificarDni(String dni) {
		boolean estado = false;
		
		estado = cliDao.verificarDni(dni);
		
		return estado;
	}
	
	public List<Cliente> Filtrar (String texto) {
		
	return  cliDao.Filtrar(texto);
		
	}

	public Cliente obtenerCliente(String user) {

		return cliDao.obtenerCliente(user);
	}

	public float totalCuentas(String dni) {
		float total = 0;
		total = totalCuentas(dni); 
		return total;
	}
	
	public float MontoTotalMovimientos() {
		float total = 0;
		total = MontoTotalMovimientos();
		return total;
	}

	public float MontoTotal_TipoMovimientos(int tipoMov, String fechaDesde, String fechaHasta) {
		float total = 0;
		total = MontoTotal_TipoMovimientos(tipoMov, fechaDesde, fechaHasta);
		return total;
	}

}

