package Study.jdbc3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import lecture1.DB;

public class UserDAO {
	
	public static List<User> findAll(int currentPage,int pageSize) throws Exception {
		String sql = "SELECT * " +
				"FROM user " +
				"LIMIT ?, ?";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)){
			statement.setInt(1, (currentPage-1)*pageSize);
			statement.setInt(2, pageSize);
			try(ResultSet resultSet = statement.executeQuery()){
				ArrayList<User> list = new ArrayList<User>();
				while (resultSet.next()) {
					User user = new User();
					user.setId(resultSet.getInt("id"));
					user.setUserid(resultSet.getString("userid"));
					user.setName(resultSet.getString("name"));
					user.setEmail(resultSet.getString("email"));
					user.setDepartmentId(resultSet.getInt("departmentId"));
					user.setUserType(resultSet.getString("userType"));
					list.add(user);
				}
				return list;
			}
		}
	}

	public static int count() throws Exception {
		String sql = "SELECT count(*) FROM user";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			if(resultSet.next()) {
				return resultSet.getInt(1);//다음 레코드가 존재하면 숫자하나를 더 얻는다
			}
			return 0;
		}
	}
	
	public static User findOne(int id) throws Exception {
        String sql = "SELECT * FROM user WHERE id=?";
        try (Connection connection = DB.getConnection("student1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                	User user = new User();
					user.setId(resultSet.getInt("id"));
					user.setUserid(resultSet.getString("userid"));
					user.setName(resultSet.getString("name"));
					user.setEmail(resultSet.getString("email"));
					user.setDepartmentId(resultSet.getInt("departmentId"));
					user.setUserType(resultSet.getString("userType"));
                    return user;
                }
            }
            return null;
        }
    }

    public static void update(User user) throws Exception {
        String sql = "UPDATE user SET userid=?, name=?, email=?, departmentId=?, userType=? " +
                     " WHERE id = ?";
        try (Connection connection = DB.getConnection("student1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1,user.getUserid());
            statement.setString(2, user.getName());
            statement.setString(3, user.getEmail());
            statement.setInt(4, user.getDepartmentId());
            statement.setString(5, user.getUserType());
            statement.setInt(6, user.getId());
            statement.executeUpdate();
        }
    }
}
