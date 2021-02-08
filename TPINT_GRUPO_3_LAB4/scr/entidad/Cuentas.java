package entidad;

public class Cuentas {

	private int DNI;
	private Cliente cliente = new Cliente();
	private TipoCuenta tCuenta = new TipoCuenta();
	private String nro_cuenta;
	private String CBU;
	private String fecha_creacion;
	private float saldo;
	private String estado; //Para la "posible" Baja Lógica
	
	public Cuentas() {
		
	}

	public int getDNI() {
		return DNI;
	}

	public void setDNI(int dNI) {
		DNI = dNI;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public TipoCuenta gettCuenta() {
		return tCuenta;
	}

	public void settCuenta(TipoCuenta tCuenta) {
		this.tCuenta = tCuenta;
	}

	public String getNro_cuenta() {
		return nro_cuenta;
	}

	public void setNro_cuenta(String nro_cuenta) {
		this.nro_cuenta = nro_cuenta;
	}

	public String getCBU() {
		return CBU;
	}

	public void setCBU(String cBU) {
		CBU = cBU;
	}

	public String getFecha_creacion() {
		return fecha_creacion;
	}

	public void setFecha_creacion(String fecha_creacion) {
		this.fecha_creacion = fecha_creacion;
	}

	public float getSaldo() {
		return saldo;
	}

	public void setSaldo(float saldo) {
		this.saldo = saldo;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
	
	
}
