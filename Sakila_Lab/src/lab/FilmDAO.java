package lab;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class FilmDAO {
	public static List<Film> findAll(int currentPage, int pageSize, String ss, String st, String od) 
			throws Exception {
		String sql = "call film_findAll(?, ?, ?, ?, ?)";
		try (Connection connection = DB.getConnection("sakila");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, (currentPage - 1) * pageSize); 
			statement.setInt(2, pageSize);                   
			statement.setString(3, ss);                        
			statement.setString(4, st + "%");                  
			statement.setString(5, od);                       
			try (ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Film> list = new ArrayList<Film>();
				while (resultSet.next()) {
					Film film = new Film();
					film.setId(resultSet.getInt("film_id"));
					film.setTitle(resultSet.getString("title"));
					film.setDescription(resultSet.getString("description"));
					film.setReleaseYear(resultSet.getInt("release_year"));
					film.setRentalDuration(resultSet.getInt("rental_duration"));
					film.setRentalRate(resultSet.getDouble("rental_rate"));
					film.setSpecialFeatures(resultSet.getString("special_features"));
					film.setLength(resultSet.getInt("length"));
					film.setLastUpdate(resultSet.getTimestamp("last_update"));
					film.setCategory(resultSet.getString("category"));
					film.setLanguageId(resultSet.getInt("language_id"));
					
					list.add(film);
				}
				return list;
			}
		}
	}
	
	public static Film findOne(int id) throws Exception {
        String sql = "select f.*, c.name category , l.name language" + 
        		" from film f left join film_category fc on f.film_id=fc.film_id" + 
        		" left join category c on fc.category_id=c.category_id" + 
        		" left join language l on f.language_id=l.language_id" + 
        		" where f.film_id = ? ";
        try (Connection connection = DB.getConnection("sakila");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                	Film film = new Film();
					film.setId(resultSet.getInt("film_id"));
					film.setTitle(resultSet.getString("title"));
					film.setDescription(resultSet.getString("description"));
					film.setReleaseYear(resultSet.getInt("release_year"));
					film.setRentalDuration(resultSet.getInt("rental_duration"));
					film.setRentalRate(resultSet.getDouble("rental_rate"));
					film.setSpecialFeatures(resultSet.getString("special_features"));
					film.setLength(resultSet.getInt("length"));
					film.setLastUpdate(resultSet.getTimestamp("last_update"));
					film.setCategory(resultSet.getString("category"));
					film.setLanguageId(resultSet.getInt("language_id"));
                    return film;
                }
            }
            return null;
        }
    }
	
	public static int count(String ss, String st) throws Exception {
        String sql = "call film_count(?, ?)";
        try (Connection connection = DB.getConnection("sakila");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, ss); 
            statement.setString(2, st + "%");  
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next())
                    return resultSet.getInt(1);
            }
        }
        return 0;
    }
	
	public static void update(Film film,int categoryId) throws Exception {
		String sql = "UPDATE film SET title=?, description=?, release_year=?, language_id=?, rental_duration=?, rental_rate=?, length=?, special_features=?, last_update=?" +
				" WHERE film_id = ?";
		try (Connection connection = DB.getConnection("sakila");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, film.getTitle());
			statement.setString(2, film.getDescription());
			statement.setInt(3, film.getReleaseYear());
			statement.setInt(4, film.getLanguageId());
			statement.setInt(5, film.getRentalDuration());
			statement.setDouble(6, film.getRentalRate());
			statement.setInt(7, film.getLength());
			statement.setString(8, film.getSpecialFeatures());
			statement.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
			statement.setInt(10, film.getId());
			statement.executeUpdate();
		}
		
		sql = "UPDATE film_category set category_id=?" +
				" WHERE id = ?";
		try (Connection connection = DB.getConnection("sakila");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, categoryId);
			statement.setInt(2, film.getId());
			statement.executeUpdate();
		}
	}
	
}
