
package Study.jdbc1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Study.jdbc1.DB;

public class UserDAO {
	
	public static List<User> findAll() throws Exception {
		String sql = "SELECT s.*, d.departmentName " +
				"FROM user s LEFT JOIN department d ON s.departmentId = d.id";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<User> list = new ArrayList<User>();
			while (resultSet.next()) {
				User user = new User();
				user.setUserid(resultSet.getString("id"));
				user.setName(resultSet.getString("name"));
				user.setEmail(resultSet.getString("email"));
				user.setDepartmentName(resultSet.getString("departmentId"));
				user.setUserType(resultSet.getString("userType"));
				list.add(user);
			}
			return list;
		}
	}
}
