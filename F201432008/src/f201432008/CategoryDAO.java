package f201432008;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
	public static String findOne(int id) throws Exception {
        String sql = "SELECT *"
        		+ " from category"
        		+ " WHERE id=?";
        try (Connection connection = DB.getConnection("book2");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getString("categoryName");
                }
            }
            return null;
        }
    }
	
	public static List<Category> findAll() throws Exception {
        String sql = "SELECT * FROM category";
        try (Connection connection = DB.getConnection("book2");
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            ArrayList<Category> list = new ArrayList<Category>();
            while (resultSet.next()) {
            	Category c = new Category();
               	c.setId(resultSet.getInt("id"));
               	c.setCategoryName(resultSet.getString("categoryName"));
                list.add(c);
            }
            return list;
        }
    }
}
