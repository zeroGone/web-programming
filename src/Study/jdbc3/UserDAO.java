package Study.jdbc3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import lecture1.DB;

public class UserDAO {
	
	public static List<User> findAll(int currentPage,int pageSize) throws Exception {
		String sql = "SELECT u.*, d.departmentName " +
				"FROM user u left join department d on u.departmentId=d.id " +
				"LIMIT ?, ?;";
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
					user.setPassword(resultSet.getString("password"));
					user.setName(resultSet.getString("name"));
					user.setEmail(resultSet.getString("email"));
					user.setDepartmentId(resultSet.getInt("departmentId"));
					user.setEnabled(resultSet.getBoolean("enabled"));
					user.setUserType(resultSet.getString("userType"));
					user.setDepartmentName(resultSet.getString("departmentName"));
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
        String sql = "SELECT u.*, d.departmentName "+
        		"FROM user u left join department d on u.departmentId=d.id "+
        		"WHERE u.id=?";
        try (Connection connection = DB.getConnection("student1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                	User user = new User();
                	user.setId(resultSet.getInt("id"));
					user.setUserid(resultSet.getString("userid"));
					user.setPassword(resultSet.getString("password"));
					user.setName(resultSet.getString("name"));
					user.setEmail(resultSet.getString("email"));
					user.setDepartmentId(resultSet.getInt("departmentId"));
					user.setEnabled(resultSet.getBoolean("enabled"));
					user.setUserType(resultSet.getString("userType"));
					user.setDepartmentName(resultSet.getString("departmentName"));
                    return user;
                }
            }
            return null;
        }
    }

    public static void update(User user) throws Exception {
        String sql = "UPDATE user SET userid=?, password=?, name=?, email=?, enabled=?, departmentId=?, userType=? " +
                     " WHERE id = ?";
        try (Connection connection = DB.getConnection("student1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1,user.getUserid());
            statement.setString(2,user.getPassword());
            statement.setString(3, user.getName());
            statement.setString(4, user.getEmail());
            statement.setBoolean(5, user.isEnabled());
            statement.setInt(6, user.getDepartmentId());
            statement.setString(7, user.getUserType());
            statement.setInt(8, user.getId());
            statement.executeUpdate();
        }
    }
}
