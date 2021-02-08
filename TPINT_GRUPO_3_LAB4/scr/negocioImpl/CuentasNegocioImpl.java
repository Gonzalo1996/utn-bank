package negocioImpl;

import java.util.List;

import dao.CuentasDao;
import daoImpl.CuentasDaoImpl;
import entidad.Cliente;
import entidad.Cuentas;
import entidad.TipoCuenta;
import negocio.CuentasNegocio;

public class CuentasNegocioImpl implements CuentasNegocio{

	CuentasDao cDAO = new CuentasDaoImpl();
	
	
	public boolean agregarCuenta(Cuentas cuenta) {
		boolean estado = false;
		if(cuenta.getNro_cuenta().trim().length()>0 && cuenta.getCBU().trim().length()>0)
		{
			estado = cDAO.agregarCuenta(cuenta);
		}
		return estado;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<TipoCuenta> traerTiposCuentas() {
		return cDAO.traerTiposCuentas();
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<Cliente> traerClientes() {
		return cDAO.traerClientes();
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<Cuentas> traerCuentas() {
		return cDAO.traerCuentas();
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<Cuentas> obtenerCuentas_x_Filtro(int id) {
		return cDAO.obtenerCuentas_x_Filtro(id);
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<Cuentas> traerCuentas_x_dni(int param) {
		return cDAO.traerCuentas_x_dni(param);
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void bloquearCuenta(String nroCuenta) {
		cDAO.bloquearCuenta(nroCuenta);
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void desbloquearCuenta(String nroCuenta) {
		cDAO.desbloquearCuenta(nroCuenta);
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public boolean verificarCuenta(String nroCuenta) {
		boolean estado = false;
		
		estado = cDAO.verificarCuenta(nroCuenta);
		
		return estado;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public int verificar_Cant_Cuentas(String dni) {
		int estado = 0;
		
		estado = cDAO.verificar_Cant_Cuentas(dni);
		
		return estado;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////

	public boolean modificarCuenta(Cuentas cuenta) {
		boolean estado = false;
		
		estado = cDAO.modificarCuenta(cuenta);
		
		return estado;
	}
	
	///////////////////////////////////////
public Cuentas obtenerCuenta(String cbu) {
		
		return cDAO.obtenerCuenta(cbu);
	}

////////////////////////////////////////////////

public Cliente obtenerDatosCliente(int dni) {
	
	return cDAO.obtenerDatosCliente(dni);
}

////////////////////////////////////////////////

public boolean verificarMonto(String nroCuenta, double monto) {
	
	return cDAO.verificarMonto(nroCuenta, monto);
}

///////////////////////////////////////////////////

public boolean verificarCuentaCBU(String cbu) {
	
	boolean estado = false;
	
	estado = cDAO.verificarCuentaCBU(cbu);
	
	return estado;
}


public List<Cuentas> listcuent(String texto){
	return cDAO.listcuent(texto);
	
}
///////////////////////////////////////////////////////////
public List<Integer> traerTotalesCuentas() {
	return cDAO.traerTotalesCuentas();
}


public List<Integer> traerTotalesMovimientos() {
	return cDAO.traerTotalesMovimientos();
}

}
