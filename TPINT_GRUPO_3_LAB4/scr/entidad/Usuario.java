package entidad;

public class Usuario {

	private String UserName;
	private String pass;
	private TipoUsuario tUser = new TipoUsuario();
	
	public Usuario() {
		
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String userName) {
		UserName = userName;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public TipoUsuario gettUser() {
		return tUser;
	}

	public void settUser(TipoUsuario tUser) {
		this.tUser = tUser;
	}
	
	
}
