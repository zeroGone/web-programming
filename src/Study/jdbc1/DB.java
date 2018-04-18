package Study.jdbc1;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DB {
	static DataSource dataSource = null;//DB를 받아오기 위한 DataSource 객체
	
	//DB를 생성하고 리턴하는 메소드
	public static Connection getConnection(String databaseName) throws SQLException, NamingException {
		if (dataSource == null) {
			InitialContext context = new InitialContext();
			//context.xml에 등록된 정보로 DB를 연결하여 객체에 저장하고 리턴함
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/" + databaseName);
		}
		return dataSource.getConnection();
	}
}