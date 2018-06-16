package Lab;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CityDAO {
	public static List<City> findAll(int currentPage, int pageSize, String ss, String st, String od) 
			throws Exception {
		String sql = "call city_findAll(?, ?, ?, ?, ?)";
		try (Connection connection = DB.getConnection("world");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, (currentPage - 1) * pageSize); 
			statement.setInt(2, pageSize);                   
			statement.setString(3, ss);                        
			statement.setString(4, st + "%");                  
			statement.setString(5, od);                  
			try (ResultSet resultSet = statement.executeQuery()) {
				ArrayList<City> list = new ArrayList<City>();
				while (resultSet.next()) {
					City city = new City();
					city.setId(resultSet.getInt("ID"));
					city.setName(resultSet.getString("Name"));
					city.setCountryCode(resultSet.getString("CountryCode"));
					city.setDistrict(resultSet.getString("District"));
					city.setPopulation(resultSet.getInt("Population"));
					city.setCountry(resultSet.getString("Country"));
					city.setCapital(city.getId()==resultSet.getInt("Capital"));
					list.add(city);
				}
				return list;
			}
		}
	}
	
	public static City findOne(int id) throws Exception {
        String sql = "select ct.*, c.Name Country, c.Capital" + 
        		" from city ct left join country c on ct.CountryCode=c.Code" + 
        		" where ID = ?";
        try (Connection connection = DB.getConnection("world");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                	City city = new City();
                	city.setId(resultSet.getInt("ID"));
					city.setName(resultSet.getString("Name"));
					city.setCountryCode(resultSet.getString("CountryCode"));
					city.setDistrict(resultSet.getString("District"));
					city.setPopulation(resultSet.getInt("Population"));
					city.setCountry(resultSet.getString("Country"));
					city.setCapital(city.getId()==resultSet.getInt("Capital"));
                    return city;
                }
            }
            return null;
        }
    }
	
	public static int count(String ss, String st) throws Exception {
        String sql = "call city_count(?, ?)";
        try (Connection connection = DB.getConnection("world");
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
	
	public static int findId(String name) throws Exception {
		String sql = "SELECT * from city where Name=?";
		try (Connection connection = DB.getConnection("world");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, name);
			try(ResultSet resultSet = statement.executeQuery()){
				if(resultSet.next()) return resultSet.getInt("ID");
			}
		}
		return 0;
	}
	
	public static void update(City city) throws Exception{
		String sql = "UPDATE city set Name=?, CountryCode=?, District=?, Population=?"+
				" where ID=?";
		try(Connection connection = DB.getConnection("world");
				PreparedStatement statement = connection.prepareStatement(sql)){
			statement.setString(1, city.getName());
			statement.setString(2, city.countryCode);
			statement.setString(3, city.getDistrict());
			statement.setInt(4, city.getPopulation());
			statement.setInt(5, city.getId());
			statement.executeUpdate();
		}
		
		int capitalId=0;
		sql="select Capital from country where CODE=?";
		try (Connection connection = DB.getConnection("world");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, city.countryCode);
			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					capitalId= resultSet.getInt("Capital");
				}
			}
		}
		
		if(capitalId==city.getId()) {
			if(!city.isCapital()) {
				sql="UPDATE country set Capital=? where CODE=?";
				try(Connection connection = DB.getConnection("world");
						PreparedStatement statement = connection.prepareStatement(sql)){
					statement.setInt(1, 0);
					statement.setString(2, city.countryCode);
					statement.executeUpdate();
				}
			}
		}else {
			if(city.isCapital()) {
				sql="UPDATE country set Capital=? where CODE=?";
				try(Connection connection = DB.getConnection("world");
						PreparedStatement statement = connection.prepareStatement(sql)){
					statement.setInt(1, city.getId());
					statement.setString(2, city.countryCode);
					statement.executeUpdate();
				}
			}
		}
	}
	
	
	public static boolean findCountry(String name) throws Exception {
		String sql = "SELECT * from country where CODE=?";
		try (Connection connection = DB.getConnection("world");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, name);
			try(ResultSet resultSet = statement.executeQuery()){
				if(resultSet.next()) return true;
			}
		}
		return false;
	}
	
	public static void insert(City city) throws Exception {
		String sql = "INSERT city (Name, CountryCode, District, Population)" +
				" VALUES (?, ?, ?, ?)";
		try (Connection connection = DB.getConnection("world");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, city.getName());
			statement.setString(2, city.getCountryCode());
			statement.setString(3, city.getDistrict());
			statement.setInt(4, city.getPopulation());
			statement.executeUpdate();
		}
		
		if(city.isCapital()==true) {
			city.setId(findId(city.getName()));
			sql = "UPDATE country set Capital = ?"+
				" where Code = ?";
			try (Connection connection = DB.getConnection("world");
					PreparedStatement statement = connection.prepareStatement(sql)) {
				statement.setInt(1, city.getId());
				statement.setString(2, city.getCountryCode());
				statement.executeUpdate();
			}
		}
	}
	
	public static void delete(int id) throws Exception {
		String sql = "DELETE FROM city WHERE ID = ?";
        try (Connection connection = DB.getConnection("world");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
	}
}
