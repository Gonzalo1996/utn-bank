package dao;

import java.util.List;

import entidad.Cuentas;
import entidad.Movimientos;

public interface Movimientos_y_CuentasDAO {

	public List<Cuentas> traerCuentasxCliente_CA(String dni);
	public List<Movimientos> traerMovimientosxCuenta_CA(String cbu);
	
	public List<Cuentas> traerCuentasxCliente_CC(String dni);
	public List<Movimientos> traerMovimientosxCuenta_CC(String cbu);
	
	public List<Cuentas> traerTodaslasCuentas(String dni);
	
	public Cuentas traerCuenta(String nroCuenta);
	
	public void actualizarCuenta(Cuentas c);
	
	public void agregarMovimiento(Movimientos m);
	
	public List<Cuentas> NumerosCuentas(int dni);
    public List<Movimientos> traerMovimientos_X_Cuentas();
	public void agregarMovimiento(int dni, int tipoMov, String fechaTrans, double monto, String cbuGuardar);

}
