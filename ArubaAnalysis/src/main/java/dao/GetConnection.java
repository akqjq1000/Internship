package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class GetConnection {
	public static Connection getConnection() throws Exception {
		Connection connection = null;

		String url = "jdbc:mysql://192.168.206.100:3306/aruba";
		String username = "aruba";
		String password = "aruba123!";

		Class.forName("com.mysql.cj.jdbc.Driver");
		connection = DriverManager.getConnection(url, username, password);
		
		return connection;
	}
}
