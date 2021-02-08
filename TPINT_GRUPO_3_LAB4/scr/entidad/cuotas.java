package entidad;

public class cuotas {

	private int idcuotas;
	private String nrocuota;
	private String fecha;
	private float importe;
	private String cbu;
	private String dni;
	
	public String getDni() {
		return dni;
	}
	public void setDni(String dni) {
		this.dni = dni;
	}
	public String getCbu() {
		return cbu;
	}
	public void setCbu(String cbu) {
		this.cbu = cbu;
	}
	public float getImporte() {
		return importe;
	}
	public void setImporte(float importe) {
		this.importe = importe;
	}
	public int getIdcuotas() {
		return idcuotas;
	}
	public void setIdcuotas(int idcuotas) {
		this.idcuotas = idcuotas;
	}
	public String getNrocuota() {
		return nrocuota;
	}
	public void setNrocuota(String nrocuota) {
		this.nrocuota = nrocuota;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	
}
