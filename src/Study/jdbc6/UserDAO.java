package Study.jdbc6;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import lecture1.DB;

public class UserDAO {
	
	public static ArrayList<User> findByName(String name, int currentPage, int pageSize, String od) throws Exception {
        String order="ID";
        switch (od) {
        case "1": order = "departmentId"; break;
        case "2": order = "userType"; break;
        }
		String sql = "SELECT u.*, d.departmentName" +
                     " FROM user u LEFT JOIN department d ON u.departmentId = d.id" +
                     " WHERE name LIKE ?" +
                     " ORDER BY " + order +
                     " LIMIT ?, ?";
        try (Connection connection = DB.getConnection("student1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name + "%");
            statement.setInt(2, (currentPage - 1) * pageSize);
            statement.setInt(3, pageSize);
            try (ResultSet resultSet = statement.executeQuery()) {
                ArrayList<User> list = new ArrayList<User>();
                while (resultSet.next()) {
                	User user = new User();
					user.setId(resultSet.getInt("id"));
					user.setUserid(resultSet.getString("userid"));
					user.setPassword(resultSet.getString("password"));
					user.setName(resultSet.getString("name"));
					user.setEmail(resultSet.getString("email"));
					user.setEnabled(resultSet.getBoolean("enabled"));
					user.setDepartmentId(resultSet.getInt("departmentId"));
					user.setUserType(resultSet.getString("userType"));
					list.add(user);
                }
                return list;
            }
        }
	}
	
	public static int count(String name) throws Exception {
		String sql = "SELECT COUNT(*) FROM user WHERE name LIKE ?";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, name + "%");
			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next())
					return resultSet.getInt(1);
			}
		}
		return 0;
	}


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
					user.setPassword(resultSet.getString("password"));
					user.setName(resultSet.getString("name"));
					user.setEmail(resultSet.getString("email"));
					user.setEnabled(resultSet.getBoolean("enabled"));
					user.setDepartmentId(resultSet.getInt("departmentId"));
					user.setUserType(resultSet.getString("userType"));
					list.add(user);
				}
				return list;
			}
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
					user.setPassword(resultSet.getString("password"));
					user.setName(resultSet.getString("name"));
					user.setEmail(resultSet.getString("email"));
					user.setEnabled(resultSet.getBoolean("enabled"));
					user.setDepartmentId(resultSet.getInt("departmentId"));
					user.setUserType(resultSet.getString("userType"));
                    return user;
                }
            }
            return null;
        }
    }

    public static void update(User user) throws Exception {
        String sql = "UPDATE user SET userid=?,  password=?, name=?,email=?, departmentId=?,enabled=?, userType=? " +
                     " WHERE id = ?";
        try (Connection connection = DB.getConnection("student1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1,user.getUserid());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getName());
            statement.setString(4, user.getEmail());
            statement.setInt(5, user.getDepartmentId());
            statement.setBoolean(6, user.isEnabled());
            statement.setString(7, user.getUserType());
            statement.setInt(8, user.getId());
            statement.executeUpdate();
        }
    }
    
    public static void insert(User user) throws Exception{
    	String sql ="INSERT user(userid,password,name,email,departmentId,enabled,userType)"+
    			"VALUES(?,?,?,?,?,?,?)";
    	try(Connection connection = DB.getConnection("student1");
    			PreparedStatement statement = connection.prepareStatement(sql)){
    		statement.setString(1, user.getUserid());
    		statement.setString(2, user.getPassword());
    		statement.setString(3, user.getName());
    		statement.setString(4, user.getEmail());
    		statement.setInt(5, user.getDepartmentId());
    		statement.setBoolean(6, user.isEnabled());
    		statement.setString(7, user.getUserType());
    		statement.executeUpdate();
    	}
    }
    
    public static void delete(int id) throws Exception {
        String sql = "DELETE FROM user WHERE id = ?";
        try (Connection connection = DB.getConnection("student1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }
}
