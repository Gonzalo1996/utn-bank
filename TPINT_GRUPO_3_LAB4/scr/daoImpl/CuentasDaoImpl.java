package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.CuentasDao;
import entidad.Cliente;
import entidad.Cuentas;
import entidad.TipoCuenta;

public class CuentasDaoImpl implements CuentasDao{

	private static final String agregar = "INSERT INTO cuentas_x_clientes(dni, idtipocuenta, nro_cuenta, cbu, fecha_creacion, saldo, estado) VALUES(?,?,?,?,?,?,?)";
	private static final String agregarMovimiento = "INSERT INTO movimientos_x_clientes (dni, tipoMovimiento, fechaDetalle, importe, cbu) VALUES(?,?,?,?,?)";
	private static final String leerTiposCuentas = "SELECT * FROM tipocuenta";
	private static final String leerClientes = "SELECT c.dniCliente as DNI_CLIENTE, c.Cuil as CUIL_CLIENTE, c.Nombre as NOMBRE_CLIENTE, c.Apellido as APELLIDO_CLIENTE FROM clientes as c WHERE not exists(Select * from cuentas_x_clientes as cc where c.dniCliente = cc.dni) and c.estado = 'Activo' UNION SELECT c.dniCliente as DNI_CLIENTE, c.Cuil as CUIL_CLIENTE, c.Nombre as NOMBRE_CLIENTE, c.Apellido as APELLIDO_CLIENTE FROM clientes as c WHERE exists( Select * from cuentas_x_clientes as cc where c.dniCliente = cc.dni GROUP BY c. dniCliente HAVING COUNT(cc.nro_cuenta) < 3 ) and c.estado = 'Activo' Order by DNI_CLIENTE ASC";
	private static final String leerCuentas = "SELECT cuentas_x_clientes.dni, clientes.Nombre, clientes.Apellido, tipocuenta.descripcion, cuentas_x_clientes.nro_cuenta, cuentas_x_clientes.cbu, cuentas_x_clientes.fecha_creacion, cuentas_x_clientes.saldo, cuentas_x_clientes.estado FROM cuentas_x_clientes JOIN clientes ON cuentas_x_clientes.dni = clientes.dniCliente JOIN tipocuenta ON cuentas_x_clientes.idtipocuenta = tipocuenta.idtipocuenta";
	private static final String obtenerCuentas_x_Filtro = "SELECT cuentas_x_clientes.dni, clientes.Nombre, clientes.Apellido, tipocuenta.descripcion, cuentas_x_clientes.nro_cuenta, cuentas_x_clientes.cbu, cuentas_x_clientes.fecha_creacion, cuentas_x_clientes.saldo, cuentas_x_clientes.estado FROM cuentas_x_clientes JOIN clientes ON cuentas_x_clientes.dni = clientes.dniCliente JOIN tipocuenta ON cuentas_x_clientes.idtipocuenta = tipocuenta.idtipocuenta WHERE cuentas_x_clientes.idtipocuenta = ";
	private static final String obtenerCuentas_x_DNI = "SELECT cuentas_x_clientes.dni, clientes.Nombre, clientes.Apellido, tipocuenta.descripcion, cuentas_x_clientes.nro_cuenta, cuentas_x_clientes.cbu, cuentas_x_clientes.fecha_creacion, cuentas_x_clientes.saldo, cuentas_x_clientes.estado FROM cuentas_x_clientes JOIN clientes ON cuentas_x_clientes.dni = clientes.dniCliente JOIN tipocuenta ON cuentas_x_clientes.idtipocuenta = tipocuenta.idtipocuenta WHERE cuentas_x_clientes.dni LIKE '%";
	private static final String bloquear_desbloquear_cuenta = "UPDATE cuentas_x_clientes SET estado=? WHERE nro_cuenta= ?";
	private static final String verificarCuenta = "SELECT nro_cuenta FROM cuentas_x_clientes WHERE nro_cuenta = ?";
	private static final String verificar_Cant_Cuentas = "SELECT count(*) FROM cuentas_x_clientes WHERE dni = ?";
	private static final String modificarCuenta = "UPDATE cuentas_x_clientes SET dni=?, idtipocuenta=? WHERE cbu = ?";
	private static final String modificarMovimiento = "UPDATE movimientos_x_clientes SET dni=? WHERE cbu=?";
	private static final String cuentasxdni = "SELECT nro_cuenta FROM cuentas_x_clientes where dni=?";
	public static String traerTotalesCuentas = "SELECT idtipocuenta, COUNT(idtipocuenta) as CUENTAS FROM cuentas_x_clientes WHERE idtipocuenta = 1 AND estado = 'Activo' UNION SELECT idtipocuenta, COUNT(idtipocuenta) FROM cuentas_x_clientes WHERE idtipocuenta = 2 AND estado = 'Activo'";
	public static String traerTotalesMovimientos = "SELECT tm.idtipoMovimientos, COUNT(mv.tipoMovimiento) as CUENTAS FROM movimientos_x_clientes as mv inner join tipomovimientos as tm WHERE mv.tipoMovimiento = 1 and mv.tipoMovimiento = tm.idtipoMovimientos \r\n" + 
			"UNION\r\n" + 
			"SELECT tm.idtipoMovimientos, COUNT(mv.tipoMovimiento) FROM movimientos_x_clientes as mv inner join tipomovimientos as tm WHERE mv.tipoMovimiento = 2 and mv.tipoMovimiento = tm.idtipoMovimientos \r\n" + 
			"UNION\r\n" + 
			"SELECT tm.idtipoMovimientos, COUNT(mv.tipoMovimiento) FROM movimientos_x_clientes as mv inner join tipomovimientos as tm WHERE mv.tipoMovimiento = 3 and mv.tipoMovimiento = tm.idtipoMovimientos \r\n" + 
			"UNION\r\n" + 
			"SELECT tm.idtipoMovimientos, COUNT(mv.tipoMovimiento) FROM movimientos_x_clientes as mv inner join tipomovimientos as tm WHERE mv.tipoMovimiento = 4 and mv.tipoMovimiento = tm.idtipoMovimientos \r\n" + 
			"UNION\r\n" + 
			"SELECT tm.idtipoMovimientos, COUNT(mv.tipoMovimiento) FROM movimientos_x_clientes as mv inner join tipomovimientos as tm WHERE mv.tipoMovimiento = 5 and mv.tipoMovimiento = tm.idtipoMovimientos \r\n" + 
			"UNION\r\n" + 
			"SELECT tm.idtipoMovimientos, COUNT(mv.tipoMovimiento) FROM movimientos_x_clientes as mv inner join tipomovimientos as tm WHERE mv.tipoMovimiento = 6 and mv.tipoMovimiento = tm.idtipoMovimientos \r\n" + 
			"UNION\r\n" + 
			"SELECT tm.idtipoMovimientos, COUNT(mv.tipoMovimiento) FROM movimientos_x_clientes as mv inner join tipomovimientos as tm WHERE mv.tipoMovimiento = 7 and mv.tipoMovimiento = tm.idtipoMovimientos ";

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	@Override
	public boolean agregarCuenta(Cuentas cuenta) {
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
			statement = conexion.prepareStatement(agregar);
			
			statement.setString(1, Integer.toString(cuenta.getDNI()));
			statement.setInt(2, cuenta.gettCuenta().getIdTipo());
			statement.setString(3, cuenta.getNro_cuenta());
			statement.setString(4, cuenta.getCBU());
			statement.setString(5, cuenta.getFecha_creacion());
			statement.setFloat(6, cuenta.getSaldo());
			statement.setString(7, cuenta.getEstado());

			if(statement.executeUpdate() > 0)
			{
				resultado_Update++;
			}
			
			statement = conexion.prepareStatement(agregarMovimiento);
			
			statement.setString(1, Integer.toString(cuenta.getDNI()));
			statement.setInt(2, 1);
			statement.setString(3, cuenta.getFecha_creacion());
			statement.setFloat(4, cuenta.getSaldo());
			statement.setString(5, cuenta.getCBU());
			
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
	
	@Override
	public List<TipoCuenta> traerTiposCuentas() {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
		List<TipoCuenta> tiposCuentas = new ArrayList<TipoCuenta>();		 //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(leerTiposCuentas); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				TipoCuenta X = new TipoCuenta();
				X.setIdTipo(resultSet.getInt("idtipoCuenta"));
				X.setDescripcion(resultSet.getString("descripcion"));
				
				tiposCuentas.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return tiposCuentas;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	@Override
	public List<Cliente> traerClientes() {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
		List<Cliente> clientes = new ArrayList<Cliente>();		 //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(leerClientes); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				Cliente X = new Cliente();
				X.setDNI(resultSet.getInt("DNI_CLIENTE"));
				X.setNombre(resultSet.getString("NOMBRE_CLIENTE"));
				X.setApellido(resultSet.getString("APELLIDO_CLIENTE"));
				X.setCUIL(resultSet.getString("CUIL_CLIENTE"));
				clientes.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return clientes;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<Cuentas> traerCuentas() {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
		List<Cuentas> cuentas = new ArrayList<Cuentas>();		 //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(leerCuentas); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				Cuentas X = new Cuentas();
				X.setDNI(resultSet.getInt("cuentas_x_clientes.dni"));
					Cliente client = new Cliente();
					client.setNombre(resultSet.getString("clientes.Nombre"));
					client.setApellido(resultSet.getString("clientes.Apellido"));
				X.setCliente(client);
					TipoCuenta tc = new TipoCuenta();
					tc.setDescripcion(resultSet.getString("tipocuenta.descripcion"));
				X.settCuenta(tc);
				X.setNro_cuenta(resultSet.getString("cuentas_x_clientes.nro_cuenta"));
				X.setCBU(resultSet.getString("cuentas_x_clientes.cbu"));
				X.setFecha_creacion(resultSet.getString("cuentas_x_clientes.fecha_creacion"));
				X.setSaldo(resultSet.getFloat("cuentas_x_clientes.saldo"));
				X.setEstado(resultSet.getString("cuentas_x_clientes.estado"));
				
				cuentas.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return cuentas;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<Cuentas> obtenerCuentas_x_Filtro(int id) {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
		List<Cuentas> cuentas = new ArrayList<Cuentas>();		 //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(obtenerCuentas_x_Filtro + id); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				Cuentas X = new Cuentas();
				X.setDNI(resultSet.getInt("cuentas_x_clientes.dni"));
					Cliente client = new Cliente();
					client.setNombre(resultSet.getString("clientes.Nombre"));
					client.setApellido(resultSet.getString("clientes.Apellido"));
				X.setCliente(client);
					TipoCuenta tc = new TipoCuenta();
					tc.setDescripcion(resultSet.getString("tipocuenta.descripcion"));
				X.settCuenta(tc);
				X.setNro_cuenta(resultSet.getString("cuentas_x_clientes.nro_cuenta"));
				X.setCBU(resultSet.getString("cuentas_x_clientes.cbu"));
				X.setFecha_creacion(resultSet.getString("cuentas_x_clientes.fecha_creacion"));
				X.setSaldo(resultSet.getFloat("cuentas_x_clientes.saldo"));
				X.setEstado(resultSet.getString("cuentas_x_clientes.estado"));
				
				cuentas.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return cuentas;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public List<Cuentas> traerCuentas_x_dni(int param) {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
		List<Cuentas> cuentas = new ArrayList<Cuentas>();		 //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(obtenerCuentas_x_DNI + param + "%'"); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				Cuentas X = new Cuentas();
				X.setDNI(resultSet.getInt("cuentas_x_clientes.dni"));
					Cliente client = new Cliente();
					client.setNombre(resultSet.getString("clientes.Nombre"));
					client.setApellido(resultSet.getString("clientes.Apellido"));
				X.setCliente(client);
					TipoCuenta tc = new TipoCuenta();
					tc.setDescripcion(resultSet.getString("tipocuenta.descripcion"));
				X.settCuenta(tc);
				X.setNro_cuenta(resultSet.getString("cuentas_x_clientes.nro_cuenta"));
				X.setCBU(resultSet.getString("cuentas_x_clientes.cbu"));
				X.setFecha_creacion(resultSet.getString("cuentas_x_clientes.fecha_creacion"));
				X.setSaldo(resultSet.getFloat("cuentas_x_clientes.saldo"));
				X.setEstado(resultSet.getString("cuentas_x_clientes.estado"));
				
				cuentas.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return cuentas;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void bloquearCuenta(String nroCuenta) {
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
			statement = conexion.prepareStatement(bloquear_desbloquear_cuenta);
			statement.setString(1, "Inactivo");			//Le cambio el Estado
			statement.setString(2, nroCuenta);			//Le mando el Nro. de Cuenta para que busque el registro a alterar
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
	
	public void desbloquearCuenta(String nroCuenta) {
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
			statement = conexion.prepareStatement(bloquear_desbloquear_cuenta);
			statement.setString(1, "Activo");			//Le cambio el Estado
			statement.setString(2, nroCuenta);			//Le mando el Nro. de Cuenta para que busque el registro a alterar
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
	
	public boolean verificarCuenta(String nroCuenta) {
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
			statement = conexion.prepareStatement(verificarCuenta + nroCuenta);
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
	
	
		//NO USADO
	public int verificar_Cant_Cuentas(String dni) {
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
		
		int cant = 0;																//Para obtener el resultado de la Consulta
		
		try
		{
			statement = conexion.prepareStatement(verificar_Cant_Cuentas + dni);
			resultSet = statement.executeQuery();
			if(resultSet.next())
			{
				cant = resultSet.getInt(1);																//Guardo el resultado de la Consulta (me trae un entero)
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
		
		return cant;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////

	public boolean modificarCuenta(Cuentas cuenta) {
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
		try
		{
			statement = conexion.prepareStatement(modificarCuenta);
			
			statement.setString(1, Integer.toString(cuenta.getDNI()));
			statement.setInt(2, cuenta.gettCuenta().getIdTipo());
			statement.setString(3, cuenta.getCBU());

			if(statement.executeUpdate() > 0)
			{
				resultado_Update++;
			}
			
			statement = conexion.prepareStatement(modificarMovimiento);
			
			statement.setString(1, Integer.toString(cuenta.getDNI()));
			statement.setString(2, cuenta.getCBU());
			
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
	
       //////////////////////////////////////////////////////////////////////
	
public Cuentas obtenerCuenta(String cbu) {
		
		Cuentas cuenta = null;
		PreparedStatement statement = null;
		ResultSet rs = null;
		Connection conexion = Conexion.getConexion().getSQLConexion(); 
		String query = "SELECT dni,cbu,nro_cuenta FROM "
					 + "utnbank.cuentas_x_clientes WHERE cbu ='" + cbu + "'";  
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		
		
		try
		{
			statement = conexion.prepareStatement(query);
			rs = statement.executeQuery();
			
			
			while(rs.next()) {
				
				cuenta = new Cuentas();
				
				cuenta.setDNI(rs.getInt(1));
				cuenta.setNro_cuenta(rs.getString(2));
				cuenta.setCBU(rs.getString(3));	
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
		
		
		return cuenta;
	}
	//////////////////////////////////////////////////////

public Cliente obtenerDatosCliente(int dni) { //SOLO OBTENGO NOMBRE Y APELLIDO.
	
	Cliente cliente = null;
	PreparedStatement statement = null;
	ResultSet rs = null;
	Connection conexion = Conexion.getConexion().getSQLConexion(); 
	String query = "SELECT Nombre,Apellido FROM utnbank.clientes WHERE dniCliente = '" + dni +"'";  
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch(ClassNotFoundException e) {
		
		e.printStackTrace();
	}
	
	
	try
	{
		statement = conexion.prepareStatement(query);
		rs = statement.executeQuery();
		
		
		while(rs.next()) {
			
			cliente = new Cliente();
			
			cliente.setNombre(rs.getString(1));
			cliente.setApellido(rs.getString(2));
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
	
	
	return cliente;
}


///////////////////////////////////////////////////////////////////////


public boolean verificarCuentaCBU(String cbu) {
	
	///ESTO VALE ORO!!!!!!!!!!!!
	
	String verificarCuentaCBU = "SELECT * FROM utnbank.cuentas_x_clientes WHERE cbu = ? AND estado = 'Activo'";
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	PreparedStatement statement;
	Connection conexion = Conexion.getConexion().getSQLConexion();
	ResultSet rs = null;
	boolean existe = false;
	
	try
	{
		statement = conexion.prepareStatement(verificarCuentaCBU);
		statement.setString(1, cbu);
		rs = statement.executeQuery();
		
		while(rs.next()) {
			existe = true;
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

///////////////////////////////////////////////////////////////

public boolean verificarMonto(String nroCuenta, double monto) {
	
	String verificarMonto = "SELECT * FROM utnbank.cuentas_x_clientes WHERE nro_cuenta = ? AND  ? <= saldo";
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	PreparedStatement statement;
	Connection conexion = Conexion.getConexion().getSQLConexion();
	ResultSet rs = null;
	boolean existe = false;
	
	try
	{
		statement = conexion.prepareStatement(verificarMonto);
		statement.setString(1, nroCuenta);
		statement.setDouble(2, monto);
		rs = statement.executeQuery();
		
		while(rs.next()) {
			existe = true;
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
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

public List<Cuentas> listcuent(String texto){
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	PreparedStatement statement;
	ResultSet resultSet; 												 //Guarda el resultado de la query
	List<Cuentas> cuentas = new ArrayList<Cuentas>();		 //Creo un ArrayList para copiar los registros de la BD 
	Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
	
	try {
		statement = conexion.getSQLConexion().prepareStatement(cuentasxdni); //Cargo la consulta
		statement.setString(1, texto);
		resultSet = statement.executeQuery();
		while(resultSet.next()) {												  //Mientras haya registros
			Cuentas x = new Cuentas();
			x.setNro_cuenta(resultSet.getString("nro_cuenta"));
			
			
			
			cuentas.add(x);						 						  //Escribe en el ArrayList
		}
	} 
	catch (SQLException e) 
	{
		e.printStackTrace();
	}
	return cuentas;
	
	
}
	//////////////////////////////////////////////

public List<Integer> traerTotalesCuentas() {
	//Levanta el JAR (Para el JSP)
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	PreparedStatement statement;
	ResultSet resultSet; 												 //Guarda el resultado de la query
	List<Integer> totales = new ArrayList<Integer>();		 //Creo un ArrayList para copiar los registros de la BD 
	Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
	
	try {
		statement = conexion.getSQLConexion().prepareStatement(traerTotalesCuentas); //Cargo la consulta
		resultSet = statement.executeQuery();
		while(resultSet.next()) {												  //Mientras haya registros
			int x = 0;
			x = resultSet.getInt("CUENTAS");
			totales.add(x);						 						  //Escribe en el ArrayList
		}
	} 
	catch (SQLException e) 
	{
		e.printStackTrace();
	}
	return totales;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

public List<Integer> traerTotalesMovimientos() {
//Levanta el JAR (Para el JSP)
try {
Class.forName("com.mysql.jdbc.Driver");
} catch(ClassNotFoundException e) {
//TODO Auto-generated catch block
e.printStackTrace();
}

PreparedStatement statement;
ResultSet resultSet; 												 //Guarda el resultado de la query
List<Integer> totales = new ArrayList<Integer>();		 //Creo un ArrayList para copiar los registros de la BD 
Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion

try {
statement = conexion.getSQLConexion().prepareStatement(traerTotalesMovimientos); //Cargo la consulta
resultSet = statement.executeQuery();
while(resultSet.next()) {												  //Mientras haya registros
int x = 0;
x = resultSet.getInt("CUENTAS");

totales.add(x);						 						  //Escribe en el ArrayList
}
} 
catch (SQLException e) 
{
e.printStackTrace();
}
return totales;
}



}
