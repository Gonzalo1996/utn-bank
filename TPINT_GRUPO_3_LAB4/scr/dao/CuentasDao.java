package dao;

import java.util.List;
import entidad.Cliente;
import entidad.Cuentas;
import entidad.TipoCuenta;

public interface CuentasDao {

	public boolean agregarCuenta(Cuentas cuenta);
	
	public List<TipoCuenta> traerTiposCuentas();
	public List<Cliente> traerClientes();
	public List<Cuentas> traerCuentas();
	public List<Cuentas> obtenerCuentas_x_Filtro(int id);
	public List<Cuentas> traerCuentas_x_dni(int param);
	public void bloquearCuenta(String nroCuenta);
	public void desbloquearCuenta(String nroCuenta);
	public boolean verificarCuenta(String nroCuenta);
	public int verificar_Cant_Cuentas(String dni);
	public boolean modificarCuenta(Cuentas cuenta);
	public Cuentas obtenerCuenta(String cbu);
	public Cliente obtenerDatosCliente(int dni);
	public boolean verificarMonto(String nroCuenta, double monto);
	public boolean verificarCuentaCBU(String cbu);
	public List<Cuentas> listcuent(String texto);
	public List<Integer> traerTotalesCuentas();
	public List<Integer> traerTotalesMovimientos();
}
