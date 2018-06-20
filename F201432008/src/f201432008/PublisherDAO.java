package f201432008;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PublisherDAO {
	public static String findOne(int id) throws Exception {
        String sql = "SELECT *"
        		+ " from publisher"
        		+ " WHERE id=?";
        try (Connection connection = DB.getConnection("book2");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getString("title");
                }
            }
            return null;
        }
    }
	
	public static List<Publisher> findAll() throws Exception {
        String sql = "SELECT * FROM publisher";
        try (Connection connection = DB.getConnection("book2");
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            ArrayList<Publisher> list = new ArrayList<Publisher>();
            while (resultSet.next()) {
            	Publisher p = new Publisher();
               	p.setId(resultSet.getInt("id"));
               	p.setTitle(resultSet.getString("title"));
                list.add(p);
            }
            return list;
        }
    }
}
