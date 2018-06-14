package lab;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
	public static List<Category> findAll() throws Exception {
        String sql = "SELECT * FROM category";
        try (Connection connection = DB.getConnection("sakila");
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            ArrayList<Category> list = new ArrayList<Category>();
            while (resultSet.next()) {
            	Category category = new Category();
               	category.setId(resultSet.getInt("category_id"));
               	category.setName(resultSet.getString("name"));
                list.add(category);
            }
            return list;
        }
    }
	
	public static String findOne(int id) throws Exception {
        String sql = "SELECT *"
        		+ " from category"
        		+ " WHERE category_id=?";
        try (Connection connection = DB.getConnection("sakila");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getString("name");
                }
            }
            return null;
        }
    }
	
	public static int findOne(String name) throws Exception {
        String sql = "SELECT *"
        		+ " from category"
        		+ " WHERE name=?";
        try (Connection connection = DB.getConnection("sakila");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("category_id");
                }
            }
            return 0;
        }
    }
}
