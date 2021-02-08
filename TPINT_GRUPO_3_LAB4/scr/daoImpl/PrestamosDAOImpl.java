package daoImpl;

import dao.PrestamosDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import entidad.Prestamos;
import entidad.cuotas;
import entidad.Cuentas;



public class PrestamosDAOImpl implements PrestamosDAO{
	
	
	private static final String traerPrestamos  =  "SELECT * FROM prestamos where dni=?";
	private static final String traerPrestamospend  =  "SELECT * FROM prestamos where nroCuota=?";
	private static final String addCuotas = "INSERT INTO cuotas (idcuotas, nrocuota, fecha, cbu,importe,dni) VALUES(?,?,?,?,?,?)";
	private static final String traerCuotas= "SELECT * FROM cuotas where dni=?";
	private static final String cambiarEstado = "UPDATE prestamos SET estado=? WHERE idPrestamos=? and nroCuota=?";
	private static final String addMov = "insert INTO movimientos_x_clientes (dni,tipoMovimiento,fechaDetalle,importe,cbu) VALUES (?,?,?,?,?)";
//	private static final String traerCuotas = "select cuotas.cbu from cuotas inner join prestamos on cuotas.cbu = prestamos.cbu";	
	private static final String ultimo = "SELECT idPrestamos FROM prestamos ORDER BY idPrestamos DESC LIMIT 1";
	private static final String cbucuenta = "SELECT cbu FROM cuentas_x_clientes where nro_cuenta=?";
	private static final String addPrestamos = "INSERT INTO prestamos (idPrestamos,nroCuota,dni,fecha,importe_pedido,importe_a_pagar_x_mes,plazo_pago,estado,cbu) VALUES(?,?,?,?,?,?,?,?,?)";
	private static final String mod= "UPDATE prestamos SET estado=? WHERE idPrestamos=?";
	private static final String actualizarSaldo = "UPDATE cuentas_x_clientes SET saldo = ? WHERE cbu = ?";
	private static final String traer= "SELECT * FROM cuentas_x_clientes WHERE cbu=";
	
	
	
	public String fechaActual() {
		Date fecha = new Date();
		
		SimpleDateFormat formatofecha = new SimpleDateFormat("dd/MM/YYYY");
		return formatofecha.format(fecha);
		 
	}
	
	
	
	public List<Prestamos> traerPrestamos(int dni) {
		//Levanta el JAR (Para el JSP)
		try {
		Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
		}

		PreparedStatement statement;
		ResultSet resultSet;  //Guarda el resultado de la query
		List<Prestamos> prestamos = new ArrayList<Prestamos>(); //Creo un ArrayList para copiar los registros de la BD 
		Connection conexion = Conexion.getConexion().getSQLConexion(); //Obtengo Conexion

		try {
		statement = conexion.prepareStatement(traerPrestamos); //Cargo la consulta
		statement.setInt(1, dni);
		
		
		resultSet = statement.executeQuery();
		while(resultSet.next()) {  //Mientras haya registros
		Prestamos x = new Prestamos();
		x.setFecha(resultSet.getString("fecha"));
		x.setIdPrestamo(resultSet.getInt("idPrestamos"));
		x.setPlazo_pago(resultSet.getInt("plazo_pago"));
		x.setNro_cuota(resultSet.getInt("nroCuota"));
		x.setImp_a_pagar(resultSet.getFloat("importe_a_pagar_x_mes"));
		x.setImp_pedido(resultSet.getFloat("importe_pedido"));
		x.setEstado(resultSet.getString("estado"));
		Cuentas a = new Cuentas();
		a.setCBU(resultSet.getString("cbu"));
		x.setObtener_cbu(a);
			
		
		

		prestamos.add(x);   //Escribe en el ArrayList
		}
		} 
		catch (SQLException e) 
		{
		e.printStackTrace();
		}
		return prestamos;
		}
	
	////////////////////////////////////////////////////////////////////////
	
	public List<Prestamos> traerPrestamoss() {
		//Levanta el JAR (Para el JSP)
		try {
		Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
		}

		PreparedStatement statement;
		ResultSet resultSet;  //Guarda el resultado de la query
		List<Prestamos> prestamos = new ArrayList<Prestamos>(); //Creo un ArrayList para copiar los registros de la BD 
		Connection conexion = Conexion.getConexion().getSQLConexion(); //Obtengo Conexion

		try {
		statement = conexion.prepareStatement(traerPrestamospend); //Cargo la consulta
		statement.setInt(1, 1);
		
		
		resultSet = statement.executeQuery();
		while(resultSet.next()) {  //Mientras haya registros
		Prestamos x = new Prestamos();
		x.setFecha(resultSet.getString("fecha"));
		x.setIdPrestamo(resultSet.getInt("idPrestamos"));
		x.setPlazo_pago(resultSet.getInt("plazo_pago"));
		x.setNro_cuota(resultSet.getInt("nroCuota"));
		x.setImp_a_pagar(resultSet.getFloat("importe_a_pagar_x_mes"));
		x.setImp_pedido(resultSet.getFloat("importe_pedido"));
		x.setEstado(resultSet.getString("estado"));
		Cuentas a = new Cuentas();
		a.setCBU(resultSet.getString("cbu"));
		x.setDNI(resultSet.getInt("dni"));
		x.setObtener_cbu(a);
		
			
		
		

		prestamos.add(x);   //Escribe en el ArrayList
		}
		} 
		catch (SQLException e) 
		{
		e.printStackTrace();
		}
		return prestamos;
		}
	
	
	
	
	
	
	
	
	
	////////////////////////////////////////////////////////////////////////
	public boolean agregarCuota(float x,String id, String nro,String imp,String cbu,String dni) {
		
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
			statement = conexion.prepareStatement(addCuotas);
			statement.setInt(1, Integer.parseInt(id));
			statement.setString(2, nro);
			statement.setString(3, fechaActual());
			statement.setString(4, cbu);
			statement.setFloat(5, Float.parseFloat(imp));
			statement.setString(6, dni);

			if(statement.executeUpdate() > 0)
			{
				resultado_Update++;
			}
			
			statement = conexion.prepareStatement(cambiarEstado);
			
			statement.setString(1, "Inactivo");
			statement.setString(2, id);
			statement.setString(3, nro);
			
			if(statement.executeUpdate() > 0)
			{
				resultado_Update++;
			}
			
			//"insert INTO movimientos_x_clientes (dni,tipoMovimiento,fechaDetalle,importe,cbu) VALUES (?,?,?,?,?)";
			statement = conexion.prepareStatement(addMov);
			statement.setString(1, dni);
			statement.setInt(2, 5);
			statement.setString(3, fechaActual());
			statement.setFloat(4, Float.parseFloat(imp));
			statement.setString(5, cbu);
			
			if(statement.executeUpdate() > 0)
			{
				resultado_Update++;
			}
			
			statement=conexion.prepareStatement(actualizarSaldo);
			
			statement.setString(1, Float.toString(x));
			//statement.setString(2, cu.getNro_cuenta());
			statement.setString(2, cbu);
		
			if(statement.executeUpdate() > 0)
			{
				resultado_Update++;
			}
			
			
			if(resultado_Update == 4)
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
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	public List<cuotas> traerCuotas(int dni) {
		//Levanta el JAR (Para el JSP)
		try {
		Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
		//TODO Auto-generated catch block
		e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet;  //Guarda el resultado de la query
		List<cuotas> cuo = new ArrayList<cuotas>(); //Creo un ArrayList para copiar los registros de la BD 
		Connection conexion = Conexion.getConexion().getSQLConexion(); //Obtengo Conexion

		try {
		statement = conexion.prepareStatement(traerCuotas); //Cargo la consulta
		statement.setInt(1, dni);
		
		
		resultSet = statement.executeQuery();
		while(resultSet.next()) {  //Mientras haya registros
		cuotas x = new cuotas();
		//x.setFecha(resultSet.getString("fecha"));
		x.setIdcuotas(resultSet.getInt("idcuotas"));
		x.setNrocuota(resultSet.getString("nrocuota"));
		x.setFecha(resultSet.getString("fecha"));
		x.setImporte(resultSet.getFloat("importe"));
		x.setCbu(resultSet.getString("cbu"));
		
			
		
		

		cuo.add(x);   //Escribe en el ArrayList
		}
		} 
		catch (SQLException e) 
		{
		e.printStackTrace();
		}
		return cuo;
		}
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public String obtenercbu(String cuenta) {
		
		String hola = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
			 //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(cbucuenta); //Cargo la consulta
			statement.setString(1, cuenta);
			resultSet = statement.executeQuery();
			if(resultSet.next()){
			
			hola= resultSet.getString("cbu");
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return hola;
		
	}
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public String obtenerUltimoid() {
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		String a = new String();
		int x;
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
		 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(ultimo); //Cargo la consulta
			//statement.setString(1, 1);
			resultSet = statement.executeQuery();
			 if(resultSet.next()){
			x = resultSet.getInt("idPrestamos");
					x=x+1;
			 a= String.valueOf(x);
			 }
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		
		
		return a;	
	}
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	public boolean agregarSolicitud(String id, String cuotas, String cbu, String monto, String dni) {

		
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
		int j=Integer.parseInt(cuotas);
		int h=Integer.parseInt(cuotas);
		int x = Integer.parseInt(id);
		
		

		float n = Float.parseFloat(monto)/h;
		try
		{
			
			
			
			
			
			
			
			for (int i = 1; i <= j; ++i) {
			statement = conexion.prepareStatement(addPrestamos);
			statement.setInt(1, x);
			statement.setInt(2, i);
			statement.setString(3, dni);
			statement.setString(4, fechaActual());
			statement.setFloat(5, Float.parseFloat(monto));
			statement.setFloat(6, n);
			statement.setInt(7, Integer.parseInt(cuotas));
			statement.setString(8, "Pendiente");
			statement.setString(9, cbu);
			
			if(statement.executeUpdate()>0) {
				conexion.commit();
				}			
				
			
			isInsertExitoso=true;
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
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	public boolean modifest(int dni,Float x,String id,String idcbu,String idimp) {
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		Cuentas c = new Cuentas();
		//c.setsal
		boolean isInsertExitoso = false;
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		int resultado_Update = 0;
		try {
			statement = conexion.prepareStatement(mod);
			statement.setString(1, "Activo");			//Le cambio el Estado
			statement.setString(2, id);			//Le mando el Nro. de Cuenta para que busque el registro a alterar
			if(statement.executeUpdate()>0) {
				
				if(statement.executeUpdate() > 0)
				{
					resultado_Update++;
				}
				
				statement = conexion.prepareStatement(actualizarSaldo);
				//float ho = cu.getSaldo() + Float.parseFloat(idimp);
				
				statement.setString(1, Float.toString(x));
				//statement.setString(2, cu.getNro_cuenta());
				statement.setString(2, idcbu);
				
				//"UPDATE cuentas_x_clientes SET saldo = ? WHERE cbu = ?
				
				if(statement.executeUpdate() > 0)
				{
					resultado_Update++;
				}
				
				statement = conexion.prepareStatement(addMov);
				
				//insert INTO movimientos_x_clientes (dni,tipoMovimiento,fechaDetalle,importe,cbu) VALUES (?,?,?,?,?)
				statement.setInt(1, dni);
				statement.setString(2, "2");
				statement.setString(3, fechaActual());
				statement.setString(4, idimp);
				statement.setString(5, idcbu);
				
				if(statement.executeUpdate() > 0)
				{
					resultado_Update++;
				}
				
				if(resultado_Update == 3)
				{
					conexion.commit();
					isInsertExitoso = true;
				}	
			}
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		
	return isInsertExitoso;
		
	}
	
	

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public boolean modifestr(String id) {
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	/*	
		
		PreparedStatement statement;
		ResultSet resultSet; 												 //Guarda el resultado de la query
			 //Creo un ArrayList para copiar los registros de la BD 
		Conexion conexion = Conexion.getConexion();							 //Obtengo Conexion
		
		try {
			statement = conexion.getSQLConexion().prepareStatement(mod); //Cargo la consulta
			statement.setString(1, "Rechazado");
			statement.setString(2, id);
			statement.executeUpdate();
			
			isInsertExitoso = true;
			
		} 
		
		*/
		boolean isInsertExitoso = false;
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			statement = conexion.prepareStatement(mod);
			statement.setString(1, "Rechazado");			//Le cambio el Estado
			statement.setString(2, id);			//Le mando el Nro. de Cuenta para que busque el registro a alterar
			if(statement.executeUpdate()>0) {
				conexion.commit();
				isInsertExitoso=true;
			}
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		
	return isInsertExitoso;
		
	}
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public Cuentas traerCuenta(String idcbu) {
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
		statement = conexion.getSQLConexion().prepareStatement(traer + idcbu); //Cargo la consulta
		resultSet = statement.executeQuery();
		while(resultSet.next()) {												  //Mientras haya registros
			
			X.setDNI(resultSet.getInt("dni"));
			X.setNro_cuenta("nro_cuenta");
			X.setCBU(resultSet.getString("cbu"));
			X.setSaldo(resultSet.getFloat("saldo"));
		}
	} 
	catch (SQLException e) 
	{
		e.printStackTrace();
	}
	return X;
}
	
	
	
	
	
	
	
	


}