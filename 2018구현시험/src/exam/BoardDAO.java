package exam;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BoardDAO {
	public static String findOne(int id) throws Exception {
        String sql = "SELECT boardName FROM board where id=?";
        try (Connection connection = DB.getConnection("bbs2");
             PreparedStatement statement = connection.prepareStatement(sql)){
        	statement.setInt(1, id);
        	try(ResultSet resultSet = statement.executeQuery()){
        		resultSet.next();
        		 String name ="";
                 name=resultSet.getString("boardName");
                 return name;
        	}
        }
	}
}
