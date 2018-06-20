package f201432008;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
	public static Book createBook(ResultSet resultSet) throws Exception {
		Book book = new Book();
		book.setId(resultSet.getInt("ID"));
		book.setTitle(resultSet.getString("title"));
		book.setAuthor(resultSet.getString("author"));
		book.setCategoryId(resultSet.getInt("categoryId"));
		book.setPrice(resultSet.getInt("price"));
		book.setAvailable(resultSet.getBoolean("available"));
		book.setPublisherId(resultSet.getInt("publisherId"));
		return book;
	}

	public static List<Book> findAll1() throws Exception {
		String sql = "select b.*, c.categoryName, p.title publisherName " + 
				"from book b left join category c on b.categoryId=c.id " + 
				"left join publisher p on b.publisherId=p.id "+
				"order by b.id";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<Book> list = new ArrayList<Book>();
			while (resultSet.next()) {
				list.add(createBook(resultSet));
			}
			return list;
		}
	}

	public static List<Book> findAll2(int currentPage, int pageSize) throws Exception {
		String sql = "select b.*, c.categoryName, p.title publisherName " + 
				"from book b left join category c on b.categoryId=c.id " + 
				"left join publisher p on b.publisherId=p.id "+
				"order by b.id "+
				"LIMIT ?, ?";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, (currentPage - 1) * pageSize);
			statement.setInt(2, pageSize);
			try (ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Book> list = new ArrayList<Book>();
				while (resultSet.next()) {
					list.add(createBook(resultSet));
				}
				return list;
			}
		}
	}
	
	public static List<Book> findAll(int currentPage, int pageSize, String ss, String st) 
			throws Exception {
		String sql = "call book_findAll(?, ?, ?, ?)";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, (currentPage - 1) * pageSize); 
			statement.setInt(2, pageSize);                   
			statement.setString(3, ss);    
			if(ss.equals("1")) statement.setString(4, st+"%");            
			else statement.setString(4, st);            
			try (ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Book> list = new ArrayList<Book>();
				while (resultSet.next()) {
					list.add(createBook(resultSet));
				}
				return list;
			}
		}
	}
	
	public static void update(Book book) throws Exception {
		String sql = "UPDATE book SET title=?, author=?, categoryId=?, price=?, publisherId=?, available=?" +
				" WHERE id = ?";
		try (Connection connection = DB.getConnection("book2");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, book.getTitle());
			statement.setString(2, book.getAuthor());
			statement.setInt(3, book.getCategoryId());
			statement.setInt(4, book.getPrice());
			statement.setInt(5, book.getPublisherId());
			statement.setBoolean(6, book.isAvailable());
			statement.setInt(7, book.getId());
			statement.executeUpdate();
		}
	}
	
	public static void delete(int id) throws Exception {
		String sql = "DELETE FROM book WHERE id = ?";
        try (Connection connection = DB.getConnection("book2");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
	}
		
	
	public static Book findOne(int id) throws Exception {
        String sql = "select b.*, c.categoryName, p.title publisherName " + 
				"from book b left join category c on b.categoryId=c.id " + 
				"left join publisher p on b.publisherId=p.id "+
				"where b.id = ?";
        try (Connection connection = DB.getConnection("book2");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                	Book book = createBook(resultSet);
                    return book;
                }
            }
            return null;
        }
    }
	
	public static int count(String ss, String st) throws Exception {
        String sql = "call book_count(?, ?)";
        try (Connection connection = DB.getConnection("book2");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, ss); 
            if(ss.equals("1")) statement.setString(2, st+"%");            
			else statement.setString(2, st);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next())
                    return resultSet.getInt(1);
            }
        }
        return 0;
    }
}
