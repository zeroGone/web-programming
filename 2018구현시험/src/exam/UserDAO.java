package exam;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	public static String findOne(int id) throws Exception {
        String sql = "SELECT name FROM user where id=?";
        try (Connection connection = DB.getConnection("bbs2");
             PreparedStatement statement = connection.prepareStatement(sql)){
        	statement.setInt(1, id);
        	try(ResultSet resultSet = statement.executeQuery()){
        		resultSet.next();
        		 String name ="";
                 name=resultSet.getString("name");
                 return name;
        	}
        }
	}
	
	public static List<User> findAll() throws Exception {
        String sql = "SELECT * FROM user";
        try (Connection connection = DB.getConnection("bbs2");
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            ArrayList<User> list = new ArrayList<User>();
            while (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                list.add(user);
            }
            return list;
        }
    }
}
