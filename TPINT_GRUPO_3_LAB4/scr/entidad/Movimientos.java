package entidad;

import java.util.Date;

public class Movimientos {

	private int DNI;
	private TipoMovimientos tMove = new TipoMovimientos();
	private String fecha;
	private float importe;
	private Cuentas obtener_cbu = new Cuentas();
	
	public Movimientos() {
		
	}

	public int getDNI() {
		return DNI;
	}

	public void setDNI(int dNI) {
		DNI = dNI;
	}

	public TipoMovimientos gettMove() {
		return tMove;
	}

	public void settMove(TipoMovimientos tMove) {
		this.tMove = tMove;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public float getImporte() {
		return importe;
	}

	public void setImporte(float importe) {
		this.importe = importe;
	}

	public Cuentas getObtener_cbu() {
		return obtener_cbu;
	}

	public void setObtener_cbu(Cuentas obtener_cbu) {
		this.obtener_cbu = obtener_cbu;
	}
	
	
}
