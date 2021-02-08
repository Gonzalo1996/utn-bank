package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.ClienteDAO;
import entidad.Cliente;


public class ClienteDAOlmpl implements ClienteDAO {

	private static final String obtenerCliente = "SELECT * FROM clientes WHERE NombreUsuario = ";
	
	private static final String addCliente = "INSERT INTO clientes (dniCliente,Nombre,Apellido,Fecha_Nac,Sexo,Cuil,Nacionalidad,Provincia,Localidad,Direccion,Mail,NombreUsuario,Contraseña,estado)"
											+"VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String addUser = "INSERT INTO usuarios (Usuario, Contraseña, tipo_usuario) VALUES (?, ?, ?)";
	private static final String leerClientes = "SELECT * FROM clientes";
	private static final String actualizarClientes = "UPDATE clientes SET Contraseña=?,Nombre=?,Apellido=?,Fecha_Nac=?,Sexo=?,Cuil=?,Nacionalidad=?,Provincia=?,Localidad=?,Direccion=?,Mail=? WHERE dniCliente=?";
	private static final String modificarContraseña = "UPDATE usuarios SET Contraseña=? WHERE Usuario=?";
	private static final String bloquear_desbloquear_cliente = "UPDATE clientes SET estado=? WHERE dniCliente= ?";
	private static final String verificarDni = "SELECT dniCliente FROM clientes WHERE dniCliente = ?";
	private static final String Filtrar = "SELECT * FROM clientes WHERE Nombre LIKE ?";
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public boolean agregarCliente(Cliente cliente) {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean isInsertExitoso = false;
		int resultado_Update = 0;
		try
		{
			statement = conexion.prepareStatement(addCliente);
			statement.setString(1, Integer.toString(cliente.getDNI()));
			statement.setString(2, cliente.getNombre());
			statement.setString(3, cliente.getApellido());
			statement.setString(4, cliente.getFecha());
			statement.setString(5, cliente.getSexo());
			statement.setString(6, cliente.getCUIL());
			statement.setString(7, cliente.getNacionalidad());
			statement.setString(8, cliente.getProvincia());
			statement.setString(9, cliente.getLocalidad());
			statement.setString(10, cliente.getDireccion());
			statement.setString(11, cliente.getMail());
			statement.setString(12, cliente.getUserName());
			statement.setString(13, cliente.getPass());
			statement.setString(14, "Activo");

			if(statement.executeUpdate() > 0)
			{
				resultado_Update++;
			}
			
			statement = conexion.prepareStatement(addUser);
			
			statement.setString(1, cliente.getUserName());
			statement.setString(2, cliente.getPass());
			statement.setInt(3, 2);
			
			if(statement.executeUpdate() > 0)
			{
				resultado_Update++;
			}
			
			if(resultado_Update == 2)
			{
				conexion.commit();
				isInsertExitoso = true;
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
			try {
				conexion.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
		return isInsertExitoso;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public int Loguear(String use,String pass) {
			
		Conexion conn = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		int tipoUsuario = 0;
		String sql = "SELECT * FROM usuarios WHERE Usuario = '" + use + "' AND Contraseña = '" + pass + "'";
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = Conexion.getConexion();
			pst = conn.getSQLConexion().prepareStatement(sql);
			rs = pst.executeQuery();
			
			while (rs.next()) {
				tipoUsuario = rs.getInt("tipo_usuario");
			}
			rs.close();
			pst.close();
			conn.cerrarConexion();
		}catch(ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
		
		
		return tipoUsuario;
		
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<Cliente> traerClientes() {
		//Levanta el JAR (Para el JSP)
		try {
		Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
		}

		PreparedStatement statement;
		ResultSet resultSet;  //Guarda el resultado de la query
		List<Cliente> clientes = new ArrayList<Cliente>(); //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion(); //Obtengo Conexion

		try {
		statement = conexion.getSQLConexion().prepareStatement(leerClientes); //Cargo la consulta
		resultSet = statement.executeQuery();
		while(resultSet.next()) {  //Mientras haya registros
		Cliente X = new Cliente();
		X.setDNI(resultSet.getInt("dniCliente"));
		X.setNombre(resultSet.getString("Nombre"));
		X.setApellido(resultSet.getString("Apellido"));
		X.setCUIL(resultSet.getString("Cuil"));
		X.setSexo(resultSet.getString("Sexo"));
		X.setNacionalidad(resultSet.getString("Nacionalidad"));
		X.setProvincia(resultSet.getString("Provincia"));
		X.setLocalidad(resultSet.getString("Localidad"));
		X.setDireccion(resultSet.getString("Direccion"));
		X.setMail(resultSet.getString("Mail"));
		X.setUserName(resultSet.getString("NombreUsuario"));
		X.setPass(resultSet.getString("Contraseña"));
		X.setFecha(resultSet.getString("Fecha_Nac"));
		X.setEstado(resultSet.getString("estado"));
		

		clientes.add(X);   //Escribe en el ArrayList
		}
		} 
		catch (SQLException e) 
		{
		e.printStackTrace();
		}
		return clientes;
		}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public boolean modificar(String dni, String nombre, String apellido, String cuil, String fecha, String sexo, String nacio, String prov, String local, String direc, String mail, String pass, String usuario) {

		
		//Levanta el JAR (Para el JSP)
				try {
				Class.forName("com.mysql.jdbc.Driver");
				} catch(ClassNotFoundException e) {
				//TODO Auto-generated catch block
				e.printStackTrace();
				}
				PreparedStatement statement;
				Connection conexion = Conexion.getConexion().getSQLConexion();
				boolean isModifiedExitoso = false;
				int resultado_Update = 0;
				
				try {
					statement =conexion.prepareStatement(actualizarClientes);
					statement.setString(1, pass);
					statement.setString(2, nombre);
					statement.setString(3,apellido);
					statement.setString(4, fecha);
					statement.setString(5, sexo);
					statement.setString(6, cuil);
					statement.setString(7, nacio);
					statement.setString(8, prov);
					statement.setString(9, local);
					statement.setString(10, direc);
					statement.setString(11, mail);
					statement.setString(12, dni);
					
					if(statement.executeUpdate() > 0)
					{
						resultado_Update++;
					}
					
					statement = conexion.prepareStatement(modificarContraseña);
					
					statement.setString(1, pass);
					statement.setString(2, usuario);
					
					if(statement.executeUpdate() > 0)
					{
						resultado_Update++;
					}
					
					if(resultado_Update == 2)
					{
						conexion.commit();
						isModifiedExitoso = true;
					}
				} 
				catch (SQLException e) 
				{
					e.printStackTrace();
					try {
						conexion.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				}
			return isModifiedExitoso;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void eliminarCliente(String dni) {
		//Levanta el JAR (Para el JSP)
				try {
					Class.forName("com.mysql.jdbc.Driver");
				} catch(ClassNotFoundException e) {
					//TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				PreparedStatement statement;
				Connection conexion = Conexion.getConexion().getSQLConexion();
				try {
					statement = conexion.prepareStatement(bloquear_desbloquear_cliente);
					statement.setString(1, "Inactivo");			//Le cambio el Estado
					statement.setString(2, dni);			//Le mando el Nro. de Cuenta para que busque el registro a alterar
					if(statement.executeUpdate()>0) {
						conexion.commit();
					}
				}
				catch(SQLException e){
					e.printStackTrace();
					try {
						conexion.rollback();						//Se deshace los cambios
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				}
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void restaurarCliente(String dni) {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			statement = conexion.prepareStatement(bloquear_desbloquear_cliente);
			statement.setString(1, "Activo");			//Le cambio el Estado
			statement.setString(2, dni);			//Le mando el Nro. de Cuenta para que busque el registro a alterar
			if(statement.executeUpdate()>0) {
				conexion.commit();
			}
		}
		catch(SQLException e){
			e.printStackTrace();
			try {
				conexion.rollback();						//Se deshace los cambios
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public boolean verificarDni(String dni) {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		
		boolean existe = false;
		
		try
		{
			statement = conexion.prepareStatement(verificarDni + dni);
			resultSet = statement.executeQuery();
			if(resultSet.next())
			{
				existe = true;
			}
			else
			{
				existe = false;
			}
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
			try {
				conexion.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
		return existe;
	}
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<Cliente> Filtrar(String texto) {

		
		//Levanta el JAR (Para el JSP)
				try {
				Class.forName("com.mysql.jdbc.Driver");
				} catch(ClassNotFoundException e) {
				//TODO Auto-generated catch block
				e.printStackTrace();
				}
				PreparedStatement statement;
				ResultSet resultSet;
				Connection conexion = Conexion.getConexion().getSQLConexion();
				List<Cliente> clientes = new ArrayList<Cliente>();
				
				
				try {
					statement =conexion.prepareStatement(Filtrar);
					statement.setString(1, "%" + texto + "%");
					resultSet = statement.executeQuery();
					while (resultSet.next()) {
						Cliente X = new Cliente();
						X.setDNI(resultSet.getInt("dniCliente"));
						X.setNombre(resultSet.getString("Nombre"));
						X.setApellido(resultSet.getString("Apellido"));
						X.setCUIL(resultSet.getString("Cuil"));
						X.setSexo(resultSet.getString("Sexo"));
						X.setNacionalidad(resultSet.getString("Nacionalidad"));
						X.setProvincia(resultSet.getString("Provincia"));
						X.setLocalidad(resultSet.getString("Localidad"));
						X.setDireccion(resultSet.getString("Direccion"));
						X.setMail(resultSet.getString("Mail"));
						X.setUserName(resultSet.getString("NombreUsuario"));
						X.setPass(resultSet.getString("Contraseña"));
						X.setFecha(resultSet.getString("Fecha_Nac"));
						X.setEstado(resultSet.getString("estado"));
						
						clientes.add(X);
					}
					
					
					//"UPDATE clientes SET Contraseña=? WHERE dniCliente=?"
					
					if(statement.executeUpdate()>0) {
						conexion.commit();
						}
					
				}
				
				catch(SQLException e){
					e.printStackTrace();
					try {
					conexion.rollback();//Se deshace los cambios
					} catch (SQLException e1) {
					e1.printStackTrace();
					}
				}
				
				return clientes;		
	}

	@Override
	public Cliente obtenerCliente(String user) {
		//Levanta el JAR (Para el JSP)
		try {
		Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
		}

		PreparedStatement statement;
		ResultSet resultSet;  //Guarda el resultado de la query
		Conexion conexion = Conexion.getConexion(); //Obtengo Conexion
		Cliente X = new Cliente();
		try {
			statement = conexion.getSQLConexion().prepareStatement(obtenerCliente + "'" + user + "'"); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {  
				X.setDNI(resultSet.getInt("dniCliente"));
				X.setNombre(resultSet.getString("Nombre"));
				X.setApellido(resultSet.getString("Apellido"));
				X.setCUIL(resultSet.getString("Cuil"));
				X.setSexo(resultSet.getString("Sexo"));
				X.setNacionalidad(resultSet.getString("Nacionalidad"));
				X.setProvincia(resultSet.getString("Provincia"));
				X.setLocalidad(resultSet.getString("Localidad"));
				X.setDireccion(resultSet.getString("Direccion"));
				X.setMail(resultSet.getString("Mail"));
				X.setUserName(resultSet.getString("NombreUsuario"));
				X.setPass(resultSet.getString("Contraseña"));
				X.setFecha(resultSet.getString("Fecha_Nac"));
				X.setEstado(resultSet.getString("estado"));
									}
		} 
		catch (SQLException e) 
		{
		e.printStackTrace();
		}
		return X;
	}

	@Override
	public float totalCuentas(String dni) {
		//Levanta el JAR (Para el JSP)
				try {
				Class.forName("com.mysql.jdbc.Driver");
				} catch(ClassNotFoundException e) {
				//TODO Auto-generated catch block
				e.printStackTrace();
				}

				PreparedStatement statement;
				ResultSet resultSet;  //Guarda el resultado de la query
				Conexion conexion = Conexion.getConexion(); //Obtengo Conexion
				float total = 0;
				try {
					statement = conexion.getSQLConexion().prepareStatement("SELECT SUM(saldo) as SALDO FROM cuentas_x_clientes WHERE dni = '" +dni+ "' AND estado='Activo'"); //Cargo la consulta
					resultSet = statement.executeQuery();
					while(resultSet.next()) {  
						total = resultSet.getFloat("SALDO");
											}
				} 
				catch (SQLException e) 
				{
				e.printStackTrace();
				}
				return total;
	}
	
public float MontoTotalMovimientos() {
		
		//Levanta el JAR (Para el JSP)
		try {
		Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
		}

		PreparedStatement statement;
		ResultSet resultSet;  //Guarda el resultado de la query
		Connection conexion = Conexion.getConexion().getSQLConexion(); //Obtengo Conexion
		float total = 0;
		try {
			statement = conexion.prepareStatement("SELECT SUM(importe) AS total FROM utnbank.movimientos_x_clientes"); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {  
				total = resultSet.getFloat("total");
			}
		} 
		catch (SQLException e) 
		{
		e.printStackTrace();
		}
		return total;
	}
	
	public float MontoTotal_TipoMovimientos(int tipoMov, String fechaDesde, String fechaHasta) {
		
		//Levanta el JAR (Para el JSP)
		try {
		Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
		}

		PreparedStatement statement;
		ResultSet resultSet;  //Guarda el resultado de la query
		Connection conexion = Conexion.getConexion().getSQLConexion(); //Obtengo Conexion
		float total = 0;
		try {
			statement = conexion.prepareStatement("SELECT SUM(importe) AS total FROM utnbank.movimientos_x_clientes WHERE tipoMovimiento = ? AND fechaDetalle Between ? And ?"); //Cargo la consulta
			statement.setInt(1, tipoMov);
			statement.setString(2, fechaDesde);
			statement.setString(3, fechaHasta);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()) {  

				total = resultSet.getFloat("total");
			}
		} 
		catch (SQLException e) 
		{
		e.printStackTrace();
		}
		return total;
	}
	
	
}
