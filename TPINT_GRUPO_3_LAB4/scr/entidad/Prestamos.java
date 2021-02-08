package entidad;

import java.util.Date;

public class Prestamos {

	

	private int idPrestamo;
	private int DNI;
	private String fecha;
	private float imp_pedido;
	private float imp_a_pagar;
	private int plazo_pago;
	private String estado; //Para las opciones PENDIENTE - AUTORIZADO - RECHAZADO
	private Cuentas obtener_cbu = new Cuentas();
	private int nro_cuota;
	
	public Prestamos() {
		
	}

	public int getIdPrestamo() {
		return idPrestamo;
	}

	public void setIdPrestamo(int idPrestamo) {
		this.idPrestamo = idPrestamo;
	}

	public int getDNI() {
		return DNI;
	}

	public void setDNI(int dNI) {
		DNI = dNI;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public float getImp_pedido() {
		return imp_pedido;
	}

	public void setImp_pedido(float imp_pedido) {
		this.imp_pedido = imp_pedido;
	}

	public float getImp_a_pagar() {
		return imp_a_pagar;
	}

	public void setImp_a_pagar(float imp_a_pagar) {
		this.imp_a_pagar = imp_a_pagar;
	}

	public int getPlazo_pago() {
		return plazo_pago;
	}

	public void setPlazo_pago(int plazo_pago) {
		this.plazo_pago = plazo_pago;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public Cuentas getObtener_cbu() {
		return obtener_cbu;
	}

	public void setObtener_cbu(Cuentas obtener_cbu) {
		this.obtener_cbu = obtener_cbu;
	}

	public int getNro_cuota() {
		return nro_cuota;
	}

	public void setNro_cuota(int nro_cuota) {
		this.nro_cuota = nro_cuota;
	}
	
	
	
	
}

