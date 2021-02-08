package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.Movimientos_y_CuentasDAO;
import entidad.Cuentas;
import entidad.Movimientos;
import entidad.TipoCuenta;
import entidad.TipoMovimientos;

public class Movimientos_y_CuentasDAOImpl implements Movimientos_y_CuentasDAO{
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private static final String traerMovimientos = "SELECT MC.fechaDetalle AS FECHA, TC.descripcion AS DETALLE, MC.importe AS IMPORTE FROM movimientos_x_clientes AS MC INNER JOIN tipomovimientos AS TC ON TC.idtipoMovimientos = MC.tipoMovimiento WHERE cbu = ";
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private static final String traerCuentas = "select TC.descripcion as TIPO, CC.nro_cuenta as CUENTA, CC.saldo as SALDO from cuentas_x_clientes as CC inner join tipocuenta as TC where TC.idtipoCuenta = CC.idtipocuenta and CC.estado = 'Activo' and CC.dni = ";
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private static final String traerCuenta = "select CC.dni as DNI, CC.cbu as CBU, CC.saldo as SALDO from cuentas_x_clientes as CC where CC.nro_cuenta =";
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private static final String actualizarCuenta = "UPDATE cuentas_x_clientes SET saldo = ? WHERE (nro_cuenta = ?) and (cbu = ?);";
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private static final String agregarMovimiento = "INSERT INTO movimientos_x_clientes (dni, tipoMovimiento, fechaDetalle, importe, cbu) VALUES(?,?,?,?,?)";
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private static final String leerMovimientos = "SELECT * FROM utnbank.movimientos_x_clientes WHERE tipoMovimiento = 6";

	
	////////////////////////////////////	CAJA DE AHORRO	  ////////////////////////////////////////////////////////////
	
	@Override
	public List<Cuentas> traerCuentasxCliente_CA(String dni) {
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
					statement = conexion.getSQLConexion().prepareStatement("SELECT * FROM cuentas_x_clientes WHERE dni = '"+dni+"' AND estado = 'Activo' AND idtipocuenta ="+1+";"); //Cargo la consulta
					resultSet = statement.executeQuery();
					while(resultSet.next()) {												  //Mientras haya registros
						Cuentas X = new Cuentas();

						X.setNro_cuenta(resultSet.getString("nro_cuenta"));
						X.setCBU(resultSet.getString("cbu"));
						X.setFecha_creacion(resultSet.getString("fecha_creacion"));
						X.setSaldo(resultSet.getFloat("saldo"));
						
						cuentas.add(X);						 						  //Escribe en el ArrayList
					}
				} 
				catch (SQLException e) 
				{
					e.printStackTrace();
				}
				return cuentas;
	}

	@Override
	public List<Movimientos> traerMovimientosxCuenta_CA(String cbu) {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
		List<Movimientos> movimientos = new ArrayList<Movimientos>();		 //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(traerMovimientos + cbu); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				Movimientos X = new Movimientos();
				TipoMovimientos tm = new TipoMovimientos();
				
				X.setFecha(resultSet.getString("FECHA"));
					tm.setDescripcion(resultSet.getString("DETALLE"));
				X.settMove(tm);
				X.setImporte(resultSet.getFloat("IMPORTE"));
				
				movimientos.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return movimientos;
	}

	
	
	
	
	
	
	
	////////////////////////////////////	CUENTA CORRIENTE	  ////////////////////////////////////////////////////////////
	
	@Override
	public List<Cuentas> traerCuentasxCliente_CC(String dni) {
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
			statement = conexion.getSQLConexion().prepareStatement("SELECT * FROM cuentas_x_clientes WHERE dni = '"+dni+"' AND estado = 'Activo' AND idtipocuenta ="+2+";"); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				Cuentas X = new Cuentas();

				X.setNro_cuenta(resultSet.getString("nro_cuenta"));
				X.setCBU(resultSet.getString("cbu"));
				X.setFecha_creacion(resultSet.getString("fecha_creacion"));
				X.setSaldo(resultSet.getFloat("saldo"));
				
				cuentas.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return cuentas;
	}

	@Override
	public List<Movimientos> traerMovimientosxCuenta_CC(String cbu) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Cuentas> traerTodaslasCuentas(String dni) {
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
			statement = conexion.getSQLConexion().prepareStatement(traerCuentas + dni); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				Cuentas X = new Cuentas();
				TipoCuenta tc = new TipoCuenta();
					
					tc.setDescripcion(resultSet.getString("TIPO"));
				X.settCuenta(tc);
				X.setNro_cuenta(resultSet.getString("CUENTA"));
				X.setSaldo(resultSet.getFloat("SALDO"));
				
				cuentas.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return cuentas;
	}

	@Override
	public Cuentas traerCuenta(String nroCuenta) {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
		Cuentas X = new Cuentas();
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(traerCuenta + nroCuenta); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				
				X.setDNI(resultSet.getInt("DNI"));
				X.setNro_cuenta(nroCuenta);
				X.setCBU(resultSet.getString("CBU"));
				X.setSaldo(resultSet.getFloat("SALDO"));
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return X;
	}

	@Override
	public void actualizarCuenta(Cuentas c) {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		try
		{
			statement = conexion.prepareStatement(actualizarCuenta);
			
			statement.setFloat(1, c.getSaldo());
			statement.setString(2, c.getNro_cuenta());
			statement.setString(3, c.getCBU());

			if(statement.executeUpdate() > 0)
			{
				conexion.commit();
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
	}

	@Override
	public void agregarMovimiento(Movimientos m) {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();

		try
		{
			statement = conexion.prepareStatement(agregarMovimiento);
			
			statement.setString(1, Integer.toString(m.getDNI()));
			statement.setInt(2, m.gettMove().getIdTipo());
			statement.setString(3, m.getFecha());
			statement.setFloat(4, m.getImporte());
			statement.setString(5, m.getObtener_cbu().getCBU());
			
			if(statement.executeUpdate() > 0)
			{
				conexion.commit();
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
	
	}

	
	
	
	public List<Cuentas> NumerosCuentas(int dni) {
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
			statement = conexion.getSQLConexion().prepareStatement("SELECT * FROM cuentas_x_clientes WHERE dni = ? AND estado = ?"); //Cargo la consulta
			statement.setInt(1, dni);
			statement.setString(2, "Activo");
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				Cuentas X = new Cuentas();

				X.setNro_cuenta(resultSet.getString("nro_cuenta"));
				cuentas.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return cuentas;
	}
	
	
	
	public List<Movimientos> traerMovimientos_X_Cuentas() {
		//Levanta el JAR (Para el JSP)
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
		List<Movimientos> movimientos = new ArrayList<Movimientos>();		 //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(leerMovimientos); //Cargo la consulta
			resultSet = statement.executeQuery();
			while(resultSet.next()) {												  //Mientras haya registros
				
				Movimientos X = new Movimientos();
				X.setDNI(resultSet.getInt("dni"));
				X.setFecha(resultSet.getString("fechaDetalle"));
				X.setImporte(resultSet.getFloat("importe"));
				Cuentas a = new Cuentas();
				a.setCBU(resultSet.getString("cbu"));
				X.setObtener_cbu(a);
				movimientos.add(X);						 						  //Escribe en el ArrayList
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return movimientos;
	}

	
public void agregarMovimiento(int dni, int tipoMov, String fecha, double monto, String cbu) {
		
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
				statement =conexion.prepareStatement(agregarMovimiento);
				
				statement.setInt(1, dni);
				statement.setInt(2, 6);
				statement.setString(3, fecha);
				statement.setDouble(4, monto);
				statement.setString(5, cbu);
				/*
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
				*/
				
				if(statement.executeUpdate() > 0)
				{
					resultado_Update++;
				}
				
				if(resultado_Update == 1)
				{
					conexion.commit();
					isModifiedExitoso = true;
				}
				/*
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
				}*/
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
		
	}
	
}
