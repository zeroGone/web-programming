package lab;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LanguageDAO {
	public static List<Language> findAll() throws Exception {
        String sql = "SELECT * FROM language";
        try (Connection connection = DB.getConnection("sakila");
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            ArrayList<Language> list = new ArrayList<Language>();
            while (resultSet.next()) {
            	Language l = new Language();
               	l.setId(resultSet.getInt("language_id"));
               	l.setName(resultSet.getString("name"));
                list.add(l);
            }
            return list;
        }
    }
	
	public static String findOne(int id) throws Exception {
        String sql = "SELECT *"
        		+ " from language"
        		+ " WHERE language_id=?";
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
}
