/*학과정보와 유저정보를 같이찾을수 있도록 해주는 userDAO*/
package Study.jdbc1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Study.jdbc1.DB;

public class UserDAO2 {
	public static String sql = "SELECT * FROM USER ";

	public static User createUser(ResultSet resultSet) throws SQLException {
		User user = new User();
		user.setUserid(resultSet.getString("userid"));
		user.setName(resultSet.getString("name"));
		user.setEmail(resultSet.getString("email"));
		user.setUserType(resultSet.getString("userType"));
		user.setDepartmentId(resultSet.getInt("departmentId"));
		return user;
	}

	public static List<User> findAll() throws Exception {
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<User> list = new ArrayList<User>();
			while (resultSet.next()) {
				list.add(createUser(resultSet));
			}
			return list;
		}
	}

	public static List<User> find(String name, int id) throws Exception {
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection
						.prepareStatement(sql + " where name LIKE ? and departmentId = ?")) {// 학생이름과 학과아이디를 둘다 충족하게 하는
																								// 조건문을 건다
			statement.setString(1, name + "%");
			statement.setInt(2, id);
			try (ResultSet resultSet = statement.executeQuery()) {
				ArrayList<User> list = new ArrayList<User>();
				while (resultSet.next()) {
					list.add(createUser(resultSet));
				}
				return list;
			}
		}
	}

}
