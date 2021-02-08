package negocioImpl;

import java.util.List;

import dao.Movimientos_y_CuentasDAO;
import daoImpl.Movimientos_y_CuentasDAOImpl;
import entidad.Cuentas;
import entidad.Movimientos;
import negocio.Movimientos_y_CuentasNegocio;

public class Movimientos_y_CuentasNegocioImpl implements Movimientos_y_CuentasNegocio{

	Movimientos_y_CuentasDAO MyCdao = new Movimientos_y_CuentasDAOImpl();
	
	////////////////////////////////////	CAJA DE AHORRO	  		////////////////////////////////////////////////////////////
	@Override
	public List<Cuentas> traerCuentasxCliente_CA(String dni) {
		return MyCdao.traerCuentasxCliente_CA(dni);
	}

	@Override
	public List<Movimientos> traerMovimientosxCuenta_CA(String cbu) {
		return MyCdao.traerMovimientosxCuenta_CA(cbu);
	}

	////////////////////////////////////	CUENTA CORRIENTE	  	////////////////////////////////////////////////////////////
	
	@Override
	public List<Cuentas> traerCuentasxCliente_CC(String dni) {
		return MyCdao.traerCuentasxCliente_CC(dni);
	}

	@Override
	public List<Movimientos> traerMovimientosxCuenta_CC(String cbu) {
		return MyCdao.traerMovimientosxCuenta_CC(cbu);
	}

	////////////////////////////////////	TRANSFERENCIAS PROPIAS	////////////////////////////////////////////////////////////
	
	@Override
	public List<Cuentas> traerTodaslasCuentas(String dni) {
		return MyCdao.traerTodaslasCuentas(dni);
	}

	@Override
	public Cuentas traerCuenta(String nroCuenta) {
		return MyCdao.traerCuenta(nroCuenta);
	}

	@Override
	public void actualizarCuenta(Cuentas c) {
		MyCdao.actualizarCuenta(c);
	}

	@Override
	public void agregarMovimiento(Movimientos m) {
		MyCdao.agregarMovimiento(m);
	}

	
	public List<Cuentas> NumerosCuentas(int dni){
		return MyCdao.NumerosCuentas(dni);
	}
	
	public List<Movimientos> traerMovimientos_X_Cuentas(){
		return MyCdao.traerMovimientos_X_Cuentas();
	}

	@Override
	public void agregarMovimiento(int dni, int tipoMov, String fechaTrans, double monto, String cbuGuardar) {
		// TODO Auto-generated method stub
		MyCdao.agregarMovimiento(dni, tipoMov, fechaTrans, monto, cbuGuardar);
		
	}
}
