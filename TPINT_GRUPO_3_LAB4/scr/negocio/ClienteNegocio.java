package negocio;

import entidad.Cliente;
import java.util.List;

public interface ClienteNegocio {

	public boolean agregarCliente(Cliente cliente);
	public int Loguear(String us,String pass);
	public Cliente obtenerCliente (String user);
	public float totalCuentas(String dni);

	public List<Cliente> traerClientes();
	public boolean modificar(String dni, String nombre, String apellido, String cuil, String fecha, String sexo, String nacio, String prov, String local, String direc, String mail, String pass, String usuario);
	
	public void eliminarCliente(String dni);
	public void restaurarCliente(String dni);
	
	public boolean verificarDni(String dni);
	public List<Cliente> Filtrar (String texto);
	public float MontoTotalMovimientos();
	public float MontoTotal_TipoMovimientos(int tipoMov, String fechaDesde, String fechaHasta);
}
