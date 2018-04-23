package jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jdbc.DB;
import jdbc.Category;

public class CategoryDAO {

	public static List<Category> findAll() throws Exception {
		String sql = "SELECT * " +
				"FROM category";
		try (Connection connection = DB.getConnection("product");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<Category> list = new ArrayList<Category>();
			while (resultSet.next()) {
				Category c = new Category();
				c.setId(resultSet.getInt("id"));
				c.setName(resultSet.getString("name"));
				list.add(c);
			}
			return list;
		}
	}
}
