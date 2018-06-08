package exam;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	
	public static List<Board> findAll() throws Exception {
        String sql = "SELECT * FROM board";
        try (Connection connection = DB.getConnection("bbs2");
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            ArrayList<Board> list = new ArrayList<Board>();
            while (resultSet.next()) {
            	Board board = new Board();
               	board.setId(resultSet.getInt("id"));
               	board.setBoardName(resultSet.getString("boardName"));
                list.add(board);
            }
            return list;
        }
    }
}
